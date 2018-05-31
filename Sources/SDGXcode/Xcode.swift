/*
 Xcode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGLogic
import SDGMathematics
import SDGCollections
import SDGText
import SDGExternalProcess

import SDGSwiftLocalizations
import SDGSwift

/// Xcode.
public enum Xcode {

    // MARK: - Locating

    internal static let versions = Version(9, 3, 0) /* Travis CI */ ... Version(9, 4, 0) /* Current */

    internal static let standardLocations = [
        // Xcode
        "/usr/bin/xcodebuild",
        "/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild"
        ].lazy.map({ URL(fileURLWithPath: $0) })

    private static func coverageToolLocation(for xcode: URL) -> URL {
        return xcode.deletingLastPathComponent().appendingPathComponent("xccov")
    }

    private static var located: ExternalProcess?
    private static func tool() throws -> ExternalProcess {
        return try cached(in: &located) {

            func validate(_ xcode: ExternalProcess) -> Bool {
                // Make sure necessary relative tools are available. (Otherwise it is a shim of some sort.)
                if ¬FileManager.default.fileExists(atPath: coverageToolLocation(for: xcode.executable).path) {
                    return false
                }

                // Make sure version matches.
                if let output = try? xcode.run(["\u{2D}version"]),
                    let version = Version(firstIn: output),
                    version ∈ versions {
                    return true
                } else { // [_Exempt from Test Coverage_]
                    // [_Exempt from Test Coverage_] Would require Xcode to be absent.
                    return false
                }
            }

            if let found = ExternalProcess(searching: standardLocations, commandName: "xcodebuild", validate: validate) {
                return found
            } else { // [_Exempt from Test Coverage_]
                 // [_Exempt from Test Coverage_] Xcode is necessarily available when tests are run.
                throw Xcode.Error.unavailable
            }
        }
    }

    private static var locatedCoverage: ExternalProcess?
    private static func coverageTool() throws -> ExternalProcess {
        return try cached(in: &locatedCoverage) {
            return ExternalProcess(at: coverageToolLocation(for: try tool().executable))
        }
    }

    // MARK: - Usage

    /// Returns the location of the Swift compiler.
    ///
    /// - Throws: An `Xcode.Error`.
    public static func location() throws -> URL {
        return try tool().executable
    }

    private static let ignorableCommands: [String] = [
        "/bin/sh",
        "builtin\u{2D}copy",
        "builtin\u{2D}infoPlistUtility",
        "builtin\u{2d}swiftStdLibTool",
        "cd",
        "chmod",
        "clang",
        "codesign",
        "ditto",
        "export",
        "ln",
        "mkdir",
        "swift",
        "swiftc",
        "touch",
        "write\u{2D}file"
    ]
    private static let abbreviableCommands: [String] = [
        "CodeSign",
        "CompileC",
        "CompileSwift",
        "Copying",
        "CopySwiftLibs",
        "Ditto",
        "Ld",
        "MergeSwiftModule",
        "ProcessInfoPlistFile",
        "Touch"
    ]

    private static let otherIgnored: [String] = [
        "Writing diagnostic log for test session to:",
        "com.apple.dt.XCTest/IDETestRunSession\u{2D}",
        "Beginning test session"
    ]

    /// Abbreviates Xcode output to make it more readable.
    ///
    /// This function is intended for use in `reportProgress` to keep the log concise and manageable.
    public static func abbreviate(output: String) -> String? {
        if output.isEmpty ∨ ¬output.scalars.contains(where: { $0 ∉ CharacterSet.whitespaces }) {
            return nil
        }

        var indentation = ""
        var commandLine = output
        while commandLine.first == " " {
            indentation.append(commandLine.removeFirst())
        }
        if let pathSection = commandLine.components(separatedBy: " ").first?.contents {
            let path = String(pathSection)
            let command = String(path.components(separatedBy: "/").last!.contents)
            for ignorableCommand in Xcode.ignorableCommands where ignorableCommand == command {
                return nil
            }
            for abbreviableCommand in Xcode.abbreviableCommands where abbreviableCommand == command {
                let file = String(commandLine.components(separatedBy: "/").last!.contents)
                let abbreviatedPath: String
                if path == command {
                    abbreviatedPath = command
                } else {
                    abbreviatedPath = "[...]/" + command
                }
                return indentation + abbreviatedPath + " [...]/" + file
            }
        }

        for ignored in otherIgnored {
            if output.contains(ignored) {
                return nil
            }
        }

        return output
    }

    /// Builds the package.
    ///
    /// - Throws: Either an `Xcode.Error` or an `ExternalProcess.Error`.
    @discardableResult public static func build(_ package: PackageRepository, for sdk: SDK, reportProgress: (String) -> Void = SwiftCompiler._ignoreProgress) throws -> String {
        return try runCustomSubcommand([
            "build",
            "\u{2D}sdk", sdk.commandLineName,
            "\u{2D}scheme", try scheme(for: package)
            ], in: package.location, reportProgress: reportProgress)
    }

    /// Returns whether the log contains warnings.
    public static func warningsOccurred(during log: String) -> Bool {
        let warnings = log.scalars.matches(for: " warning:".scalars).filter { match in // [_Exempt from Test Coverage_] Only triggered on the first build.
            return ¬log.scalars[match.range.upperBound...].hasPrefix(" directory not found for option \u{27}\u{2D}F/Applications/Xcode".scalars) // [_Exempt from Test Coverage_]
            // The above false positive occurs when a project generated by the Swift Package Manager attempts to build for watchOS.
        }
        return ¬warnings.isEmpty
    }

    private static func coverageDirectory(for package: PackageRepository, on sdk: SDK) throws -> URL {
        return try derivedData(for: package, on: sdk).appendingPathComponent("Logs/Test")
    }

    /// Tests the package.
    ///
    /// - Throws: Either an `Xcode.Error` or an `ExternalProcess.Error`.
    @discardableResult public static func test(_ package: PackageRepository, on sdk: SDK, reportProgress: (String) -> Void = SwiftCompiler._ignoreProgress) throws -> String {

        if let coverage = try? coverageDirectory(for: package, on: sdk) {
            // Remove any outdated coverage data. (Cannot tell which is which if there is more than one.)
            try? FileManager.default.removeItem(at: coverage)
        }

        var command = ["test"]

        switch sdk {
        case .iOS(simulator: true):
            command += ["\u{2D}destination", "name=iPhone 8"] // [_Exempt from Test Coverage_] Tested separately.
        case .tvOS(simulator: true):
            command += ["\u{2D}destination", "name=Apple TV 4K"] // [_Exempt from Test Coverage_] Tested separately.
        default:
            command += ["\u{2D}sdk", sdk.commandLineName]
        }

        command += ["\u{2D}scheme", try scheme(for: package)]

        return try runCustomSubcommand(command, in: package.location, reportProgress: reportProgress)
    }

    private static let charactersIrrelevantToCoverage = CharacterSet.whitespacesAndNewlines ∪ ["{", "}", "(", ")"]

    /// Returns the code coverage report for the package.
    ///
    /// - Returns: The report, or `nil` if there is no code coverage information.
    ///
    /// - Throws: Either an `Xcode.Error` or an `ExternalProcess.Error`.
    public static func codeCoverageReport(for package: PackageRepository, on sdk: SDK, ignoreCoveredRegions: Bool = false, reportProgress: (String) -> Void = SwiftCompiler._ignoreProgress) throws -> TestCoverageReport? {
        let directory = try coverageDirectory(for: package, on: sdk)
        guard let archive = try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil, options: []).first(where: { $0.pathExtension == "xccovarchive" }) else { // [_Exempt from Test Coverage_]
            // [_Exempt from Test Coverage_] Not reliably reachable without causing Xcode’s derived data to grow with each test iteration.
            return nil
        }

        let fileURLs: [URL] = try runCustomCoverageSubcommand([
            "view",
            "\u{2D}\u{2D}file\u{2D}list",
            archive.path
            ]).lines.map({ URL(fileURLWithPath: String($0.line)) }).filter({ file in
                if file.is(in: package.dataDirectory) ∨ file.is(in: package.editablesDirectory) {
                    // [_Exempt from Test Coverage_]
                    // Belongs to a dependency.
                    return false
                }
                return true
            }).sorted()

        var files: [FileTestCoverage] = []
        for fileURL in fileURLs {
            try autoreleasepool {

                print(UserFacing<StrictString, InterfaceLocalization>({ localization in
                    switch localization {
                    case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                        return StrictString("Parsing report for “\(fileURL.path(relativeTo: package.location))”...")
                    }
                }).resolved())

                var report = try runCustomCoverageSubcommand([
                    "view",
                    "\u{2D}\u{2D}file", fileURL.path,
                    archive.path
                    ])

                let source = try String(from: fileURL)
                let sourceLines = source.lines
                func toIntegerIgnoringWhitespace(_ string: String) -> Int? {
                    let digitsOnly = string.replacingOccurrences(of: " ", with: "")
                    if let integer = Int(digitsOnly) {
                        return integer
                    }
                    if ¬digitsOnly.scalars.contains(where: { $0 ∉ Set<UnicodeScalar>(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]) }) { // [_Exempt from Test Coverage_]
                        // It is an integer; it is just to large.
                        return Int.max
                    }
                    return nil
                }
                func toIndex(line: Int, column: Int = 1) -> String.ScalarView.Index {
                    let lineInUTF8: String.UTF8View.Index = sourceLines.index(sourceLines.startIndex, offsetBy: line − 1).samePosition(in: source.scalars).samePosition(in: source.utf8)!
                    let utf8Index: String.UTF8View.Index = source.utf8.index(lineInUTF8, offsetBy: column − 1)
                    return utf8Index.samePosition(in: source.scalars)
                }

                var regions: [CoverageRegion] = []
                while ¬report.isEmpty {
                    let lineRange = report.prefix(through: "\n")?.range ?? report.bounds
                    var line = String(report[lineRange])
                    report.removeSubrange(lineRange)
                    if line.contains("*") {
                        continue
                    }

                    while line.hasSuffix("\n") {
                        line.removeLast()
                    }

                    let base: String
                    let hasSubranges: Bool
                    if line.hasSuffix("[") {
                        base = String(line.dropLast())
                        hasSubranges = true
                    } else {
                        base = line
                        hasSubranges = false
                    }
                    let components = base.components(separatedBy: ":") as [String]
                    guard let lineString = components.first,
                        let lineNumber = toIntegerIgnoringWhitespace(lineString),
                        let columnString = components.last,
                        let count = toIntegerIgnoringWhitespace(columnString) else {
                            // [_Exempt from Test Coverage_]
                            throw Xcode.Error.corruptTestCoverageReport
                    }
                    regions.append(CoverageRegion(region: toIndex(line: lineNumber) ..< toIndex(line: lineNumber + 1), count: count))

                    if hasSubranges {
                        guard let subrange = report.prefix(through: "]\n")?.range else {
                            // [_Exempt from Test Coverage_]
                            throw Xcode.Error.corruptTestCoverageReport
                        }
                        var substring = String(report[subrange])
                        report.removeSubrange(subrange)
                        while let nested = substring.firstNestingLevel(startingWith: "(", endingWith: ")") {
                            let regionString = nested.contents.contents
                            substring.removeSubrange(nested.container.range)

                            let components = regionString.components(separatedBy: ",") as [String]
                            guard components.count == 3,
                                let start = toIntegerIgnoringWhitespace(components[0]),
                                let length = toIntegerIgnoringWhitespace(components[1]),
                                let count = toIntegerIgnoringWhitespace(components[2]) else {
                                    // [_Exempt from Test Coverage_]
                                    throw Xcode.Error.corruptTestCoverageReport
                            }
                            regions.append(CoverageRegion(region: toIndex(line: lineNumber, column: start) ..< toIndex(line: lineNumber, column: start + length), count: count))
                        }
                    }
                }

                // Combine to one coherent list.
                regions = regions.reduce(into: [] as [CoverageRegion]) { regions, next in
                    if ignoreCoveredRegions ∧ next.count ≠ 0 {
                        return // Drop
                    }

                    guard var last = regions.last else {
                        // First one; just append.
                        regions.append(next)
                        return
                    }
                    if last.region.upperBound > next.region.lowerBound { // [_Exempt from Test Coverage_]
                        // [_Exempt from Test Coverage_] False coverage result in Xocde 9.3.

                        // Fix overlap.
                        regions.removeLast()
                        let replacement = CoverageRegion(region: last.region.lowerBound ..< next.region.lowerBound, count: last.count)
                        regions.append(replacement)
                    }

                    last = regions.last!
                    if last.region.upperBound == next.region.lowerBound ∧ last.count == next.count {
                        // Join contiguous regions.
                        regions.removeLast()
                        let replacement = CoverageRegion(region: last.region.lowerBound ..< next.region.upperBound, count: last.count)
                        regions.append(replacement)
                    } else {
                        // Unrelated to anything else, so just append.
                        regions.append(next)
                    }
                }

                // Remove false positives
                regions = regions.filter { region in

                    if ¬source.scalars[region.region].contains(where: { $0 ∉ Xcode.charactersIrrelevantToCoverage }) {
                        // Region has no effect.
                        return false
                    }

                    // Otherwise keep.
                    return true
                }

                files.append(FileTestCoverage(file: fileURL, regions: regions))
            }
        }
        return TestCoverageReport(files: files)
    }

    /// Returns the main package scheme.
    ///
    /// - Throws: Either an `Xcode.Error` or an `ExternalProcess.Error`.
    public static func scheme(for package: PackageRepository) throws -> String {
        if try package.xcodeProject() == nil {
            // [_Exempt from Test Coverage_]
            throw Xcode.Error.noXcodeProject
        }

        let information = try runCustomSubcommand(["\u{2D}list"], in: package.location)

        guard let schemesHeader = information.scalars.firstMatch(for: "Schemes:".scalars)?.range else {
            // [_Exempt from Test Coverage_]
            throw Xcode.Error.noPackageScheme
        }
        let zoneStart = schemesHeader.lines(in: information.lines).upperBound

        for line in information.lines[zoneStart...] where line.line.hasSuffix("\u{2D}Package".scalars) {
            return String(String.ScalarView(line.line.filter({ $0 ∉ CharacterSet.whitespaces })))
        }
        // [_Exempt from Test Coverage_]
        throw Xcode.Error.noPackageScheme
    }

    private static func buildSettings(for package: PackageRepository, on sdk: SDK) throws -> String {
        return try runCustomSubcommand([
            "\u{2D}showBuildSettings",
            "\u{2D}scheme", try scheme(for: package),
            "\u{2D}sdk", sdk.commandLineName
            ], in: package.location)
    }

    private static func buildDirectory(for package: PackageRepository, on sdk: SDK) throws -> URL {
        let settings = try buildSettings(for: package, on: sdk)
        guard let productDirectory = settings.scalars.firstNestingLevel(startingWith: " BUILD_DIR = ".scalars, endingWith: "\n".scalars)?.contents.contents else { // [_Exempt from Test Coverage_]
            // [_Exempt from Test Coverage_] Unreachable without corrupt project.
            throw Xcode.Error.noBuildDirectory
        }
        return URL(fileURLWithPath: String(productDirectory)).deletingLastPathComponent()
    }

    /// The derived data directory for the package.
    ///
    /// - Throws: Either an `Xcode.Error` or an `ExternalProcess.Error`.
    public static func derivedData(for package: PackageRepository, on sdk: SDK) throws -> URL {
        return try buildDirectory(for: package, on: sdk).deletingLastPathComponent()
    }

    /// Runs a custom subcommand of xcodebuild.
    ///
    /// - Parameters:
    ///     - arguments: The arguments (leave “xcodebuild” off the beginning).
    ///     - workingDirectory: Optional. A different working directory.
    ///     - environment: Optional. A different set of environment variables.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///
    /// - Throws: Either an `Xcode.Error` or an `ExternalProcess.Error`.
    @discardableResult public static func runCustomSubcommand(_ arguments: [String], in workingDirectory: URL? = nil, with environment: [String: String]? = nil, reportProgress: (String) -> Void = SwiftCompiler._ignoreProgress) throws -> String {
        reportProgress("$ xcodebuild " + arguments.joined(separator: " "))
        return try tool().run(arguments, in: workingDirectory, with: environment, reportProgress: reportProgress)
    }

    /// Runs a custom subcommand of xccov.
    ///
    /// - Parameters:
    ///     - arguments: The arguments (leave “xccov” off the beginning).
    ///     - workingDirectory: Optional. A different working directory.
    ///     - environment: Optional. A different set of environment variables.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///
    /// - Throws: Either an `Xcode.Error` or an `ExternalProcess.Error`.
    @discardableResult public static func runCustomCoverageSubcommand(_ arguments: [String], in workingDirectory: URL? = nil, with environment: [String: String]? = nil, reportProgress: (String) -> Void = SwiftCompiler._ignoreProgress) throws -> String {
        reportProgress("$ xccov " + arguments.joined(separator: " "))
        return try coverageTool().run(arguments, in: workingDirectory, with: environment, reportProgress: reportProgress)
    }
}
