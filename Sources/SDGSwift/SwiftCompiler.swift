/*
 SwiftCompiler.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGLogic
import SDGCollections
import SDGExternalProcess

/// The Swift compiler.
public enum SwiftCompiler {

    // MARK: - Locating

    internal static let compatibleVersionRange = Version(5, 0, 0) /* Travis CI */ ... Version(5, 0, 1) /* Current */
    public static let _standardLibraryVersion = compatibleVersionRange.lowerBound

    internal static let searchCommands: [[String]] = [
        ["which", "swift"], // Swift
        ["xcrun", "\u{2D}\u{2D}find", "swift"], // Xcode
        ["swiftenv", "which", "swift"] // Swift Version Manager
    ]
    public static func _search(command: [String]) -> URL? {
        guard let output = try? Shell.default.run(command: command).get() else {
            return nil
        }
        return URL(fileURLWithPath: output)
    }

    private static var located: Result<ExternalProcess, SwiftCompiler.LocationError>?
    private static func tool() -> Result<ExternalProcess, SwiftCompiler.LocationError> {
        return cached(in: &located) {

            let searchLocations = SwiftCompiler.searchCommands.lazy.reversed()
                .lazy.compactMap({ _search(command: $0) })

            func validate(_ swift: ExternalProcess) -> Bool {

                // Make sure version matches.
                if let output = try? swift.run(["\u{2D}\u{2D}version"]).get(),
                    let version = Version(firstIn: output),
                    version ∈ compatibleVersionRange {
                    return true
                } else { // @exempt(from: tests)
                    // @exempt(from: tests) Would require Xcode to be absent.
                    return false
                }
            }

            if let found = ExternalProcess(searching: searchLocations, commandName: "swift", validate: validate) {
                return .success(found)
            } else { // @exempt(from: tests) Swift is necessarily available when tests are run.
                // @exempt(from: tests)
                return .failure(SwiftCompiler.LocationError())
            }
        }
    }

    // MARK: - Usage

    /// Returns the location of the Swift compiler.
    public static func location() -> Result<URL, SwiftCompiler.LocationError> {
        return tool().map { $0.executable }
    }

    public static func _ignoreProgress(_ output: String) {}

    /// Builds the package.
    ///
    /// - Parameters:
    ///     - package: The package to build.
    ///     - releaseConfiguration: Optional. Whether or not to build in the release configuration. Defaults to `false`, i.e. the default debug configuration.
    ///     - staticallyLinkStandardLibrary: Optional. Whether or not to statically link the standard library. Defaults to `false`.
    ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
    ///     - progressReport: A line of output.
    ///
    /// - Throws: Either a `SwiftCompiler.Error` or an `ExternalProcess.Error`.
    @discardableResult public static func build(_ package: PackageRepository, releaseConfiguration: Bool = false, staticallyLinkStandardLibrary: Bool = false, reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) throws -> String {
        var arguments = ["build"]
        if releaseConfiguration {
            arguments += ["\u{2D}\u{2D}configuration", "release"]
        }
        if staticallyLinkStandardLibrary {
            arguments += ["\u{2D}\u{2D}static\u{2D}swift\u{2D}stdlib"]
        }
        return try runCustomSubcommand(arguments, in: package.location, reportProgress: reportProgress)
    }

    public static func _warningBelongsToDependency(_ line: String.UnicodeScalarView.SubSequence) -> Bool {
        if let possiblePath = line.prefix(upTo: ":".scalars)?.contents,
            possiblePath.contains("/.build/".scalars) {
            return true
        }
        return false
    }
    /// Returns whether the log contains warnings.
    ///
    /// - Parameters:
    ///     - log: The output log to be checked.
    public static func warningsOccurred(during log: String) -> Bool {
        for line in log.lines.lazy.map({ $0.line }) where line.contains("warning:".scalars) {
            if SwiftCompiler._warningBelongsToDependency(line) {
                continue
            }
            return true
        }
        return false
    }

    /// Tests the package.
    ///
    /// - Parameters:
    ///     - package: The package to test.
    ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
    ///     - progressReport: A line of output.
    @discardableResult public static func test(_ package: PackageRepository, reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) -> Result<String, SwiftCompiler.Error> {

        var environment = ProcessInfo.processInfo.environment
        environment["XCTestConfigurationFilePath"] = nil // Causes issues when run from within Xcode.

        return runCustomSubcommand([
            "test",
            "\u{2D}\u{2D}enable\u{2D}code\u{2D}coverage"
            ], in: package.location, with: environment, reportProgress: reportProgress)
    }

    /// Resolves the package, fetching its dependencies.
    ///
    /// - Parameters:
    ///     - package: The package to resolve.
    ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
    ///     - progressReport: A line of output.
    @discardableResult public static func resolve(_ package: PackageRepository, reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) -> Result<String, SwiftCompiler.Error> {
        return runCustomSubcommand(["package", "resolve"], in: package.location, reportProgress: reportProgress)
    }

    /// Regenerates the package’s test lists.
    ///
    /// - Parameters:
    ///     - package: The package for which to regenerate the test list.
    ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
    ///     - progressReport: A line of output.
    @discardableResult public static func regenerateTestLists(for package: PackageRepository, reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) -> Result<String, SwiftCompiler.Error> {
        return runCustomSubcommand(["test", "\u{2D}\u{2D}generate\u{2D}linuxmain"], in: package.location, reportProgress: reportProgress)
    }

    /// Runs a custom subcommand.
    ///
    /// - Parameters:
    ///     - arguments: The arguments (leave “swift” off the beginning).
    ///     - workingDirectory: Optional. A different working directory.
    ///     - environment: Optional. A different set of environment variables.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///     - progressReport: A line of output.
    @discardableResult public static func runCustomSubcommand(_ arguments: [String], in workingDirectory: URL? = nil, with environment: [String: String]? = nil, reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) -> Result<String, SwiftCompiler.Error> {
        reportProgress("$ swift " + arguments.joined(separator: " "))
        switch tool() {
        case .failure(let error):
            return .failure(.locationError(error))
        case .success(let swift):
            switch swift.run(arguments, in: workingDirectory, with: environment, reportProgress: reportProgress) {
            case .failure(let error):
                return .failure(.executionError(error))
            case .success(let output):
                return .success(output)
            }
        }
    }
}
