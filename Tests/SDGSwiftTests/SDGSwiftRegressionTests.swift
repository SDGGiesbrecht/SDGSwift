/*
 SDGSwiftRegressionTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGPersistence
import SDGXCTestUtilities

import SDGSwift
import SDGSwiftTestUtilities

class SDGSwiftRegressionTests : TestCase {

    func testDynamicLinking() {
        // Untracked.

        #if os(macOS) // Never was an issue on Linux.
        let moved = FileManager.default.url(in: .temporary, at: "Moved")
        defer { try? FileManager.default.removeItem(at: moved) }
        withMockDynamicLinkedExecutable { mock in
            XCTAssertEqual(try Package(url: mock.location).execute(.development, of: ["tool"], with: [], cacheDirectory: moved), "Hello, world!")
            XCTAssertEqual(try Package(url: mock.location).execute(.version(Version(1, 0, 0)), of: ["tool"], with: [], cacheDirectory: moved), "Hello, world!")
        }
        #endif
    }
}
