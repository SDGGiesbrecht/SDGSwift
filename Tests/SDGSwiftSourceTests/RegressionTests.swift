/*
 RegressionTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

import SDGSwiftSource

import XCTest

import SDGXCTestUtilities

class RegressionTests : TestCase {

    func testMarkdownQuotation() throws {
        // Untracked.

        let source = [
            "/// ...",
            "///",
            "/// > Line 1",
            "/// >",
            "/// > Line 2",
            "/// >",
            "/// > Line 3",
            "public func function() {}"
        ].joined(separator: "\n")
        let parsed = try SyntaxParser.parse(source)
        XCTAssertEqual(try SyntaxParser.parse(source).source(), source)
        let documentation = parsed.api().first?.documentation
        XCTAssertEqual(documentation?.last?.documentationComment.text, "...\n\n> Line 1\n>\n> Line 2\n>\n> Line 3")
    }

    func testUnknown() throws {

        let source = [
        "/// Return a dictionary of header fields that can be used to add the",
        "/// specified cookies to the request.",
        "///",
        "/// - Parameter cookies: The cookies to turn into request headers.",
        "/// - Returns: A dictionary where the keys are header field names, and the values",
        "/// are the corresponding header field values.",
        "open class func requestHeaderFields(with cookies: [HTTPCookie]) -> [String : String] {",
        "}"
        ].joined(separator: "\n")
        let parsed = try SyntaxParser.parse(source)
        //_ = parsed.api()
    }
}
