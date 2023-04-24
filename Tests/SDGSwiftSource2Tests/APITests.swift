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
    var cache = ParserCache()
    XCTAssertEqual(
      StringLiteral(
        source: "\u{22}...\u{22}"
      )?.text,
      "\u{22}...\u{22}"
    )
    XCTAssert(Token(kind: .swiftSyntax(.stringQuote)).children(cache: &cache).isEmpty)
    XCTAssertNil(StringLiteral(source: "...\u{22}"))
    XCTAssertNil(StringLiteral(source: "\u{22}..."))
    XCTAssertEqual(StringLiteral(source: "\u{22}...\u{22}")?.text, "\u{22}...\u{22}")
    XCTAssertEqual(CommentContent(source: "http://example.com").text, "http://example.com")
    XCTAssertEqual(CommentContent(source: "...\n...").text, "...\n...")
    XCTAssertEqual(
      LineComment(
        source: "// ..."
      )?.text,
      "// ..."
    )
    XCTAssertEqual(
      LineComment(source: "// MARK: \u{2D} Heading")?.text,
      "// MARK: \u{2D} Heading"
    )
    XCTAssertEqual(
      LineComment(source: "// ... http://example.com ...")?.text,
      "// ... http://example.com ..."
    )
    XCTAssertEqual(LineComment(source: "//...")?.text, "//...")
    XCTAssertEqual(
      Fragment(scalarOffsets: 1..<5, in: LineComment(source: "// ...\n")!).text,
      "/ .."
    )
    XCTAssertEqual(BlockComment(source: "/* ... */")?.text, "/* ... */")
    XCTAssertEqual(BlockComment(source: "/*\n ...\n */")?.text, "/*\n ...\n */")
    XCTAssertEqual(BlockComment(source: "/*...*/")?.text, "/*...*/")
    XCTAssertEqual(BlockComment(source: "/**/")?.text, "/**/")
    let missingIndent = [
      "/*",
      " ...",
      " ...",
      "...",  // Missing indent.
      " */",
    ].joined(separator: "\n")
    XCTAssertEqual(BlockComment(source: missingIndent)?.text, missingIndent)
    XCTAssertEqual(LineDocumentation(source: "/// ...")?.text, "/// ...")
    XCTAssertEqual(BlockDocumentation(source: "/** ... */")?.text, "/** ... */")
  }

  func testExtendedTokenKind() {
    XCTAssertEqual(Token.Kind.whitespace(" ").text, " ")
    XCTAssertEqual(Token.Kind.lineBreaks("\n").text, "\n")
    XCTAssertEqual(Token.Kind.source("...").text, "...")
  }

  func testParsing() throws {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
      for url in try FileManager.default.deepFileEnumeration(in: beforeDirectory)
      where url.lastPathComponent ≠ ".DS_Store" {
        let sourceFile = try SwiftSyntaxNode(file: url)

        let originalSource = try String(from: url)
        XCTAssertEqual(sourceFile.text, originalSource)

        struct DefaultSyntaxScanner: SyntaxScanner {
          var cache = ParserCache()
        }
        var defaultScanner = DefaultSyntaxScanner()
        defaultScanner.scan(sourceFile)

        struct RoundTripSyntaxScanner: SyntaxScanner {
          var result = ""
          mutating func visit(_ node: SyntaxNode) -> Bool {
            if let token = node as? Token {
              result.append(contentsOf: token.text)
            }
            return true
          }
          var cache = ParserCache()
        }
        var syntaxScanner = RoundTripSyntaxScanner()
        syntaxScanner.scan(sourceFile)
        XCTAssertEqual(syntaxScanner.result, originalSource)
      }
    #endif
  }
}
