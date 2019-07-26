/*
 RegressionTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGPersistence

import SDGSwift

import XCTest

import SDGXCTestUtilities

import SDGSwiftTestUtilities

class RegressionTests : TestCase {

    func testDependencyWarnings() throws {
        // Untracked.

        try withMock(named: "Warnings") { package in
            let build = try package.build().get()
            XCTAssert(SwiftCompiler.warningsOccurred(during: build))
        }
        try withMock(named: "DependentOnWarnings", dependentOn: ["Warnings"]) { package in
            let build = try package.build().get()
            XCTAssertFalse(SwiftCompiler.warningsOccurred(during: build))
        }
    }

    func testDynamicLinking() throws {
        // Untracked.

        try FileManager.default.withTemporaryDirectory(appropriateFor: nil) { moved in
            try withMockDynamicLinkedExecutable { mock in

                XCTAssertEqual(try Package(url: mock.location).execute(.development, of: ["tool"], with: [], cacheDirectory: moved).get(), "Hello, world!")
                XCTAssertEqual(try Package(url: mock.location).execute(.version(Version(1, 0, 0)), of: ["tool"], with: [], cacheDirectory: moved).get(), "Hello, world!")

                switch Package(url: mock.location).execute(.version(Version(1, 0, 0)), of: ["tool"], with: ["fail"], cacheDirectory: moved) {
                case .success:
                    XCTFail("Should have failed.")
                case .failure:
                    break
                }
            }
        }
    }
}