/*
 SDGSwiftSourceTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
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
                let source = try String(from: url)

                let underline: Unicode.Scalar = "\u{332}"

                var unidentified = source
                for element in file.makeDeepIterator().reversed() where element is UnidentifiedSyntaxElement {
                    var index = element.range.upperBound
                    while index ≠ element.range.lowerBound {
                        unidentified.scalars.insert(underline, at: index)
                        index = source.scalars.index(before: index)
                    }
                }
                compare(unidentified, against: sourceDirectory.appendingPathComponent("Unidentified").appendingPathComponent(url.deletingPathExtension().lastPathComponent).appendingPathExtension("txt"), overwriteSpecificationInsteadOfFailing: false)
                XCTAssert(¬unidentified.scalars.contains(underline), "There are unidentified syntax elements in “\(url.lastPathComponent)”")
            }
        } catch {
            XCTFail("\(error)")
        }
    }
}
