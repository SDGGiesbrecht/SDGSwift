/*
 This source file is part of the Swift.org open source project
 
 Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
 Licensed under Apache License v2.0 with Runtime Library Exception
 
 See http://swift.org/LICENSE.txt for license information
 See http://swift.org/CONTRIBUTORS.txt for Swift project authors
*/

import Basic
import Foundation

/// Get clang's version from the given version output string on Ubuntu.
public func getClangVersion(versionOutput: String) -> Version? {
    // Clang outputs version in this format on Ubuntu:
    // Ubuntu clang version 3.6.0-2ubuntu1~trusty1 (tags/RELEASE_360/final) (based on LLVM 3.6.0)
    let versionStringPrefix = "Ubuntu clang version "
    let versionStrings = versionOutput.utf8.split(separator: UInt8(ascii: "-")).compactMap(String.init)
    guard let clangVersionString = versionStrings.first,
          clangVersionString.hasPrefix(versionStringPrefix) else {
        return nil
    }
    let versionStartIndex = clangVersionString.index(clangVersionString.startIndex,
        offsetBy: versionStringPrefix.utf8.count)
    let versionString = clangVersionString[versionStartIndex...]
    // Split major minor patch etc.
    let versions = versionString.utf8.split(separator: UInt8(ascii: ".")).compactMap(String.init)
    guard versions.count > 1, let major = Int(versions[0]), let minor = Int(versions[1]) else {
        return nil
    }
    return Version(major, minor, versions.count > 2 ? Int(versions[2]) ?? 0 : 0)
}

/// Prints the time taken to execute a closure.
///
/// Note: Only for debugging purposes.
public func measure<T>(_ label: String = "", _ f: () throws -> (T)) rethrows -> T {
    let startTime = Date()
    let result = try f()
    let endTime = Date().timeIntervalSince(startTime)
    print("\(label): Time taken", endTime)
    return result
}
