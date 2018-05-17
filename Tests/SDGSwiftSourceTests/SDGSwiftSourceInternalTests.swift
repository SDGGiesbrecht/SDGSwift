/*
 SDGSwiftSourceInternalTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@testable import SDGSwiftSource

import SDGLogicTestUtilities
import SDGXCTestUtilities

class SDGSwiftSourceInternalTests : TestCase {

    func testSourceKitUID() {
        do {
            testEquatableConformance(differingInstances: (try SourceKit.UID("A"), try SourceKit.UID("B")))
        } catch {
            XCTFail("\(error)")
        }
    }

    func testSourceKitVariant() {
        XCTAssertNotNil(SourceKit.Variant.dictionary(["": .string("")]).asAny() as? [String: Any])
        XCTAssertNotNil(SourceKit.Variant.array([.string("")]).asAny() as? [Any])
        XCTAssertNotNil(SourceKit.Variant.integer(0).asAny() as? Int)
        XCTAssertNotNil(SourceKit.Variant.string("").asAny() as? String)
        XCTAssertNotNil(SourceKit.Variant.boolean(false).asAny() as? Bool)
    }
}
