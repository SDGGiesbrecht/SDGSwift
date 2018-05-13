/*
 SDGSwiftSourceTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGPersistenceTestUtilities
import SDGXCTestUtilities

import SDGSwiftSource

class SDGSwiftSourceTests : TestCase {

    func testParsing() {
        do {
            let sourceDirectory = testSpecificationDirectory().appendingPathComponent("Source")
            let beforeDirectory = sourceDirectory.appendingPathComponent("Before")
            for url in try FileManager.default.deepFileEnumeration(in: beforeDirectory) {
                let file = try File(from: url)
                // [_Warning: Needs to test (a) unidentifier regions, and (b) that there are none in the sample file._]
                for element in file.makeDeepIterator() {
                    print(element)
                }
            }
        } catch {
            XCTFail("\(error)")
        }
    }
}
