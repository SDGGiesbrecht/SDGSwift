/*
 Xcode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGCollections
import SDGText
import SDGExternalProcess

import SDGSwift

/// Xcode.
public enum Xcode {

    // MARK: - Locating

    internal static let version = Version(9, 3, 0)

    internal static let standardLocations = [
        // Xcode
        "/usr/bin/xcodebuild",
        "/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild"
        ].lazy.map({ URL(fileURLWithPath: $0) })

    private static var located: ExternalProcess?
    private static func tool() throws -> ExternalProcess {
        return try cached(in: &located) {

            func validate(_ swift: ExternalProcess) -> Bool {
                // Make sure version matches.
                let output = try? swift.run(["\u{2D}version"])
                return output?.contains(" " + version.string(droppingEmptyPatch: true) + "\n") == true
            }

            if let found = ExternalProcess(searching: standardLocations, commandName: "xcodebuild", validate: validate) {
                return found
            } else { // [_Exempt from Test Coverage_] Xcode is necessarily available when tests are run.
                throw Xcode.Error.unavailable
            }
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
        "builtin\u{2D}copy",
        "builtin\u{2D}infoPlistUtility",
        "builtin-swiftStdLibTool",
        "cd",
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
        "Beginning test session",
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
    @discardableResult public static func build(_ package: PackageRepository, for sdk: SDK, reportProgress: (String) -> Void = { _ in }) throws -> String {
        return try runCustomSubcommand([
            "build",
            "\u{2D}sdk", sdk.commandLineName,
            "\u{2D}scheme", try scheme(for: package)
            ], in: package.location, reportProgress: reportProgress)
    }

    /// Returns whether the log contains warnings.
    public static func warningsOccurred(during log: String) -> Bool {
        let warnings = log.scalars.matches(for: " warning:".scalars).filter { match in // [_Exempt from Test Coverage_] Only triggered on the first build.
            return ¬log.scalars[match.range.upperBound...].hasPrefix(" directory not found for option \u{27}\u{2D}F/Applications/Xcode".scalars)
            // The above false positive occurs when a project generated by the Swift Package Manager attempts to build for watchOS.
        }
        return ¬warnings.isEmpty
    }

    /// Tests the package.
    ///
    /// - Throws: Either an `Xcode.Error` or an `ExternalProcess.Error`.
    @discardableResult public static func test(_ package: PackageRepository, on sdk: SDK, reportProgress: (String) -> Void = { _ in }) throws -> String {
        var command = ["test"]

        switch sdk {
        case .iOS(simulator: true):
            command += ["\u{2D}destination", "name=iPhone 8"]
        case .tvOS(simulator: true):
            command += ["\u{2D}destination", "name=Apple TV 4K"]
        default:
            command += ["\u{2D}sdk", sdk.commandLineName]
        }

        command += ["\u{2D}scheme", try scheme(for: package)]

        return try runCustomSubcommand(command, in: package.location, reportProgress: reportProgress)
    }

    /// Returns the main package scheme.
    ///
    /// - Throws: Either an `Xcode.Error` or an `ExternalProcess.Error`.
    public static func scheme(for package: PackageRepository) throws -> String {
        if try package.xcodeProject() == nil {
            throw Xcode.Error.noXcodeProject
        }

        let information = try runCustomSubcommand(["\u{2D}list"], in: package.location)

        guard let schemesHeader = information.scalars.firstMatch(for: "Schemes:".scalars)?.range else {
            throw Xcode.Error.noPackageScheme
        }
        let zoneStart = schemesHeader.lines(in: information.lines).upperBound

        for line in information.lines[zoneStart...] where line.line.hasSuffix("\u{2D}Package".scalars) {
            return String(String.ScalarView(line.line.filter({ $0 ∉ CharacterSet.whitespaces })))
        }
        throw Xcode.Error.noPackageScheme
    }

    /// Runs a custom subcommand.
    ///
    /// - Parameters:
    ///     - arguments: The arguments (leave “xcodebuild” off the beginning).
    ///     - workingDirectory: Optional. A different working directory.
    ///     - environment: Optional. A different set of environment variables.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///
    /// - Throws: Either an `Xcode.Error` or an `ExternalProcess.Error`.
    @discardableResult public static func runCustomSubcommand(_ arguments: [String], in workingDirectory: URL? = nil, with environment: [String: String]? = nil, reportProgress: (String) -> Void = { _ in }) throws -> String {
        reportProgress("$ xcodebuild " + arguments.joined(separator: " "))
        return try tool().run(arguments, in: workingDirectory, with: environment, reportProgress: reportProgress)
    }
}
