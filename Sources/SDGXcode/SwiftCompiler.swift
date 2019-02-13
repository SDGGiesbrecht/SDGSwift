/*
 SwiftCompiler.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwift

extension SwiftCompiler {

    /// Generates or refreshes the package’s Xcode project.
    ///
    /// - Parameters:
    ///     - package: The package.
    ///     - reportProgress: A closure to execute for each line of the compiler’s output.
    ///     - progressReport: A line of compiler output.
    ///
    /// - Throws: Either a `SwiftCompiler.Error` or an `ExternalProcess.Error`.
    @discardableResult public static func generateXcodeProject(for package: PackageRepository, reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) throws -> String {
        return try runCustomSubcommand([
            "package", "generate\u{2D}xcodeproj",
            "\u{2D}\u{2D}enable\u{2D}code\u{2D}coverage"
            ], in: package.location, reportProgress: reportProgress)
    }
}
