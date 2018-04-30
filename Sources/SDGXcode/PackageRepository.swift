/*
 PackageRepository.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGSwift

extension PackageRepository {

    // MARK: - Properties

    /// Returns the package’s Xcode project.
    public func xcodeProject() throws -> URL? {
        let files = try FileManager.default.contentsOfDirectory(at: location, includingPropertiesForKeys: [], options: [])

        for file in files where file.pathExtension == "xcodeproj" {
            return file
        }
        return nil
    }

    /// Returns the main package scheme.
    ///
    /// - Throws: Either an `Xcode.Error` or an `ExternalProcess.Error`.
    public func scheme() throws -> String {
        return try Xcode.scheme(for: self)
    }

    // MARK: - Workflow

    /// Generates or refreshes the package’s Xcode project.
    ///
    /// - Parameters:
    ///     - reportProgress: A closure to execute for each line of the compiler’s output.
    ///
    /// - Throws: Either a `SwiftCompiler.Error` or an `ExternalProcess.Error`.
    @discardableResult public func generateXcodeProject(reportProgress: (String) -> Void = { _ in }) throws -> String {
        return try SwiftCompiler.generateXcodeProject(for: self, reportProgress: reportProgress)
    }

    /// Builds the package.
    ///
    /// - Throws: Either an `Xcode.Error` or an `ExternalProcess.Error`.
    @discardableResult public func build(for sdk: Xcode.SDK, reportProgress: (String) -> Void = { _ in }) throws -> String {
        return try Xcode.build(self, for: sdk, reportProgress: reportProgress)
    }
}
