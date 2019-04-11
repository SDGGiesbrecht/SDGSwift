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

    internal static let versions = Version(5, 0, 0) /* Travis CI */ ... Version(5, 0, 0) /* Current */
    public static let _standardLibraryVersion = versions.lowerBound

    private static func standardLocations(for version: Version) -> [URL] {
        return [
            // Swift
            "/usr/bin/swift",
            // Xcode
            "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift",
            "/Library/Developer/Toolchains/swift\u{2D}\(version.string(droppingEmptyPatch: true))\u{2D}RELEASE.xctoolchain/usr/bin/swift",
            NSHomeDirectory() + "/Library/Developer/Toolchains/swift\u{2D}\(version.string(droppingEmptyPatch: true))\u{2D}RELEASE.xctoolchain/usr/bin/swift",
            // Swift Version Manager
            NSHomeDirectory() + "/.swiftenv/shims/swift",
            NSHomeDirectory() + "/.swiftenv/versions/\(version.string(droppingEmptyPatch: true))/usr/bin/swift"
            ].map({ URL(fileURLWithPath: $0) })
    }

    internal static let standardLocations: [URL] = {
        var locations = SwiftCompiler.standardLocations(for: versions.lowerBound)
        for location in SwiftCompiler.standardLocations(for: versions.upperBound) where ¬locations.contains(location) {
            locations.append(location)
        }
        return locations
    }()

    private static func compilerLocation(for swift: URL) -> URL {
        return swift.deletingLastPathComponent().appendingPathComponent("swiftc")
    }
    public static func _compilerLocation() throws -> URL {
        return compilerLocation(for: try location())
    }

    private static func packageManagerLibraries(for swift: URL) -> URL {
        return swift.deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("lib/swift/pm")
    }
    public static func _packageManagerLibraries() throws -> URL {
        return packageManagerLibraries(for: try location())
    }

    private static var located: ExternalProcess?
    private static func tool() throws -> ExternalProcess {
        return try cached(in: &located) {

            func validate(_ swift: ExternalProcess) -> Bool {
                // Make sure necessary relative libraries are available. (Otherwise it is a shim of some sort.)
                if ¬FileManager.default.fileExists(atPath: compilerLocation(for: swift.executable).path)
                    ∨ ¬FileManager.default.fileExists(atPath: packageManagerLibraries(for: swift.executable).path) {
                    return false
                }

                // Make sure version matches.
                if let output = try? swift.run(["\u{2D}\u{2D}version"]),
                    let version = Version(firstIn: output),
                    version ∈ versions {
                    return true
                } else { // @exempt(from: tests)
                    // @exempt(from: tests) Would require Xcode to be absent.
                    return false
                }
            }

            if let found = ExternalProcess(searching: standardLocations, commandName: "swift", validate: validate) {
                return found
            } else { // @exempt(from: tests) Swift is necessarily available when tests are run.
                // @exempt(from: tests)
                throw SwiftCompiler.Error.unavailable
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

    /// Returns whether the log contains warnings.
    ///
    /// - Parameters:
    ///     - log: The output log to be checked.
    public static func warningsOccurred(during log: String) -> Bool {
        for line in log.lines.lazy.map({ $0.line }) where line.contains("warning:".scalars) {
            print(String(line))
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
    ///
    /// - Throws: Either a `SwiftCompiler.Error` or an `ExternalProcess.Error`.
    @discardableResult public static func test(_ package: PackageRepository, reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) throws -> String { // @exempt(from: tests) Xcode hijacks this.
        return try runCustomSubcommand(["test"], in: package.location, reportProgress: reportProgress)
    }

    /// Resolves the package, fetching its dependencies.
    ///
    /// - Parameters:
    ///     - package: The package to resolve.
    ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
    ///     - progressReport: A line of output.
    ///
    /// - Throws: Either a `SwiftCompiler.Error` or an `ExternalProcess.Error`.
    @discardableResult public static func resolve(_ package: PackageRepository, reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) throws -> String {
        return try runCustomSubcommand(["package", "resolve"], in: package.location, reportProgress: reportProgress)
    }

    /// Regenerates the package’s test lists.
    ///
    /// - Parameters:
    ///     - package: The package for which to regenerate the test list.
    ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
    ///     - progressReport: A line of output.
    ///
    /// - Throws: Either a `SwiftCompiler.Error` or an `ExternalProcess.Error`.
    @discardableResult public static func regenerateTestLists(for package: PackageRepository, reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) throws -> String {
        return try runCustomSubcommand(["test", "\u{2D}\u{2D}generate\u{2D}linuxmain"], in: package.location, reportProgress: reportProgress)
    }

    /// Runs a custom subcommand.
    ///
    /// - Parameters:
    ///     - arguments: The arguments (leave “swift” off the beginning).
    ///     - workingDirectory: Optional. A different working directory.
    ///     - environment: Optional. A different set of environment variables.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///     - progressReport: A line of output.
    ///
    /// - Throws: Either a `SwiftCompiler.Error` or an `ExternalProcess.Error`.
    @discardableResult public static func runCustomSubcommand(_ arguments: [String], in workingDirectory: URL? = nil, with environment: [String: String]? = nil, reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) throws -> String {
        reportProgress("$ swift " + arguments.joined(separator: " "))
        return try tool().run(arguments, in: workingDirectory, with: environment, reportProgress: reportProgress)
    }
}
