/*
 SwiftCompiler.swift

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
import SDGExternalProcess

/// The Swift compiler.
public enum SwiftCompiler {

    // MARK: - Locating

    internal static let version = "4.1"

    internal static let standardLocations = [
        // Swift
        "/usr/bin/swift",
        // Xcode
        "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift",
        "/Library/Developer/Toolchains/swift\u{2D}\(version)\u{2D}RELEASE.xctoolchain/usr/bin/swift",
        NSHomeDirectory() + "/Library/Developer/Toolchains/swift\u{2D}\(version)\u{2D}RELEASE.xctoolchain/usr/bin/swift",
        // Swift Version Manager
        NSHomeDirectory() + "/.swiftenv/shims/swift",
        NSHomeDirectory() + "/.swiftenv/versions/\(version)/usr/bin/swift"
        ].lazy.map({ URL(fileURLWithPath: $0) })

    private static var located: ExternalProcess?
    private static func tool() throws -> ExternalProcess {
        return try cached(in: &located) {

            func validateVersion(_ swift: ExternalProcess) -> Bool {
                let output = try? swift.run(["\u{2D}\u{2D}version"])
                return output?.contains(" " + version + " ") == true
            }

            if let found = ExternalProcess(searching: standardLocations, commandName: "swift", validate: validateVersion) {
                return found
            } else { // [_Exempt from Test Coverage_] Swift is necessarily available when tests are run.
                throw SwiftCompiler.Error.unavailable
            }
        }
    }

    // MARK: - Usage

    /// Builds the package.
    ///
    /// - Parameters:
    ///     - package: The package to build.
    ///     - reportProgress: A closure to execute for each line of the compiler’s output.
    ///
    /// - Throws: Either a `SwiftCompiler.Error` or an `ExternalProcess.Error`.
    public static func build(_ package: PackageRepository, reportProgress: (String) -> Void) throws {
        reportProgress("$ swift build")
        try tool().run(["build"], in: package.location, reportProgress: reportProgress)
    }
}
