//===-- LaneBasedExecutionQueue.cpp ---------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014-2018 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#include "llbuild/Basic/ExecutionQueue.h"

#include "llbuild/Basic/Tracing.h"

#include "llvm/ADT/ArrayRef.h"
#include "llvm/ADT/SmallString.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/ADT/Twine.h"

#include <atomic>
#include <future>
#include <queue>
#include <random>
#include <unordered_map>
#include <vector>

#include <signal.h>

#ifdef __APPLE__
#include <pthread/spawn.h>
#endif

using namespace llbuild;
using namespace llbuild::basic;

struct QueueJobLess {
  bool operator()(const llbuild::basic::QueueJob &__x,
                  const llbuild::basic::QueueJob &__y) const {
    return __x.getDescriptor()->getOrdinalName() <
            __y.getDescriptor()->getOrdinalName();
  }
};

namespace {

struct LaneBasedExecutionQueueJobContext : public QueueJobContext {
  uint64_t jobID;
  uint64_t laneNumber;

  QueueJob& job;

  LaneBasedExecutionQueueJobContext(
      uint64_t jobID, uint64_t laneNumber, QueueJob& job)
          : jobID(jobID), laneNumber(laneNumber), job(job) {}

  unsigned laneID() const override { return laneNumber; }
};


class Scheduler {
public:
  virtual ~Scheduler() { }

  virtual void addJob(QueueJob job) = 0;
  virtual QueueJob getNextJob() = 0;
  virtual bool empty() const = 0;
  virtual uint64_t size() const = 0;

  static std::unique_ptr<Scheduler> make(SchedulerAlgorithm alg);
};

/// Build execution queue.
//
// FIXME: Consider trying to share this with the Ninja implementation.
class LaneBasedExecutionQueue : public ExecutionQueue {
  /// (Random) build identifier
  uint32_t buildID;

  /// The number of lanes the queue was configured with.
  unsigned numLanes;

  /// A thread for each lane.
  std::vector<std::unique_ptr<std::thread>> lanes;

  /// The ready queue of jobs to execute.
  std::unique_ptr<Scheduler> readyJobs;
  std::mutex readyJobsMutex;
  std::condition_variable readyJobsCondition;
  bool cancelled { false };
  bool shutdown { false };

  ProcessGroup spawnedProcesses;

  /// Management of cancellation and SIGKILL escalation
  std::mutex killAfterTimeoutThreadMutex;
  std::unique_ptr<std::thread> killAfterTimeoutThread = nullptr;
  std::condition_variable queueCompleteCondition;
  std::mutex queueCompleteMutex;
  bool queueComplete { false };

  /// Background (lane released) task management
  unsigned backgroundTaskMax = 0;
  std::atomic<unsigned> backgroundTaskCount{0};


  /// The base environment.
  const char* const* environment;

  void executeLane(uint32_t buildID, uint32_t laneNumber) {
    // Set the thread name, if available.
#if defined(__APPLE__)
    pthread_setname_np(
        (llvm::Twine("org.swift.llbuild Lane-") +
         llvm::Twine(laneNumber)).str().c_str());
#elif defined(__linux__)
    pthread_setname_np(
        pthread_self(),
        (llvm::Twine("org.swift.llbuild Lane-") +
         llvm::Twine(laneNumber)).str().c_str());
#endif

    // Set the QoS class, if available.
    setCurrentThreadQualityOfService(getDefaultQualityOfService());

    // Lane ID, used in creating reasonably unique task IDs, stores the buildID
    // in the top 32 bits.  The laneID is stored in bits 16:31, and the job
    // count is placed in the lower order 16 bits. These are not strictly
    // guaranteed to be unique, but should be close enough for common use cases.
    uint32_t jobCount = 0;
    uint64_t laneID = (((uint64_t)buildID & 0xFFFF) << 32) + (((uint64_t)laneNumber & 0xFFFF) << 16);

    // Execute items from the queue until shutdown.
    while (true) {
      // Take a job from the ready queue.
      QueueJob job{};
      uint64_t readyJobsCount;
      {
        std::unique_lock<std::mutex> lock(readyJobsMutex);

        // While the queue is empty, wait for an item.
        while (!shutdown && readyJobs->empty()) {
          readyJobsCondition.wait(lock);
        }
        if (shutdown && readyJobs->empty())
          return;

        // Take an item according to the chosen policy.
        job = readyJobs->getNextJob();
        readyJobsCount = readyJobs->size();
      }

      // If we got an empty job, the queue is shutting down.
      if (!job.getDescriptor())
        break;

      // Process the job.
      jobCount++;
      uint64_t jobID = laneID + jobCount;
      LaneBasedExecutionQueueJobContext context{ jobID, laneNumber, job };
      {
        TracingExecutionQueueDepth(readyJobsCount);

        llvm::SmallString<64> description;
        job.getDescriptor()->getShortDescription(description);
        TracingExecutionQueueJob t(context.laneNumber, description.str());

        getDelegate().queueJobStarted(job.getDescriptor());
        job.execute(reinterpret_cast<QueueJobContext*>(&context));
        getDelegate().queueJobFinished(job.getDescriptor());
      }
    }
  }

  void killAfterTimeout() {
    std::unique_lock<std::mutex> lock(queueCompleteMutex);

    if (!queueComplete) {
      // Shorten timeout if in testing context
      if (getenv("LLBUILD_TEST") != nullptr) {
        queueCompleteCondition.wait_for(lock, std::chrono::milliseconds(1000));
      } else {
        queueCompleteCondition.wait_for(lock, std::chrono::seconds(10));
      }

#if _WIN32
      spawnedProcesses.signalAll(SIGTERM);
#else
      spawnedProcesses.signalAll(SIGKILL);
#endif
    }
  }

public:
  LaneBasedExecutionQueue(ExecutionQueueDelegate& delegate,
                          unsigned numLanes, SchedulerAlgorithm alg,
                          const char* const* environment)
  : ExecutionQueue(delegate), buildID(std::random_device()()), numLanes(numLanes),
        readyJobs(Scheduler::make(alg)), environment(environment)
  {
    backgroundTaskMax = numLanes * 16;
    for (unsigned i = 0; i != numLanes; ++i) {
      lanes.push_back(std::unique_ptr<std::thread>(
                          new std::thread(
                              &LaneBasedExecutionQueue::executeLane, this, buildID, i)));
    }
  }

  virtual ~LaneBasedExecutionQueue() {
    // Shut down the lanes.
    {
      std::unique_lock<std::mutex> lock(readyJobsMutex);
      shutdown = true;
      readyJobsCondition.notify_all();
    }

    for (unsigned i = 0; i != numLanes; ++i) {
      lanes[i]->join();
    }

    {
      std::lock_guard<std::mutex> guard(killAfterTimeoutThreadMutex);
      if (killAfterTimeoutThread) {
        {
          std::unique_lock<std::mutex> lock(queueCompleteMutex);
          queueComplete = true;
          queueCompleteCondition.notify_all();
        }
        killAfterTimeoutThread->join();
      }
    }
  }

  virtual void addJob(QueueJob job) override {
    uint64_t readyJobsCount;
    {
      std::lock_guard<std::mutex> guard(readyJobsMutex);
      readyJobs->addJob(job);
      readyJobsCondition.notify_one();
      readyJobsCount = readyJobs->size();
    }
    TracingExecutionQueueDepth(readyJobsCount);
  }

  virtual void cancelAllJobs() override {
    {
      std::lock_guard<std::mutex> lock(readyJobsMutex);
      std::lock_guard<std::mutex> guard(spawnedProcesses.mutex);
      if (cancelled) return;
      cancelled = true;
      spawnedProcesses.close();
      readyJobsCondition.notify_all();
    }

    spawnedProcesses.signalAll(SIGINT);
    {
      std::lock_guard<std::mutex> guard(killAfterTimeoutThreadMutex);
      killAfterTimeoutThread = llvm::make_unique<std::thread>(
          &LaneBasedExecutionQueue::killAfterTimeout, this);
    }
  }

  virtual void executeProcess(
      QueueJobContext* opaqueContext,
      ArrayRef<StringRef> commandLine,
      ArrayRef<std::pair<StringRef, StringRef>> environment,
      bool inheritEnvironment,
      ProcessAttributes attributes,
      llvm::Optional<ProcessCompletionFn> completionFn) override {

    LaneBasedExecutionQueueJobContext& context =
      *reinterpret_cast<LaneBasedExecutionQueueJobContext*>(opaqueContext);

    llvm::SmallString<64> description;
    context.job.getDescriptor()->getShortDescription(description);
    TracingExecutionQueueSubprocessStart(context.laneNumber, description.str());

    {
      std::unique_lock<std::mutex> lock(readyJobsMutex);
      // Do not execute new processes anymore after cancellation.
      if (cancelled) {
        completionFn.unwrapIn([](ProcessCompletionFn fn){
          fn(ProcessResult::makeCancelled());
        });
        return;
      }
    }

    // Form the complete environment.
    //
    // NOTE: We construct the environment in order of precedence, so
    // overridden keys should be defined first.
    POSIXEnvironment posixEnv;

    // Export lane ID to subprocesses.
    posixEnv.setIfMissing("LLBUILD_BUILD_ID", Twine(buildID).str());
    posixEnv.setIfMissing("LLBUILD_LANE_ID", Twine(context.laneNumber).str());

    // Add the requested environment.
    for (const auto& entry: environment) {
      posixEnv.setIfMissing(entry.first, entry.second);
    }

    // Inherit the base environment, if desired.
    //
    // FIXME: This involves a lot of redundant allocation, currently. We could
    // cache this for the common case of a directly inherited environment.
    if (inheritEnvironment) {
      for (const char* const* p = this->environment; *p != nullptr; ++p) {
        auto pair = StringRef(*p).split('=');
        posixEnv.setIfMissing(pair.first, pair.second);
      }
    }

    // Assign a process handle, which just needs to be unique for as long as we
    // are communicating with the delegate.
    ProcessHandle handle;
    handle.id = context.jobID;

    ProcessReleaseFn releaseFn = [this](std::function<void()>&& processWait) {
      bool releaseAllowed = false;
      // This check is not guaranteed to prevent more than backgroundTaskMax
      // tasks from releasing. We could race between the check and increment and
      // thus have a few extra. However, for our purposes, this should be fine.
      // The cap is primarly intended to prevent runaway explosions of tasks.
      if (backgroundTaskCount < backgroundTaskMax) {
        backgroundTaskCount++;
        releaseAllowed = true;
      }
      if (releaseAllowed) {
        // Launch the process wait on a detached thread
        std::thread([this, processWait=std::move(processWait)]() mutable {
          processWait();
          backgroundTaskCount--;
        }).detach();
      } else {
        // not allowed to release, call wait directly
        processWait();
      }
    };

    ProcessCompletionFn laneCompletionFn{
      [completionFn, lane=context.laneNumber](ProcessResult result) mutable {
        TracingExecutionQueueSubprocessResult(lane, result.pid, result.utime,
                                              result.stime, result.maxrss);
        completionFn.unwrapIn([result](ProcessCompletionFn fn){
          fn(result);
        });
      }
    };

    spawnProcess(
        getDelegate(),
        reinterpret_cast<ProcessContext*>(context.job.getDescriptor()),
        spawnedProcesses,
        handle,
        commandLine,
        posixEnv,
        attributes,
        std::move(releaseFn),
        std::move(laneCompletionFn)
    );
  }
};

class PriorityQueueScheduler : public Scheduler {
private:
  std::priority_queue<QueueJob, std::vector<QueueJob>, QueueJobLess> jobs;

public:
  void addJob(QueueJob job) override {
    jobs.push(job);
  }

  QueueJob getNextJob() override {
    QueueJob job = jobs.top();
    jobs.pop();
    return job;
  }

  bool empty() const override {
    return jobs.empty();
  }

  uint64_t size() const override {
    return jobs.size();
  }
};

class FifoScheduler : public Scheduler {
private:
  std::deque<QueueJob> jobs;

public:
  void addJob(QueueJob job) override {
    jobs.push_back(job);
  }

  QueueJob getNextJob() override {
    QueueJob job = jobs.front();
    jobs.pop_front();
    return job;
  }

  bool empty() const override {
    return jobs.empty();
  }

  uint64_t size() const override {
    return jobs.size();
  }
};

std::unique_ptr<Scheduler> Scheduler::make(SchedulerAlgorithm alg) {
  switch (alg) {
    case SchedulerAlgorithm::NamePriority:
      return std::unique_ptr<Scheduler>(new PriorityQueueScheduler);
    case SchedulerAlgorithm::FIFO:
      return std::unique_ptr<Scheduler>(new FifoScheduler);
    default:
      assert(0 && "unknown scheduler algorithm");
      return std::unique_ptr<Scheduler>(nullptr);
  }
}

} // anonymous namespace

#if !defined(_WIN32)
extern "C" {
  extern char **environ;
}
#endif

ExecutionQueue* llbuild::basic::createLaneBasedExecutionQueue(
    ExecutionQueueDelegate& delegate, int numLanes, SchedulerAlgorithm alg,
    const char* const* environment
) {
  if (!environment) {
    environment = const_cast<const char* const*>(environ);
  }
  return new LaneBasedExecutionQueue(delegate, numLanes, alg, environment);
}

