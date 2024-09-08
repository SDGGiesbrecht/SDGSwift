/*
 APITests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGLogic
import SDGPersistence

  import SwiftSyntax
#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
  import SwiftSyntaxParser
#endif

import SDGSwiftSource

import SDGSwiftLocalizations

import XCTest

import SDGPersistenceTestUtilities
import SDGSwiftTestUtilities

class APITests: SDGSwiftTestUtilities.TestCase {

  func testAnySyntaxNode() {
    XCTAssertEqual(AnySyntaxNode(LineComment(source: "// ...")!).text(), "// ...")
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
    BlockComment.roundTripTest(
      [
        "/*",
        " ...",
        " ...",
        "...",  // Missing indent.
        " */",
      ].joined(separator: "\r\n")
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

  func testCalloutNode() {
    let documentation = DocumentationContent(
      source: [
        "A description.",
        "",
        "\u{2D} Warning: A warning.",
      ].joined(separator: "\n")
    )
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN
    var found = false
    documentation.scanSyntaxTree({ node, _ in
      if node is CalloutNode {
        found = true
      }
      return ¬found
    })
    XCTAssert(found)
    #endif
  }

  func testClosureSyntaxScanner() {
    Token(kind: .whitespace(" "))
      .scanSyntaxTree({ node, context in
        return true
      })
  }

  func testCodeBlockNode() {
    CodeBlockNode.roundTripTest(
      [
        "```swift",
        "print(\u{22}Hello, world!\u{22})",
        "```",
      ].joined(separator: "\n")
    )
    XCTAssertNil(CodeBlockNode(source: "Not code."))
    XCTAssertNil(CodeBlockNode(source: "```...```"))
    XCTAssertNil(
      CodeBlockNode(
        source: [
          "```",
          "Unterminated...",
        ].joined(separator: "\n")
      )
    )
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
    DocumentationContent.roundTripTest(
      [
        "\u{2D} First list entry.",
        "\u{2D} Second list entry.",
      ].joined(separator: "\n")
    )
    DocumentationContent.roundTripTest(
      [
        "Line  ",
        "Break",
      ].joined(separator: "\n")
    )
    DocumentationContent.roundTripTest("\u{2D} Warning: Watch out!")
    DocumentationContent.roundTripTest(
      [
        "\u{2D} Parameters:",
        "   \u{2D} first: The first parameter.",
        "   \u{2D} second: The second parameter.",
      ].joined(separator: "\n")
    )
    DocumentationContent.roundTripTest("\u{2D} ***")
    DocumentationContent.roundTripTest("\u{2D} *emphasis*")
    DocumentationContent.roundTripTest(
      [
        "\u{2D} Parameters:",
        "   \u{2D} This is actually a list.",
        "   \u{2D} ***",
        "   \u{2D} *emphasis*",
        "   \u{2D} colonless",
      ].joined(separator: "\n")
    )
    DocumentationContent.roundTripTest("\u{2D} parameter aParameter: Description.")
    DocumentationContent.roundTripTest(
      [
        "```not‐swift",
        "```",
      ].joined(separator: "\n")
    )
    DocumentationContent.roundTripTest("![image](somewhere)")
    DocumentationContent.roundTripTest("> Quotation.")
    DocumentationContent.roundTripTest("**Strong**.")
    DocumentationContent.roundTripTest(
      [
        "Heading",
        "=======",
        "",
        "Paragraph.",
      ].joined(separator: "\n")
    )
    DocumentationContent.roundTripTest("[link](somewhere)")
    DocumentationContent.roundTripTest(
      [
        "...",
        "",
        "***",
        "",
        "...",
      ].joined(separator: "\n")
    )
  }

  func testFragment() {
    let fragment = Fragment(scalarOffsets: 1..<5, in: LineComment(source: "// ...\n")!)
    let fragmentSource = "/ .."
    XCTAssertEqual(fragment.text(), fragmentSource)
    var scanner = RoundTripSyntaxScanner()
    scanner.scan(fragment)
    XCTAssertEqual(scanner.result, fragmentSource)
  }

  func testFunctionParameterSyntax() {
    // #workaround(Swift 5.8.0, Web compiler bug leads to out of bounds memory access.)
    #if !os(WASI)
    XCTAssertEqual(FunctionParameterSyntax(
      firstName: TokenSyntax(.identifier("first"), presence: .present),
      secondName: TokenSyntax(.identifier("second"), leadingTrivia: .space, presence: .present)
    ).internalName?.text, "second")
    XCTAssertEqual(FunctionParameterSyntax(
      firstName: TokenSyntax(.identifier("first"), presence: .present),
      secondName: nil
    ).internalName?.text, "first")
    #endif
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
    var found = false
    DocumentationContent(source: "#### Heading").scanSyntaxTree { node, _ in
      if let heading = node as? NumberedHeading {
        found = true
        XCTAssertEqual(heading.level, 4)
      }
      return true
    }
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN
      XCTAssert(found)
    #endif
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

        #if os(Windows)
          _ = try SwiftSyntaxNode(file: url)
          var source = try String(from: url)
          source.unicodeScalars.replaceMatches(for: "\r".scalars, with: "".scalars)
          let parsed = try SwiftSyntaxNode(source: source)
        #else
          let parsed = try SwiftSyntaxNode(file: url)
        #endif

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

  func testScanContext() {
      var foundDelimiter = false
      TriviaNode(.lineComment("// ...")).scanSyntaxTree({ (node, context) in
        if node.text() == "//" {
          foundDelimiter = true
          XCTAssert(¬context.isCompiled())
        }
        return true
      })
      XCTAssert(foundDelimiter)
    var foundElipsis = false
    StringLiteral(source: "\u{22}...\u{22}")?.scanSyntaxTree({ (node, context) in
      if node.text() == "..." {
        foundElipsis = true
        XCTAssert(context.isCompiled())
      }
      return true
    })
    XCTAssert(foundElipsis)
  }

  func testStringLiteral() {
    StringLiteral.roundTripTest("\u{22}...\u{22}")
    XCTAssertNil(StringLiteral(source: "...\u{22}"))
    XCTAssertNil(StringLiteral(source: "\u{22}..."))
  }

  func testSyntaxProtocol() {
    // #workaround(Swift 5.8.0, Web compiler bug leads to out of bounds memory access.)
    #if !os(WASI)
      let declaration = ImportDeclSyntax(
        path: AccessPathSyntax([AccessPathSyntax.Element(name: .identifier("Foundation"))])
      )
      XCTAssert(Array(declaration.ancestors).isEmpty)
      XCTAssertEqual(declaration.firstToken()?.ancestors.map({ $0 }).isEmpty, false)
      XCTAssertNotNil(declaration.firstToken())
      XCTAssertNotNil(declaration.lastToken())
      XCTAssert(declaration.text().hasSuffix("Foundation"))
    #endif
  }

  func testTokenKind() {
    XCTAssertEqual(Token.Kind.commentText("...").textFreedom(localAncestors: []), .arbitrary)
    XCTAssertEqual(Token.Kind.lineCommentDelimiter.textFreedom(localAncestors: []), .invariable)
  }

  func testTriviaNode() {
      XCTAssertEqual(TriviaNode(Trivia(pieces: [])).text(), "")
  }

  func testTriviaPieceNode() {
    var cache = ParserCache()
    for piece in [
      .unexpectedText("?!?"),
      .lineComment("?!?"),
      .blockComment("?!?"),
      .docLineComment("?!?"),
      .docBlockComment("?!?")
    ] as [TriviaPiece] {
      _ = TriviaPieceNode(piece, precedingDocumentationContext: nil, followingDocumentationContext: nil)
        .children(cache: &cache)
    }
  }

  func testUnderlinedHeading() {
    var foundOne = false
    var foundTwo = false
    DocumentationContent(source: [
      "One",
      "===",
      "",
      "Two",
      "\u{2D}\u{2D}\u{2D}",
      "",
      "..."
    ].joined(separator: "\n")).scanSyntaxTree { node, _ in
      if let heading = node as? UnderlinedHeading {
        switch heading.level {
        case 1:
          foundOne = true
        case 2:
          foundTwo = true
        default:
          break
        }
      }
      return true
    }
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN
      XCTAssert(foundOne)
      XCTAssert(foundTwo)
    #endif
  }
}
