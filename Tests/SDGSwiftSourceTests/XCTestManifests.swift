/*
 XCTestManifests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !canImport(ObjectiveC)
import XCTest

extension SDGSwiftSourceAPITests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SDGSwiftSourceAPITests = [
        ("testAPIParsing", testAPIParsing),
        ("testCallout", testCallout),
        ("testCodeFragmentSyntax", testCodeFragmentSyntax),
        ("testCoreLibraries", testCoreLibraries),
        ("testCSS", testCSS),
        ("testExtension", testExtension),
        ("testFunctionalSyntaxScanner", testFunctionalSyntaxScanner),
        ("testLineDeveloperCommentSyntax", testLineDeveloperCommentSyntax),
        ("testLineDocumentationCommentSyntax", testLineDocumentationCommentSyntax),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testLocations", testLocations),
        ("testParsing", testParsing),
        ("testTree", testTree),
        ("testTriviaPiece", testTriviaPiece),
    ]
}

extension SDGSwiftSourceInternalTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SDGSwiftSourceInternalTests = [
        ("testEmptySyntax", testEmptySyntax),
        ("testExtendedSyntaxContext", testExtendedSyntaxContext),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testStringLiteral", testStringLiteral),
        ("testTokenNormalization", testTokenNormalization),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SDGSwiftSourceAPITests.__allTests__SDGSwiftSourceAPITests),
        testCase(SDGSwiftSourceInternalTests.__allTests__SDGSwiftSourceInternalTests),
    ]
}
#endif
