/*
 This source file is part of the Swift.org open source project
 
 Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
 Licensed under Apache License v2.0 with Runtime Library Exception
 
 See http://swift.org/LICENSE.txt for license information
 See http://swift.org/CONTRIBUTORS.txt for Swift project authors
*/

import class Foundation.ProcessInfo

import enum POSIX.SystemError
import func POSIX.getenv
import SPMLibc
import Dispatch

/// Process result data which is available after process termination.
public struct ProcessResult: CustomStringConvertible {

    public enum Error: Swift.Error {
        /// The output is not a valid UTF8 sequence.
        case illegalUTF8Sequence

        /// The process had a non zero exit.
        case nonZeroExit(ProcessResult)
    }

    public enum ExitStatus: Equatable {
        /// The process was terminated normally with a exit code.
        case terminated(code: Int32)

        /// The process was terminated due to a signal.
        case signalled(signal: Int32)
    }

    /// The arguments with which the process was launched.
    public let arguments: [String]

    /// The exit status of the process.
    public let exitStatus: ExitStatus

    /// The output bytes of the process. Available only if the process was
    /// asked to redirect its output and no stdout output closure was set.
    public let output: Result<[UInt8], AnyError>

    /// The output bytes of the process. Available only if the process was
    /// asked to redirect its output and no stderr output closure was set.
    public let stderrOutput: Result<[UInt8], AnyError>

    /// Create an instance using a POSIX process exit status code and output result.
    ///
    /// See `waitpid(2)` for information on the exit status code.
    public init(
        arguments: [String],
        exitStatusCode: Int32,
        output: Result<[UInt8], AnyError>,
        stderrOutput: Result<[UInt8], AnyError>
    ) {
        let exitStatus: ExitStatus
        if WIFSIGNALED(exitStatusCode) {
            exitStatus = .signalled(signal: WTERMSIG(exitStatusCode))
        } else {
            precondition(WIFEXITED(exitStatusCode), "unexpected exit status \(exitStatusCode)")
            exitStatus = .terminated(code: WEXITSTATUS(exitStatusCode))
        }
        self.init(arguments: arguments, exitStatus: exitStatus, output: output,
            stderrOutput: stderrOutput)
    }

    /// Create an instance using an exit status and output result.
    public init(
        arguments: [String],
        exitStatus: ExitStatus,
        output: Result<[UInt8], AnyError>,
        stderrOutput: Result<[UInt8], AnyError>
    ) {
        self.arguments = arguments
        self.output = output
        self.stderrOutput = stderrOutput
        self.exitStatus = exitStatus
    }
    
    /// Converts stdout output bytes to string, assuming they're UTF8.
    public func utf8Output() throws -> String {
        return String(decoding: try output.dematerialize(), as: Unicode.UTF8.self)
    }

    /// Converts stderr output bytes to string, assuming they're UTF8.
    public func utf8stderrOutput() throws -> String {
        return String(decoding: try stderrOutput.dematerialize(), as: Unicode.UTF8.self)
    }

    public var description: String {
        return """
            <ProcessResult: exit: \(exitStatus), output:
             \((try? utf8Output()) ?? "")
            >
            """
    }
}

/// Process allows spawning new subprocesses and working with them.
///
/// Note: This class is thread safe.
public final class Process: ObjectIdentifierProtocol {

    /// Errors when attempting to invoke a process
    public enum Error: Swift.Error {
        /// The program requested to be executed cannot be found on the existing search paths, or is not executable.
        case missingExecutableProgram(program: String)
    }
    
    public enum OutputRedirection {
        /// Do not redirect the output
        case none
        /// Collect stdout and stderr output and provide it back via ProcessResult object
        case collect
        /// Stream stdout and stderr via the corresponding closures
        case stream(stdout: OutputClosure, stderr: OutputClosure)
        
        public var redirectsOutput: Bool {
            switch self {
            case .none:
                return false
            case .collect, .stream:
                return true
            }
        }
        
        public var outputClosures: (stdoutClosure: OutputClosure, stderrClosure: OutputClosure)? {
            switch self {
            case .stream(let stdoutClosure, let stderrClosure):
                return (stdoutClosure: stdoutClosure, stderrClosure: stderrClosure)
            case .collect, .none:
                return nil
            }
        }
    }

    /// Typealias for process id type.
    public typealias ProcessID = pid_t
    
    /// Typealias for stdout/stderr output closure.
    public typealias OutputClosure = ([UInt8]) -> Void

    /// Global default setting for verbose.
    public static var verbose = false

    /// If true, prints the subprocess arguments before launching it.
    public let verbose: Bool

    /// The current environment.
    static public var env: [String: String] {
        return ProcessInfo.processInfo.environment
    }

    /// The arguments to execute.
    public let arguments: [String]

    /// The environment with which the process was executed.
    public let environment: [String: String]

    /// The process id of the spawned process, available after the process is launched.
    public private(set) var processID = ProcessID()

    /// If the subprocess has launched.
    /// Note: This property is not protected by the serial queue because it is only mutated in `launch()`, which will be
    /// called only once.
    public private(set) var launched = false

    /// The result of the process execution. Available after process is terminated.
    public var result: ProcessResult? {
        return self.serialQueue.sync {
            self._result
        }
    }

    /// How process redirects its output.
    public let outputRedirection: OutputRedirection

    /// The result of the process execution. Available after process is terminated.
    private var _result: ProcessResult?

    /// If redirected, stdout result and reference to the thread reading the output.
    private var stdout: (result: Result<[UInt8], AnyError>, thread: Thread?) = (Result([]), nil)

    /// If redirected, stderr result and reference to the thread reading the output.
    private var stderr: (result: Result<[UInt8], AnyError>, thread: Thread?) = (Result([]), nil)

    /// Queue to protect concurrent reads.
    private let serialQueue = DispatchQueue(label: "org.swift.swiftpm.process")

    /// Queue to protect reading/writing on map of validated executables.
    private static let executablesQueue = DispatchQueue(
        label: "org.swift.swiftpm.process.findExecutable")
    
    /// Indicates if a new progress group is created for the child process.
    private let startNewProcessGroup: Bool

    /// Cache of validated executables.
    ///
    /// Key: Executable name or path.
    /// Value: Path to the executable, if found.
    static private var validatedExecutablesMap = [String: AbsolutePath?]()

    /// Create a new process instance.
    ///
    /// - Parameters:
    ///   - arguments: The arguments for the subprocess.
    ///   - environment: The environment to pass to subprocess. By default the current process environment
    ///     will be inherited.
    ///   - outputRedirection: How process redirects its output. Default value is .collect.
    ///   - verbose: If true, launch() will print the arguments of the subprocess before launching it.
    ///   - startNewProcessGroup: If true, a new progress group is created for the child making it
    ///     continue running even if the parent is killed or interrupted. Default value is true.
    public init(
        arguments: [String],
        environment: [String: String] = env,
        outputRedirection: OutputRedirection = .collect,
        verbose: Bool = Process.verbose,
        startNewProcessGroup: Bool = true
    ) {
        self.arguments = arguments
        self.environment = environment
        self.outputRedirection = outputRedirection
        self.verbose = verbose
        self.startNewProcessGroup = startNewProcessGroup
    }

    /// Returns the path of the the given program if found in the search paths.
    ///
    /// The program can be executable name, relative path or absolute path.
    public static func findExecutable(_ program: String) -> AbsolutePath? {
        return Process.executablesQueue.sync {
            // Check if we already have a value for the program.
            if let value = Process.validatedExecutablesMap[program] {
                return value
            }
            // FIXME: This can be cached.
            let envSearchPaths = getEnvSearchPaths(
                pathString: getenv("PATH"),
                currentWorkingDirectory: localFileSystem.currentWorkingDirectory
            )
            // Lookup and cache the executable path.
            let value = lookupExecutablePath(
                filename: program, searchPaths: envSearchPaths)
            Process.validatedExecutablesMap[program] = value
            return value
        }
    }

    /// Launch the subprocess.
    public func launch() throws {
        precondition(arguments.count > 0 && !arguments[0].isEmpty, "Need at least one argument to launch the process.")
        precondition(!launched, "It is not allowed to launch the same process object again.")

        // Set the launch bool to true.
        launched = true

        // Print the arguments if we are verbose.
        if self.verbose {
            stdoutStream <<< arguments.map({ $0.spm_shellEscaped() }).joined(separator: " ") <<< "\n"
            stdoutStream.flush()
        }

        // Look for executable.
        guard Process.findExecutable(arguments[0]) != nil else {
            throw Process.Error.missingExecutableProgram(program: arguments[0])
        }

        // Initialize the spawn attributes.
      #if os(macOS)
        var attributes: posix_spawnattr_t? = nil
      #else
        var attributes = posix_spawnattr_t()
      #endif
        posix_spawnattr_init(&attributes)
        defer { posix_spawnattr_destroy(&attributes) }

        // Unmask all signals.
        var noSignals = sigset_t()
        sigemptyset(&noSignals)
        posix_spawnattr_setsigmask(&attributes, &noSignals)

        // Reset all signals to default behavior.
      #if os(macOS)
        var mostSignals = sigset_t()
        sigfillset(&mostSignals)
        sigdelset(&mostSignals, SIGKILL)
        sigdelset(&mostSignals, SIGSTOP)
        posix_spawnattr_setsigdefault(&attributes, &mostSignals)
      #else
        // On Linux, this can only be used to reset signals that are legal to
        // modify, so we have to take care about the set we use.
        var mostSignals = sigset_t()
        sigemptyset(&mostSignals)
        for i in 1 ..< SIGSYS {
            if i == SIGKILL || i == SIGSTOP {
                continue
            }
            sigaddset(&mostSignals, i)
        }
        posix_spawnattr_setsigdefault(&attributes, &mostSignals)
      #endif

        // Set the attribute flags.
        var flags = POSIX_SPAWN_SETSIGMASK | POSIX_SPAWN_SETSIGDEF
        if startNewProcessGroup {
            // Establish a separate process group.
            flags |= POSIX_SPAWN_SETPGROUP
            posix_spawnattr_setpgroup(&attributes, 0)
        }

        posix_spawnattr_setflags(&attributes, Int16(flags))

        // Setup the file actions.
      #if os(macOS)
        var fileActions: posix_spawn_file_actions_t? = nil
      #else
        var fileActions = posix_spawn_file_actions_t()
      #endif
        posix_spawn_file_actions_init(&fileActions)
        defer { posix_spawn_file_actions_destroy(&fileActions) }

        // Workaround for https://sourceware.org/git/gitweb.cgi?p=glibc.git;h=89e435f3559c53084498e9baad22172b64429362
        let devNull = strdup("/dev/null")
        defer { free(devNull) }
        // Open /dev/null as stdin.
        posix_spawn_file_actions_addopen(&fileActions, 0, devNull, O_RDONLY, 0)

        var outputPipe: [Int32] = [0, 0]
        var stderrPipe: [Int32] = [0, 0]
        if outputRedirection.redirectsOutput {
            // Open the pipes.
            try open(pipe: &outputPipe)
            try open(pipe: &stderrPipe)
            // Open the write end of the pipe as stdout and stderr, if desired.
            posix_spawn_file_actions_adddup2(&fileActions, outputPipe[1], 1)
            posix_spawn_file_actions_adddup2(&fileActions, stderrPipe[1], 2)
            // Close the other ends of the pipe.
            for pipe in [outputPipe, stderrPipe] {
                posix_spawn_file_actions_addclose(&fileActions, pipe[0])
                posix_spawn_file_actions_addclose(&fileActions, pipe[1])
            }
        } else {
            posix_spawn_file_actions_adddup2(&fileActions, 1, 1)
            posix_spawn_file_actions_adddup2(&fileActions, 2, 2)
        }

        let argv = CStringArray(arguments)
        let env = CStringArray(environment.map({ "\($0.0)=\($0.1)" }))
        let rv = posix_spawnp(&processID, argv.cArray[0], &fileActions, &attributes, argv.cArray, env.cArray)

        guard rv == 0 else {
            throw SystemError.posix_spawn(rv, arguments)
        }

        if outputRedirection.redirectsOutput {
            let outputClosures = outputRedirection.outputClosures
            
            // Close the write end of the output pipe.
            try close(fd: &outputPipe[1])

            // Create a thread and start reading the output on it.
            var thread = Thread { [weak self] in
                if let readResult = self?.readOutput(onFD: outputPipe[0], outputClosure: outputClosures?.stdoutClosure) {
                    self?.stdout.result = readResult
                }
            }
            thread.start()
            self.stdout.thread = thread

            // Close the write end of the stderr pipe.
            try close(fd: &stderrPipe[1])

            // Create a thread and start reading the stderr output on it.
            thread = Thread { [weak self] in
                if let readResult = self?.readOutput(onFD: stderrPipe[0], outputClosure: outputClosures?.stderrClosure) {
                    self?.stderr.result = readResult
                }
            }
            thread.start()
            self.stderr.thread = thread
        }
    }

    /// Blocks the calling process until the subprocess finishes execution.
    @discardableResult
    public func waitUntilExit() throws -> ProcessResult {
        return try serialQueue.sync {
            precondition(launched, "The process is not yet launched.")

            // If the process has already finsihed, return it.
            if let existingResult = _result {
                return existingResult
            }

            // If we're reading output, make sure that is finished.
            stdout.thread?.join()
            stderr.thread?.join()

            // Wait until process finishes execution.
            var exitStatusCode: Int32 = 0
            var result = waitpid(processID, &exitStatusCode, 0)
            while result == -1 && errno == EINTR {
                result = waitpid(processID, &exitStatusCode, 0)
            }
            if result == -1 {
                throw SystemError.waitpid(errno)
            }

            // Construct the result.
            let executionResult = ProcessResult(
                arguments: arguments,
                exitStatusCode: exitStatusCode,
                output: stdout.result,
                stderrOutput: stderr.result
            )
            self._result = executionResult
            return executionResult
        }
    }

    /// Reads the given fd and returns its result.
    ///
    /// Closes the fd before returning.
    private func readOutput(onFD fd: Int32, outputClosure: OutputClosure?) -> Result<[UInt8], AnyError> {
        // Read all of the data from the output pipe.
        let N = 4096
        var buf = [UInt8](repeating: 0, count: N + 1)

        var out = [UInt8]()
        var error: Swift.Error? = nil
        loop: while true {
            let n = read(fd, &buf, N)
            switch n {
            case  -1:
                if errno == EINTR {
                    continue
                } else {
                    error = SystemError.read(errno)
                    break loop
                }
            case 0:
                break loop
            default:
                let data = buf[0..<n]
                if let outputClosure = outputClosure {
                    outputClosure(Array(data))
                } else {
                    out += data
                }
            }
        }
        // Close the read end of the output pipe.
        close(fd)
        // Construct the output result.
        return error.map(Result.init) ?? Result(out)
    }

    /// Send a signal to the process.
    ///
    /// Note: This will signal all processes in the process group.
    public func signal(_ signal: Int32) {
        assert(launched, "The process is not yet launched.")
        _ = SPMLibc.kill(startNewProcessGroup ? -processID : processID, signal)
    }
}

extension Process {
    /// Execute a subprocess and block until it finishes execution
    ///
    /// - Parameters:
    ///   - arguments: The arguments for the subprocess.
    ///   - environment: The environment to pass to subprocess. By default the current process environment
    ///     will be inherited.
    /// - Returns: The process result.
    @discardableResult
    static public func popen(arguments: [String], environment: [String: String] = env) throws -> ProcessResult {
        let process = Process(arguments: arguments, environment: environment, outputRedirection: .collect)
        try process.launch()
        return try process.waitUntilExit()
    }

    @discardableResult
    static public func popen(args: String..., environment: [String: String] = env) throws -> ProcessResult {
        return try Process.popen(arguments: args, environment: environment)
    }

    /// Execute a subprocess and get its (UTF-8) output if it has a non zero exit.
    ///
    /// - Parameters:
    ///   - arguments: The arguments for the subprocess.
    ///   - environment: The environment to pass to subprocess. By default the current process environment
    ///     will be inherited.
    /// - Returns: The process output (stdout + stderr).
    @discardableResult
    static public func checkNonZeroExit(arguments: [String], environment: [String: String] = env) throws -> String {
        let process = Process(arguments: arguments, environment: environment, outputRedirection: .collect)
        try process.launch()
        let result = try process.waitUntilExit()
        // Throw if there was a non zero termination.
        guard result.exitStatus == .terminated(code: 0) else {
            throw ProcessResult.Error.nonZeroExit(result)
        }
        return try result.utf8Output()
    }

    @discardableResult
    static public func checkNonZeroExit(args: String..., environment: [String: String] = env) throws -> String {
        return try checkNonZeroExit(arguments: args, environment: environment)
    }

    public convenience init(args: String..., environment: [String: String] = env, outputRedirection: OutputRedirection = .collect) {
        self.init(arguments: args, environment: environment, outputRedirection: outputRedirection)
    }
}

// MARK: - Private helpers

#if os(macOS)
private typealias swiftpm_posix_spawn_file_actions_t = posix_spawn_file_actions_t?
#else
private typealias swiftpm_posix_spawn_file_actions_t = posix_spawn_file_actions_t
#endif

private func WIFEXITED(_ status: Int32) -> Bool {
    return _WSTATUS(status) == 0
}

private func _WSTATUS(_ status: Int32) -> Int32 {
    return status & 0x7f
}

private func WIFSIGNALED(_ status: Int32) -> Bool {
    return (_WSTATUS(status) != 0) && (_WSTATUS(status) != 0x7f)
}

private func WEXITSTATUS(_ status: Int32) -> Int32 {
    return (status >> 8) & 0xff
}

private func WTERMSIG(_ status: Int32) -> Int32 {
    return status & 0x7f
}

/// Open the given pipe.
private func open(pipe: inout [Int32]) throws {
    let rv = SPMLibc.pipe(&pipe)
    guard rv == 0 else {
        throw SystemError.pipe(rv)
    }
}

/// Close the given fd.
private func close(fd: inout Int32) throws {
    let rv = SPMLibc.close(fd)
    guard rv == 0 else {
        throw SystemError.close(rv)
    }
}

extension Process.Error: CustomStringConvertible {
    public var description: String {
        switch self {
        case .missingExecutableProgram(let program):
            return "could not find executable for '\(program)'"
        }
    }
}

extension ProcessResult.Error: CustomStringConvertible {
    public var description: String {
        switch self {
        case .illegalUTF8Sequence:
            return "illegal UTF8 sequence output"
        case .nonZeroExit(let result):
            let stream = BufferedOutputByteStream()
            switch result.exitStatus {
            case .terminated(let code):
                stream <<< "terminated(\(code)): "

            case .signalled(let signal):
                stream <<< "signalled(\(signal)): "
            }
 
            // Strip sandbox information from arguments to keep things pretty.
            var args = result.arguments
            // This seems a little fragile.
            if args.first == "sandbox-exec", args.count > 3 {
                args = args.suffix(from: 3).map({$0})
            }
            stream <<< args.map({ $0.spm_shellEscaped() }).joined(separator: " ")

            // Include the output, if present.
            if let output = try? result.utf8Output() + result.utf8stderrOutput() {
                // We indent the output to keep it visually separated from everything else.
                let indentation = "    "
                stream <<< " output:\n" <<< indentation <<< output.replacingOccurrences(of: "\n", with: "\n" + indentation)
                if !output.hasSuffix("\n") {
                    stream <<< "\n"
                }
            }
            
            return stream.bytes.description
        }
    }
}
