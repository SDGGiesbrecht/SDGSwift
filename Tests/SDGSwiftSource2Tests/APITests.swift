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
  }

  func testFragment() {
    XCTAssertEqual(
      Fragment(scalarOffsets: 1..<5, in: LineComment(source: "// ...\n")!).text,
      "/ .."
    )
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
  }

  func testLineDocumentation() {
    LineDocumentation.roundTripTest("/// ...")
    XCTAssertNil(LineDocumentation(source: "..."))
  }

  func testParsing() throws {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
      var first = true
      for url in try FileManager.default.deepFileEnumeration(in: beforeDirectory)
      where url.lastPathComponent ≠ ".DS_Store" {
        if first {
          first = false
          _ = try SwiftSyntaxNode(file: url)
        }
        SwiftSyntaxNode.roundTripTest(try String(from: url))
      }
    #endif
  }

  func testTriviaNode() {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
      XCTAssertEqual(TriviaNode(Trivia(pieces: [])).text, "")
    #endif
  }

  func testStringLiteral() {
    StringLiteral.roundTripTest("\u{22}...\u{22}")
    XCTAssertNil(StringLiteral(source: "...\u{22}"))
    XCTAssertNil(StringLiteral(source: "\u{22}..."))
  }
}
