/*
 XCTestManifests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

extension SDGSwiftSourceAPITests {
    static let __allTests = [
        ("testAPIParsing", testAPIParsing),
        ("testCallout", testCallout),
        ("testCodeFragmentSyntax", testCodeFragmentSyntax),
        ("testCSS", testCSS),
        ("testExtension", testExtension),
        ("testFunctionalSyntaxScanner", testFunctionalSyntaxScanner),
        ("testLineDeveloperCommentSyntax", testLineDeveloperCommentSyntax),
        ("testLineDocumentationCommentSyntax", testLineDocumentationCommentSyntax),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testLocations", testLocations),
        ("testParsing", testParsing),
        ("testTree", testTree)
    ]
}

extension SDGSwiftSourceInternalTests {
    static let __allTests = [
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testTokenNormalization", testTokenNormalization)
    ]
}

#if !canImport(ObjectiveC)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SDGSwiftSourceAPITests.__allTests),
        testCase(SDGSwiftSourceInternalTests.__allTests),
    ]
}
#endif
