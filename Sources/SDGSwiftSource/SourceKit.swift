/*
 SourceKit.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow

import SDGSwift

public func test() throws {
    // [_Warning: Temporary._]
    _ = try SourceKit.library()
}

/// SourceKit.
public enum SourceKit {

    // MARK: - Locating

    private static var located: UnsafeMutableRawPointer?
    internal /* [_Warning: Private_] */ static func library() throws -> UnsafeMutableRawPointer {
        return try cached(in: &located) {
            guard let library = dlopen(try SwiftCompiler._sourceKitLocation().path, RTLD_LAZY) else {
                throw SourceKit.Error.currentDynamicLinkerError()
            }
            return library
        }
    }
}
