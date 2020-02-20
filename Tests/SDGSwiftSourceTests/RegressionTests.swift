/*
 RegressionTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

#if (os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
  import SDGSwiftSource
#endif

import XCTest

import SDGPersistenceTestUtilities
import SDGXCTestUtilities

import SDGSwiftTestUtilities

class RegressionTests: SDGSwiftTestUtilities.TestCase {

  func testContinuedCallout() throws {
    // Untracked.

    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
      let source = [
        "/// ...",
        "///",
        "/// \u{2D} Note: ...",
        "/// ...",
        "public func function() {}"
      ].joined(separator: "\n")
      let parsed = try SyntaxParser.parse(source: source)
      _ = parsed.api()
    #endif
  }

  func testMarkdownEntity() throws {
    // Untracked.

    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
      let source = [
        "/// ...&#x2D;...",
        "public func function() {}"
      ].joined(separator: "\n")
      let parsed = try SyntaxParser.parse(source: source)
      XCTAssertEqual(parsed.source(), source)
      let documentation = parsed.api().first?.documentation
      let comment = documentation?.last?.documentationComment
      XCTAssertEqual(comment?.text, "...&#x2D;...")
      XCTAssertEqual(comment?.renderedHTML(localization: "en"), "<p>...&#x2D;...</p>")
    #endif
  }

  func testMarkdownQuotation() throws {
    // Untracked.

    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
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
      let parsed = try SyntaxParser.parse(source: source)
      XCTAssertEqual(try SyntaxParser.parse(source: source).source(), source)
      let documentation = parsed.api().first?.documentation
      XCTAssertEqual(
        documentation?.last?.documentationComment.text,
        "...\n\n> Line 1\n>\n> Line 2\n>\n> Line 3"
      )
    #endif
  }

  func testPackageDeclaration() {
    // Untracked.

    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
      let declaration = FunctionCallExprSyntax.packageDeclaration(named: "SomePackage")
      let highlighted = declaration.syntaxHighlightedHTML(
        inline: false,
        internalIdentifiers: ["SomePackage"],
        symbolLinks: ["SomePackage": "some/page"]
      )
      let html = HTMLPage(
        content: highlighted,
        cssPath: "../../../Resources/SDGSwiftSource/Syntax%20Highlighting.css"
      )
      let location = testSpecificationDirectory().appendingPathComponent(
        "Source/Package Declaration.html"
      )
      compare(html, against: location, overwriteSpecificationInsteadOfFailing: false)
    #endif
  }
}
