/*
 SDGSwiftSourceRegressionTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwiftSource

import XCTest

import SDGXCTestUtilities

class SDGSwiftSourceRegressionTests : TestCase {

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
        let parsed = try SyntaxTreeParser.parse(source)
        XCTAssertEqual(try SyntaxTreeParser.parse(source).source(), source)
        let documentation = parsed.api().first?.documentation
        XCTAssertEqual(documentation?.last?.documentationComment.text, "...\n\n> Line 1\n>\n> Line 2\n>\n> Line 3")
    }
}
