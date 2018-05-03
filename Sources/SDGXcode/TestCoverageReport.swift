/*
 TestCoverageReport.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A test coverage report.
public struct TestCoverageReport {

    internal init(files: [FileTestCoverage]) {
        self.files = files
    }

    // MARK: - Properties

    /// The files in the package.
    public let files: [FileTestCoverage]
}
