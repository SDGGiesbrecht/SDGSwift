/*
 Git.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

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
    public static let compatibleVersionRange: Range<Version> = Version(1, 9, 0) ..< Version(2).compatibleVersions.upperBound

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
                    return false // @exempt(from: tests) Git is necessarily available when tests are run.
                }
                return version ∈ compatibleVersionRange
            }

            if let found = ExternalProcess(searching: standardLocations, commandName: "git", validate: validate) {
                return found
            } else { // @exempt(from: tests)
                // @exempt(from: tests) Git is necessarily available when tests are run.
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

    /// Creates a local repository by cloning the remote package.
    ///
    /// - Parameters:
    ///     - package: The package to clone.
    ///     - location: The location to create the clone.
    ///     - version: Optional. A specific version to check out.
    ///     - shallow: Optional. Specify `true` to perform a shallow clone. Defaults to `false`.
    ///     - reportProgress: A closure to execute for each line of the compiler’s output.
    ///
    /// - Throws: Either a `Git.Error` or an `ExternalProcess.Error`.
    @discardableResult public static func clone(_ package: Package, to location: URL, at version: Build = .development, shallow: Bool = false, reportProgress: (String) -> Void = SwiftCompiler._ignoreProgress) throws -> String {

        var command = [
            "clone",
            package.url.absoluteString,
            location.path
        ]

        switch version {
        case .version(let stable):
            command += ["\u{2D}\u{2D}branch", stable.string()]
            command += ["\u{2D}\u{2D}config", "advice.detachedHead=false"]
        case .development:
            break
        }

        if shallow {
            command += ["\u{2D}\u{2D}depth", "1"]
        }

        return try runCustomSubcommand(command, reportProgress: reportProgress)
    }

    /// Retrieves the list of available versions of the package.
    ///
    /// - Throws: Either a `Git.Error` or an `ExternalProcess.Error`.
    public static func versions(of package: Package) throws -> Set<Version> {
        let output = try runCustomSubcommand([
            "ls\u{2D}remote",
            "\u{2D}\u{2D}tags",
            package.url.absoluteString
            ])

        var versions: Set<Version> = []
        for line in output.lines {
            let lineText = line.line
            if let tagPrefix = lineText.firstMatch(for: "refs/tags/".scalars) {
                let tag = String(lineText[tagPrefix.range.upperBound...])
                if let version = Version(tag) {
                    versions.insert(version)
                }
            }
        }
        return versions
    }

    /// Retrieves the latest commit identifier in the master branch of the package.
    ///
    /// - Throws: Either a `Git.Error` or an `ExternalProcess.Error`.
    public static func latestCommitIdentifier(in package: Package) throws -> String {
        return try runCustomSubcommand([
            "ls\u{2D}remote",
            package.url.absoluteString,
            "master"
            ]).truncated(before: "\u{9}")
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
    @discardableResult public static func runCustomSubcommand(_ arguments: [String], in workingDirectory: URL? = nil, with environment: [String: String]? = nil, reportProgress: (String) -> Void = SwiftCompiler._ignoreProgress) throws -> String {
        reportProgress("$ git " + arguments.joined(separator: " "))
        return try tool().run(arguments, in: workingDirectory, with: environment, reportProgress: reportProgress)
    }
}
