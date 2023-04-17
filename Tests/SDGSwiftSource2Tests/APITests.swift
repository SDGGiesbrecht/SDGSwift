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

  func testExtendedParsing() {
    XCTAssertEqual(
      StringLiteralSyntax(
        string: ExtendedTokenSyntax(kind: .string("..."))
      ).text,
      "\u{22}...\u{22}"
    )
    XCTAssert(ExtendedTokenSyntax(kind: .quotationMark).children.isEmpty)
    XCTAssertNil(StringLiteralSyntax(source: "...\u{22}"))
    XCTAssertNil(StringLiteralSyntax(source: "\u{22}..."))
    XCTAssertEqual(StringLiteralSyntax(source: "\u{22}...\u{22}")?.text, "\u{22}...\u{22}")
    XCTAssertEqual(CommentContentSyntax(source: "http://example.com").text, "http://example.com")
    XCTAssertEqual(CommentContentSyntax(source: "...\n...").text, "...\n...")
    XCTAssertEqual(
      LineCommentSyntax(
        delimiter: ExtendedTokenSyntax(kind: .lineCommentDelimiter),
        indent: ExtendedTokenSyntax(kind: .whitespace(" ")),
        content: CommentContentSyntax(source: "...")
      ).text,
      "// ..."
    )
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
      XCTAssertNotNil(TriviaPiece.lineComment("//...").extended)
    #endif
    XCTAssertEqual(
      LineCommentSyntax(source: "// MARK: \u{2D} Heading").text,
      "// MARK: \u{2D} Heading"
    )
    XCTAssertEqual(
      LineCommentSyntax(source: "// ... http://example.com ...").text,
      "// ... http://example.com ..."
    )
    XCTAssertEqual(LineCommentSyntax(source: "//...").text, "//...")
    XCTAssertNotNil(
      SourceHeadingSyntax(heading: ExtendedTokenSyntax(kind: .sourceHeadingText("..."))).children
    )
    XCTAssertEqual(
      FragmentSyntax(scalarOffsets: 1..<5, in: LineCommentSyntax(source: "// ...\n")).text,
      "/ .."
    )
    XCTAssertEqual(BlockCommentSyntax(source: "/* ... */").text, "/* ... */")
    XCTAssertEqual(BlockCommentSyntax(source: "/*\n ...\n */").text, "/*\n ...\n */")
    XCTAssertEqual(BlockCommentSyntax(source: "/*...*/").text, "/*...*/")
    XCTAssertEqual(BlockCommentSyntax(source: "/**/").text, "/**/")
    let missingIndent = [
      "/*",
      " ...",
      " ...",
      "...",  // Missing indent.
      " */",
    ].joined(separator: "\n")
    XCTAssertEqual(BlockCommentSyntax(source: missingIndent).text, missingIndent)
    XCTAssertEqual(LineDocumentationSyntax(source: "/// ...").text, "/// ...")
  }

  func testExtendedTokenKind() {
    XCTAssertEqual(ExtendedTokenKind.whitespace(" ").text, " ")
    XCTAssertEqual(ExtendedTokenKind.lineBreaks("\n").text, "\n")
    XCTAssertEqual(ExtendedTokenKind.source("...").text, "...")
    XCTAssertEqual(ExtendedTokenKind.skipped("...").text, "...")
  }

  func testParsing() throws {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
      for url in try FileManager.default.deepFileEnumeration(in: beforeDirectory)
      where url.lastPathComponent ≠ ".DS_Store" {
        let sourceFile = try SyntaxParser.parse(url)

        let originalSource = try String(from: url)
        var roundTripSource = ""
        sourceFile.write(to: &roundTripSource)
        XCTAssertEqual(roundTripSource, originalSource)

        struct DefaultSyntaxScanner: SyntaxScanner {}
        var defaultScanner = DefaultSyntaxScanner()
        defaultScanner.scan(sourceFile)

        struct RoundTripSyntaxScanner: SyntaxScanner {
          var result = ""
          mutating func visit(
            _ node: Syntax,
            context: SyntaxContext
          ) -> Bool {
            if let token = node.as(TokenSyntax.self) {
              result.append(contentsOf: token.text)
            }
            return true
          }
          mutating func visit(
            _ node: ExtendedSyntax,
            context: ExtendedSyntaxContext
          ) -> Bool {
            if let token = node as? ExtendedTokenSyntax {
              result.append(contentsOf: token.text)
            }
            return true
          }
        }
        var syntaxScanner = RoundTripSyntaxScanner()
        syntaxScanner.scan(sourceFile)
        XCTAssertEqual(syntaxScanner.result, originalSource)
      }
    #endif
  }
}
