/*
 RegressionTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax
#endif

import SDGSwiftSource

import XCTest

import SDGPersistenceTestUtilities
import SDGXCTestUtilities

import SDGSwiftTestUtilities

class RegressionTests: SDGSwiftTestUtilities.TestCase {

  func testCodeBlockWithCombiningCharacters() throws {
    // Untracked.

    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
      let source = [
        "/// ...",
        "///",
        "/// ```swift",
        "/// let ä = ö".decomposedStringWithCompatibilityMapping,
        "/// ```",
        "public func function() {}",
      ].joined(separator: "\n")
      let parsed = try SyntaxParser.parse(source: source)
      let documentation: SymbolDocumentation = parsed.api().first!.documentation.first!
      XCTAssertEqual(
        documentation.documentationComment.text,
        [
          "...",
          "",
          "```swift",
          "let ä = ö".decomposedStringWithCompatibilityMapping,
          "```",
        ].joined(separator: "\n")
      )
    #endif
  }

  func testContinuedCallout() throws {
    // Untracked.

    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
      let source = [
        "/// ...",
        "///",
        "/// \u{2D} Note: ...",
        "/// ...",
        "public func function() {}",
      ].joined(separator: "\n")
      let parsed = try SyntaxParser.parse(source: source)
      _ = parsed.api()
    #endif
  }

  func testMarkdownEntity() throws {
    // Untracked.

    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
      let source = [
        "/// ...&#x2D;...",
        "public func function() {}",
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

    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
      let source = [
        "/// ...",
        "///",
        "/// > Line 1",
        "/// >",
        "/// > Line 2",
        "/// >",
        "/// > Line 3",
        "public func function() {}",
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

    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
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
