/*
 Git.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGCollections
import SDGExternalProcess

/// Git.
public enum Git {

    // MARK: - Locating

    /// The range of compatible Git versions.
    public static let compatibleVersionRange = Version(2, 4, 0).compatibleVersions

    internal static let standardLocations = [
        // Git
        "/usr/bin/git"
        ].lazy.map({ URL(fileURLWithPath: $0) })

    private static var located: ExternalProcess?
    private static func tool() throws -> ExternalProcess {
        return try cached(in: &located) {

            func validate(_ swift: ExternalProcess) -> Bool {
                // Make sure version is compatible.
                guard let output = try? swift.run(["\u{2D}\u{2D}version"]),
                    let version = Version(firstIn: output) else {
                    return false
                }
                return version ∈ compatibleVersionRange
            }

            if let found = ExternalProcess(searching: standardLocations, commandName: "git", validate: validate) {
                return found
            } else { // [_Exempt from Test Coverage_] Git is necessarily available when tests are run.
                throw Git.Error.unavailable
            }
        }
    }

    // MARK: - Usage

    /// Returns the location of the Swift compiler.
    ///
    /// - Throws: A `SwiftCompiler.Error`.
    public static func location() throws -> URL {
        return try tool().executable
    }

    /// Runs a custom subcommand.
    ///
    /// - Warning: Make sure the custom command is compatible with the entire range specified by `compatibleVersionRange`.
    ///
    /// - Parameters:
    ///     - arguments: The arguments (leave “git” off the beginning).
    ///     - workingDirectory: Optional. A different working directory.
    ///     - environment: Optional. A different set of environment variables.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///
    /// - Throws: Either a `SwiftCompiler.Error` or an `ExternalProcess.Error`.
    @discardableResult public static func runCustomSubcommand(_ arguments: [String], in workingDirectory: URL? = nil, with environment: [String: String]? = nil, reportProgress: (String) -> Void = { _ in }) throws -> String {
        reportProgress("$ git " + arguments.joined(separator: " "))
        return try tool().run(arguments, in: workingDirectory, with: environment, reportProgress: reportProgress)
    }
}
