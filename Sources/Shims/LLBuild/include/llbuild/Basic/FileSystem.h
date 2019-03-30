//===- FileSystem.h ---------------------------------------------*- C++ -*-===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2015 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#ifndef LLBUILD_BASIC_FILESYSTEM_H
#define LLBUILD_BASIC_FILESYSTEM_H

#include "llbuild/Basic/Compiler.h"
#include "llbuild/Basic/FileInfo.h"
#include "llbuild/Basic/LLVM.h"

#include "llvm/Support/ErrorOr.h"

#include <memory>

namespace llvm {

class MemoryBuffer;

}

namespace llbuild {
namespace basic {

// Abstract interface for interacting with a file system. This allows mocking of
// operations for testing, and for clients to provide virtualized interfaces.
class FileSystem  {
  // DO NOT COPY
  FileSystem(const FileSystem&) LLBUILD_DELETED_FUNCTION;
  void operator=(const FileSystem&) LLBUILD_DELETED_FUNCTION;
  FileSystem &operator=(FileSystem&& rhs) LLBUILD_DELETED_FUNCTION;

public:
  FileSystem() {}
  virtual ~FileSystem();

  /// Create the given directory if it does not exist.
  ///
  /// \returns True on success (the directory was created, or already exists).
  virtual bool
  createDirectory(const std::string& path) = 0;

  /// Create the given directory (recursively) if it does not exist.
  ///
  /// \returns True on success (the directory was created, or already exists).
  virtual bool
  createDirectories(const std::string& path);

  /// Get a memory buffer for a given file on the file system.
  ///
  /// \returns The file contents, on success, or null on error.
  virtual std::unique_ptr<llvm::MemoryBuffer>
  getFileContents(const std::string& path) = 0;

  /// Remove the file or directory at the given path.
  ///
  /// Directory removal is recursive.
  ///
  /// \returns True if the item was removed, false otherwise.
  virtual bool remove(const std::string& path) = 0;
  
  /// Get the information to represent the state of the given path in the file
  /// system.
  ///
  /// \returns The FileInfo for the given path, which will be missing if the
  /// path does not exist (or any error was encountered).
  virtual FileInfo getFileInfo(const std::string& path) = 0;
  
  /// Get the information to represent the state of the given path in the file
  /// system, without looking through symbolic links.
  ///
  /// \returns The FileInfo for the given path, which will be missing if the
  /// path does not exist (or any error was encountered).
  virtual FileInfo getLinkInfo(const std::string& path) = 0;
};

/// Create a FileSystem instance suitable for accessing the local filesystem.
std::unique_ptr<FileSystem> createLocalFileSystem();


/// Device/inode agnostic filesystem wrapper
class DeviceAgnosticFileSystem : public FileSystem {
private:
  std::unique_ptr<FileSystem> impl;

public:
  explicit DeviceAgnosticFileSystem(std::unique_ptr<FileSystem> fs)
    : impl(std::move(fs))
  {
  }

  DeviceAgnosticFileSystem(const FileSystem&) LLBUILD_DELETED_FUNCTION;
  void operator=(const DeviceAgnosticFileSystem&) LLBUILD_DELETED_FUNCTION;
  DeviceAgnosticFileSystem &operator=(DeviceAgnosticFileSystem&& rhs) LLBUILD_DELETED_FUNCTION;

  static std::unique_ptr<FileSystem> from(std::unique_ptr<FileSystem> fs);


  virtual bool
  createDirectory(const std::string& path) override {
    return impl->createDirectory(path);
  }

  virtual bool
  createDirectories(const std::string& path) override {
    return impl->createDirectories(path);
  }

  virtual std::unique_ptr<llvm::MemoryBuffer>
  getFileContents(const std::string& path) override;

  virtual bool remove(const std::string& path) override {
    return impl->remove(path);
  }

  virtual FileInfo getFileInfo(const std::string& path) override {
    auto info = impl->getFileInfo(path);

    // Device and inode numbers may (will) change when relocating files to
    // another device. Here we explicitly, unconditionally override them with 0,
    // enabling an entire build tree to be relocated or copied yet retain the
    // ability to perform incremental builds.
    info.device = 0;
    info.inode = 0;

    return info;
  }

  virtual FileInfo getLinkInfo(const std::string& path) override {
    auto info = impl->getLinkInfo(path);

    info.device = 0;
    info.inode = 0;

    return info;
  }
};

}
}

#endif
