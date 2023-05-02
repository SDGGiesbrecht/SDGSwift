/*
 APITests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGLogic
import SDGPersistence

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax
#endif
#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
  import SwiftSyntaxParser
#endif

import SDGSwiftSource2

import XCTest

import SDGSwiftTestUtilities

class APITests: SDGSwiftTestUtilities.TestCase {

  func testAnySyntaxNode() {
    XCTAssertEqual(AnySyntaxNode(LineComment(source: "// ...")!).text, "// ...")
  }

  func testBlockComment() {
    BlockComment.roundTripTest("/* ... */")
    BlockComment.roundTripTest("/*\n ...\n */")
    BlockComment.roundTripTest("/*...*/")
    BlockComment.roundTripTest("/**/")
    BlockComment.roundTripTest(
      [
        "/*",
        " ...",
        " ...",
        "...",  // Missing indent.
        " */",
      ].joined(separator: "\n")
    )
    XCTAssertNil(BlockComment(source: "..."))
    XCTAssertNil(BlockComment(source: "/* ..."))
  }

  func testBlockDocumentation() {
    BlockDocumentation.roundTripTest("/** ... */")
    BlockDocumentation.roundTripTest(
      [
        "/**",
        "   ...",
        "",
        "   ...",
        "   */",
      ].joined(separator: "\n")
    )
    XCTAssertNil(BlockDocumentation(source: "..."))
  }

  func testCodeContent() {
    CodeContent.roundTripTest("print(\u{22}Hello, world!\u{22})")
    let other = CodeContent(source: "This is not Swift.", isSwift: false)
    var cache = ParserCache()
    _ = other.children(cache: &cache)
  }

  func testCommentContent() {
    CommentContent.roundTripTest("http://example.com")
    CommentContent.roundTripTest("...\n...")
  }

  func testDocumentationContent() {
    DocumentationContent.roundTripTest(
      [
        "...",
        "",
        "...",
      ].joined(separator: "\n")
    )
    DocumentationContent.roundTripTest("`©`")
    DocumentationContent.roundTripTest(
      [
        "... ...",
        "=======",
      ].joined(separator: "\n")
    )
    DocumentationContent.roundTripTest(
      [
        "...",
        "...",
      ].joined(separator: "\n")
    )
    DocumentationContent.roundTripTest("# Heading")
    DocumentationContent.roundTripTest(
      [
        "Heading",
        "=======",
      ].joined(separator: "\n")
    )
  }

  func testFragment() {
    let fragment = Fragment(scalarOffsets: 1..<5, in: LineComment(source: "// ...\n")!)
    let fragmentSource = "/ .."
    XCTAssertEqual(fragment.text, fragmentSource)
    var scanner = RoundTripSyntaxScanner()
    scanner.scan(fragment)
    XCTAssertEqual(scanner.result, fragmentSource)
  }

  func testInlineCodeNode() {
    XCTAssertNil(InlineCodeNode(source: "..."))
    XCTAssertNil(InlineCodeNode(source: "`..."))
  }

  func testLineComment() {
    LineComment.roundTripTest("// ...")
    LineComment.roundTripTest("// MARK: \u{2D} Heading")
    LineComment.roundTripTest("// ... http://example.com ...")
    XCTAssertNil(LineComment(source: "..."))
    LineComment.roundTripTest("//...")
  }

  func testLineDocumentation() {
    LineDocumentation.roundTripTest("/// ...")
    XCTAssertNil(LineDocumentation(source: "..."))
  }

  func testNumberedHeading() {
    NumberedHeading.roundTripTest("# Heading")
    NumberedHeading.roundTripTest("#Heading")
    XCTAssertNil(NumberedHeading(source: "Not a Heading"))
  }

  func testParsing() throws {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
      var first = true
      for url in try FileManager.default.deepFileEnumeration(in: beforeDirectory)
      where url.lastPathComponent ≠ ".DS_Store" {
        if first {
          first = false
          _ = try SwiftSyntaxNode(file: url)
        }
        SwiftSyntaxNode.roundTripTest(try String(from: url))

        let parsed = try SwiftSyntaxNode(file: url)

        var unknown = UnknownHighlighter()
        try unknown.assertHighlightsNothing(in: parsed, "Unknown tokens detected in “\(url.path)”")

        var arbitrary = TextFreedomHighlighter(targetTestFreedom: .arbitrary)
        try arbitrary.compare(
          syntax: parsed,
          parsedFrom: url,
          againstSpecification: "Arbitrary Text",
          overwriteSpecificationInsteadOfFailing: false
        )
        var aliasable = TextFreedomHighlighter(targetTestFreedom: .aliasable)
        try aliasable.compare(
          syntax: parsed,
          parsedFrom: url,
          againstSpecification: "Aliasable Text",
          overwriteSpecificationInsteadOfFailing: false
        )
        var invariable = TextFreedomHighlighter(targetTestFreedom: .invariable)
        try invariable.compare(
          syntax: parsed,
          parsedFrom: url,
          againstSpecification: "Invariable Text",
          overwriteSpecificationInsteadOfFailing: false
        )
      }
    #endif
  }

  func testStringLiteral() {
    StringLiteral.roundTripTest("\u{22}...\u{22}")
    XCTAssertNil(StringLiteral(source: "...\u{22}"))
    XCTAssertNil(StringLiteral(source: "\u{22}..."))
  }

  func testTriviaNode() {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
      XCTAssertEqual(TriviaNode(Trivia(pieces: [])).text, "")
    #endif
  }

  func testUnderlinedHeading() {
    XCTAssertNil(UnderlinedHeading(source: "Not a heading"))
    UnderlinedHeading.roundTripTest(
      [
        "Heading",
        "\u{2D}\u{2D}\u{2D}\u{2D}\u{2D}\u{2D}\u{2D}",
      ].joined(separator: "\n")
    )
    XCTAssertNil(
      UnderlinedHeading(
        source: [
          "Not a",
          "heading",
        ].joined(separator: "\n")
      )
    )
  }
}
