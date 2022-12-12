/*
 APITests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics
import SDGCollections

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax
#endif
#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
  import SwiftSyntaxParser
#endif

import SDGSwift
import SDGSwiftLocalizations
import SDGSwiftPackageManager
import SDGSwiftSource

import XCTest

import SDGPersistenceTestUtilities
import SDGLocalizationTestUtilities
import SDGXCTestUtilities

import SDGSwiftTestUtilities

class APITests: SDGSwiftTestUtilities.TestCase {

  func testCallout() {
    for localization in InterfaceLocalization.allCases {
      let specification = Callout.allCases
        .map({ $0.localizedText(localization.code) })
        .joined(separator: "\n")
      compare(
        String(specification),
        against: testSpecificationDirectory().appendingPathComponent(
          "Localization/Callouts/\(localization.icon!).txt"
        ),
        overwriteSpecificationInsteadOfFailing: false
      )
    }
    XCTAssertNotNil(Callout("Returns"))
    XCTAssertNil(Callout("no‐such‐callout"))
    XCTAssertEqual(Callout("Returns")?.localizedText("zxx"), "Returns")
  }

  func testCodeFragmentSyntax() throws {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
      let source = "\u{2F}\u{2F}/ `selector(style:notation:)`\nfunc function() \n \n {}"

      let syntax = try SyntaxParser.parse(source: source)
      let highlighted = syntax.syntaxHighlightedHTML(
        inline: true,
        internalIdentifiers: ["selector(style:notation:)"],
        symbolLinks: ["selector(style:notation:)": "domain.tld"]
      )
      XCTAssert(highlighted.contains("internal identifier"))
      XCTAssert(highlighted.contains("domain.tld"))

      var foundFunction = false
      var foundSpaces = false
      var foundNewline = false
      var foundCode = false
      var foundCodeDelimiters = false
      var foundColon = false
      var foundPreviousTrivia = false
      var foundNextTrivia = false
      var foundDocumentationComment = false
      try FunctionalSyntaxScanner(
        checkSyntax: { syntax, context in
          if let token = syntax.as(TokenSyntax.self) {
            if token.tokenKind == .colon {
              foundColon = true
              XCTAssertEqual(source[source.indices(of: token.syntaxRange(in: context))], ":")
            } else if token.tokenKind == .funcKeyword {
              foundFunction = true
              XCTAssertEqual(source[source.indices(of: token.syntaxRange(in: context))], "func")
            }
          }
          return true
        },
        checkExtendedSyntax: { syntax, context in
          if let token = syntax as? ExtendedTokenSyntax,
            token.kind == .codeDelimiter
          {
            foundCodeDelimiters = true
            XCTAssertEqual(source[source.indices(of: token.range(in: context))], "`")
          } else if syntax is InlineCodeSyntax {
            foundCode = true
            XCTAssertEqual(
              source[source.indices(of: syntax.range(in: context))],
              "`selector(style:notation:)`"
            )
          }
          return true
        },
        checkTrivia: { trivia, context in
          if trivia.source() == " " {
            foundSpaces = true
            XCTAssertEqual(source[source.indices(of: trivia.range(in: context))], " ")
          }
          XCTAssertEqual(trivia.upperBound(in: context), trivia.range(in: context).upperBound)
          foundPreviousTrivia ∨= trivia.previousTrivia(context: context) ≠ nil
          foundNextTrivia ∨= trivia.nextTrivia(context: context) ≠ nil
          XCTAssertNotNil(trivia.parentToken(context: context))
          return true
        },
        checkTriviaPiece: { trivia, context in
          if case .newlines = trivia {
            foundNewline = true
            XCTAssertEqual(source[source.indices(of: trivia.range(in: context))], "\n")
            if trivia.parentTrivia(context: context)?.count == 2 {
              XCTAssert(trivia.previousTriviaPiece(context: context)?.text.hasPrefix("/") == true)
            }
          } else if case .docLineComment = trivia {
            foundDocumentationComment = true
            XCTAssertEqual(trivia.nextTriviaPiece(context: context)?.text, "\n")
            XCTAssertEqual(
              trivia.parentTrivia(context: context)?.indices.first,
              trivia.indexInParent(context: context)
            )
          }
          return true
        }
      ).scan(syntax)
      XCTAssertTrue(foundFunction)
      XCTAssertTrue(foundSpaces)
      XCTAssertTrue(foundNewline)
      XCTAssertTrue(foundCode)
      XCTAssertTrue(foundCodeDelimiters)
      XCTAssertTrue(foundColon)
      XCTAssertTrue(foundPreviousTrivia)
      XCTAssertTrue(foundNextTrivia)
      XCTAssertTrue(foundDocumentationComment)

      let moreSource =
        "@available(*, unavailable, renamed: \u{22}new\u{22}) func function() {}\n/// ```swift\n/// /*\n/// Comment.\n/// */\n/// ```\nlet y = 0"
      let moreSyntax = try SyntaxParser.parse(source: moreSource)
      var foundQuotationMark = false
      var foundComment = false
      try FunctionalSyntaxScanner(
        checkExtendedSyntax: { syntax, context in
          if let token = syntax as? ExtendedTokenSyntax,
            token.kind == .quotationMark
          {
            foundQuotationMark = true
            XCTAssertEqual(moreSource[moreSource.indices(of: token.range(in: context))], "\u{22}")
          } else if let token = syntax as? ExtendedTokenSyntax,
            token.kind == .commentText
          {
            foundComment = true
            XCTAssertEqual(
              moreSource[moreSource.indices(of: token.range(in: context))],
              "Comment."
            )
          }
          return true
        }).scan(moreSyntax)
      XCTAssertTrue(foundQuotationMark)
      XCTAssertTrue(foundComment)

      let evenMoreSource = "/// ```swift\n///\n/// // Comment.\n///\n/// ```\nlet y = 0"

      let evenMoreSyntax = try SyntaxParser.parse(source: evenMoreSource)
      var foundTriviaFragment = false
      var foundCommentSyntax = false
      try FunctionalSyntaxScanner(
        checkExtendedSyntax: { syntax, context in
          if syntax is LineDeveloperCommentSyntax {
            foundCommentSyntax = true
            XCTAssertEqual(
              evenMoreSource[evenMoreSource.indices(of: syntax.range(in: context))],
              "// Comment."
            )
          }
          return true
        },
        checkTriviaPiece: { trivia, context in
          if case .lineComment = trivia,
            ¬trivia.text.isEmpty
          {
            foundTriviaFragment = true
            XCTAssertEqual(
              evenMoreSource[evenMoreSource.indices(of: trivia.range(in: context))],
              "// Comment."
            )
            XCTAssertEqual(trivia.upperBound(in: context), trivia.range(in: context).upperBound)
            XCTAssertNil(trivia.parentTrivia(context: context))
            XCTAssertNil(trivia.nextTriviaPiece(context: context))
            XCTAssertNil(trivia.previousTriviaPiece(context: context))
          }
          return true
        }
      ).scan(evenMoreSyntax)
      XCTAssertTrue(foundTriviaFragment)
      XCTAssertTrue(foundCommentSyntax)

      let yetMoreSource = "/// ```swift\n/// let x = 0\n/// ```\nlet y = 0"
      let yetMoreSyntax = try SyntaxParser.parse(source: yetMoreSource)
      var foundX = false
      var foundY = false
      try FunctionalSyntaxScanner(
        checkSyntax: { syntax, context in
          if let token = syntax.as(TokenSyntax.self) {
            if token.text == "x" {
              foundX = true
              XCTAssert(context.isFragmented())
            } else if token.text == "y" {
              foundY = true
              XCTAssertFalse(context.isFragmented())
            }
          }
          return true
        }).scan(yetMoreSyntax)
      XCTAssertTrue(foundX)
      XCTAssertTrue(foundY)
    #endif
  }

  func testCoreLibraries() throws {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER

      let syntax = try SyntaxParser.parse(
        URL(fileURLWithPath: #filePath).deletingLastPathComponent().deletingLastPathComponent()
          .deletingLastPathComponent().appendingPathComponent(
            "Sources/SDGSwiftSource/Core Libraries/Swift.txt"
          )
      )
      var foundLessThan = false
      var foundEncodable = false
      try FunctionalSyntaxScanner(
        checkSyntax: { syntax, _ in
          if let function = syntax.as(FunctionDeclSyntax.self) {
            XCTAssert(function.identifier.text ≠ "", "Corrupt function:\n\(function)")
            if function.identifier.text == "<" {
              foundLessThan = true
            }
          } else if let `protocol` = syntax.as(ProtocolDeclSyntax.self) {
            if `protocol`.identifier.text == "Encodable" {
              foundEncodable = true
            }
          }
          return true
        },
        shouldExtendToken: { _ in false },
        shouldExtendFragment: { _ in false }
      ).scan(syntax)
      XCTAssert(foundLessThan)
      XCTAssert(foundEncodable)
    #endif
  }

  func testCSS() {
    XCTAssert(¬SyntaxHighlighter.css.contains("Apache"))
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
      let highlighted = SyntaxFactory.makeVariableDecl(
        attributes: nil,
        modifiers: nil,
        letOrVarKeyword: SyntaxFactory.makeToken(.letKeyword),
        bindings: SyntaxFactory.makePatternBindingList([])
      )
      .syntaxHighlightedHTML(inline: true)
      XCTAssert(
        highlighted.contains("TokenSyntax letKeyword"),
        highlighted
      )
      XCTAssert(
        highlighted.contains("VariableDeclSyntax"),
        highlighted
      )
    #endif
  }

  func testExtendedTokenKind() {
    XCTAssertEqual(ExtendedTokenKind.string.textFreedom, .arbitrary)
    XCTAssertEqual(ExtendedTokenKind.quotationMark.textFreedom, .invariable)
  }

  func testFunctionalSyntaxScanner() throws {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
      let source = [
        "/// ```swift",
        "/// print(\u{22}Hello, world!\u{22})",
        "/// ```",
        "func helloWorld() {",
        "    print(\u{22}Hello, world!\u{22})",
        "}",
      ].joined(separator: "\n")

      let syntax = try SyntaxParser.parse(source: source)

      var scanned: Set<String> = []
      var foundCodeDelimiter = false
      let scanner = FunctionalSyntaxScanner(
        checkSyntax: { syntax, _ in
          scanned.insert(syntax.source())
          return true
        },
        checkExtendedSyntax: { syntax, _ in
          scanned.insert(syntax.text)
          if let codeDelimiter = syntax as? ExtendedTokenSyntax,
            codeDelimiter.kind == .codeDelimiter
          {
            foundCodeDelimiter = true
            XCTAssert(codeDelimiter.parent is SDGSwiftSource.CodeBlockSyntax)
          }
          return true
        },
        checkTrivia: { trivia, _ in
          scanned.insert(trivia.source())
          return true
        },
        checkTriviaPiece: { trivia, _ in
          scanned.insert(trivia.text)
          return true
        },
        shouldExtendToken: { _ in return true },
        shouldExtendFragment: { _ in return true }
      )
      try scanner.scan(syntax)
      XCTAssert(scanned.contains("print(\u{22}Hello, world!\u{22})"))
      XCTAssert(scanned.contains("```swift"))
      XCTAssert(scanned.contains(" "))
      XCTAssert(scanned.contains("/\u{2F}\u{2F} ```swift"))
      XCTAssert(foundCodeDelimiter)

      try FunctionalSyntaxScanner().scan(syntax)
    #endif
  }

  func testLineDeveloperCommentSyntax() throws {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
      let syntax = try SyntaxParser.parse(source: "/\u{2F} Comment.")
      struct Scanner: SyntaxScanner {}
      try Scanner().scan(syntax)
      XCTAssertNil(syntax.ancestors().makeIterator().next())

      class CommentScanner: SyntaxScanner {
        func visit(_ node: ExtendedSyntax, context: ExtendedSyntaxContext) -> Bool {
          if let comment = node as? LineDeveloperCommentSyntax {
            XCTAssertNotNil(comment.content)
          }
          return true
        }
      }
      try CommentScanner().scan(syntax)
    #endif
  }

  func testLineDocumentationCommentSyntax() throws {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
      let syntax = try SyntaxParser.parse(source: "//\u{2F} Documentation.")
      class DocumentationScanner: SyntaxScanner {
        func visit(_ node: ExtendedSyntax, context: ExtendedSyntaxContext) -> Bool {
          if let comment = node as? LineDocumentationSyntax {
            XCTAssertNotNil(comment.content)
          }
          return true
        }
      }
      try DocumentationScanner().scan(syntax)
    #endif
  }

  func testLocations() throws {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
      let source = "/\u{2F} ...\nlet x = 0 \n"
      let syntax = try SyntaxParser.parse(source: source)
      var statementsFound = false
      let scanner = FunctionalSyntaxScanner(checkSyntax: { syntax, context in
        if syntax.is(CodeBlockItemListSyntax.self) {
          statementsFound = true
          XCTAssertEqual(
            source.indices(of: syntax.triviaRange(in: context)),
            source.startIndex..<source.index(source.endIndex, offsetBy: −1)
          )
          XCTAssertEqual(
            source.indices(of: syntax.syntaxRange(in: context)),
            source.index(
              source.startIndex,
              offsetBy: 7
            )..<source.index(source.endIndex, offsetBy: −2)
          )
          return false
        }
        return true
      })
      try scanner.scan(syntax)
      XCTAssertTrue(statementsFound)
    #endif
  }

  func testParsing() throws {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
      for url in try FileManager.default.deepFileEnumeration(in: beforeDirectory)
      where url.lastPathComponent ≠ ".DS_Store" {
        let sourceFile = try SyntaxParser.parseAndRetry(url)

        let originalSource = try String(from: url)
        var roundTripSource = ""
        sourceFile.write(to: &roundTripSource)
        XCTAssertEqual(roundTripSource, originalSource)

        TextFreedomHighlighter.targetTestFreedom = .arbitrary
        try TextFreedomHighlighter().compare(
          syntax: sourceFile,
          parsedFrom: url,
          againstSpecification: "Arbitrary Text",
          overwriteSpecificationInsteadOfFailing: false
        )

        TextFreedomHighlighter.targetTestFreedom = .aliasable
        try TextFreedomHighlighter().compare(
          syntax: sourceFile,
          parsedFrom: url,
          againstSpecification: "Aliasable Text",
          overwriteSpecificationInsteadOfFailing: false
        )

        TextFreedomHighlighter.targetTestFreedom = .invariable
        try TextFreedomHighlighter().compare(
          syntax: sourceFile,
          parsedFrom: url,
          againstSpecification: "Invariable Text",
          overwriteSpecificationInsteadOfFailing: false
        )

        let highlighted = sourceFile.syntaxHighlightedHTML(
          inline: false,
          internalIdentifiers: [],
          symbolLinks: ["doSomething": "domain.tld"]
        )
        SDGPersistenceTestUtilities.compare(
          HTMLPage(
            content: highlighted,
            cssPath: "../../../../../Resources/SDGSwiftSource/Syntax%20Highlighting.css"
          ),
          against: sourceDirectory.appendingPathComponent("After").appendingPathComponent(
            "Syntax Highlighting"
          ).appendingPathComponent(url.deletingPathExtension().lastPathComponent)
            .appendingPathExtension("html"),
          overwriteSpecificationInsteadOfFailing: false
        )
      }
    #endif
  }

  func testSymbolGraphExport() throws {
    for packageURL in documentationTestPackages {
      let package = PackageRepository(at: packageURL)
      #if PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
        #if !PLATFORM_LACKS_FOUNDATION_PROCESS
          _ = try? package.exportSymbolGraph().get()
        #endif
      #else
        let directory = try package.exportSymbolGraph().get()
        defer { try? FileManager.default.removeItem(at: directory) }
        XCTAssert(
          try FileManager.default.contents(ofDirectory: directory)
            .contains(where: { $0.lastPathComponent.hasSuffix(".symbols.json") })
        )
      #endif
    }
  }

  func testTokenSyntax() {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
      let missing = SyntaxFactory.makeToken(.infixQuestionMark, presence: .missing)
      let declaration = SyntaxFactory.makeInitializerDecl(
        attributes: nil,
        modifiers: SyntaxFactory.makeModifierList([
          SyntaxFactory.makeDeclModifier(
            name: SyntaxFactory.makePublicKeyword(),
            detailLeftParen: nil,
            detail: nil,
            detailRightParen: nil
          )
        ]),
        initKeyword: SyntaxFactory.makeInitKeyword(),
        optionalMark: missing,
        genericParameterClause: nil,
        parameters: SyntaxFactory.makeParameterClause(
          leftParen: SyntaxFactory.makeLeftParenToken(),
          parameterList: SyntaxFactory.makeFunctionParameterList([]),
          rightParen: SyntaxFactory.makeRightParenToken()
        ),
        throwsOrRethrowsKeyword: nil,
        genericWhereClause: nil,
        body: SyntaxFactory.makeCodeBlock(
          leftBrace: SyntaxFactory.makeLeftBraceToken(),
          statements: SyntaxFactory.makeCodeBlockItemList([]),
          rightBrace: SyntaxFactory.makeRightBraceToken()
        )
      )
    #endif
  }

  func testTree() throws {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
      let source = "/\u{2F} ...\nlet x = 0 \n"
      let syntax = try SyntaxParser.parse(source: source)
      XCTAssertNil(syntax.ancestors().first(where: { _ in true }))
      XCTAssertNil(SyntaxFactory.makeToken(.identifier("a")).previousToken())
      XCTAssertNil(SyntaxFactory.makeToken(.identifier("a")).nextToken())
      XCTAssertNil(syntax.firstToken()!.previousToken())
      XCTAssertNil(syntax.lastToken()!.nextToken())
      XCTAssertEqual(syntax.firstToken()!.tokenKind, .letKeyword)
      XCTAssertEqual(syntax.lastToken()!.tokenKind, .eof)
      let `let` = syntax.firstToken()!
      XCTAssertEqual(`let`.firstPrecedingTrivia()?.text, TriviaPiece.newlines(1).text)
      XCTAssertEqual(`let`.firstFollowingTrivia()?.text, TriviaPiece.spaces(1).text)
      let x = `let`.nextToken()
      XCTAssertEqual(x?.firstPrecedingTrivia()?.text, TriviaPiece.spaces(1).text)
      XCTAssertEqual(x?.firstFollowingTrivia()?.text, TriviaPiece.spaces(1).text)
      let eof = syntax.lastToken()!
      XCTAssertEqual(eof.firstPrecedingTrivia()?.text, TriviaPiece.newlines(1).text)
      XCTAssertNil(eof.firstFollowingTrivia()?.text)

      let incomplete = SyntaxFactory.makeFunctionDecl(
        attributes: nil,
        modifiers: nil,
        funcKeyword: SyntaxFactory.makeToken(.funcKeyword, presence: .missing),
        identifier: SyntaxFactory.makeToken(.identifier("identifier")),
        genericParameterClause: nil,
        signature: SyntaxFactory.makeFunctionSignature(
          input: SyntaxFactory.makeParameterClause(
            leftParen: SyntaxFactory.makeToken(.leftParen, presence: .missing),
            parameterList: SyntaxFactory.makeFunctionParameterList([]),
            rightParen: SyntaxFactory.makeToken(.rightParen)
          ),
          asyncOrReasyncKeyword: nil,
          throwsOrRethrowsKeyword: SyntaxFactory.makeToken(.throwsKeyword, presence: .missing),
          output: nil
        ),
        genericWhereClause: nil,
        body: nil
      )
      XCTAssertEqual(incomplete.firstToken()?.tokenKind, .identifier("identifier"))
      XCTAssertEqual(incomplete.lastToken()?.tokenKind, .rightParen)
      XCTAssertEqual(incomplete.identifier.nextToken()?.tokenKind, .rightParen)
      XCTAssertEqual(
        incomplete.signature.input.rightParen.previousToken()?.tokenKind,
        .identifier("identifier")
      )

      let stringSource = "@available(*, unavailable, renamed: \u{22}new\u{22}) func function() {}"
      let stringSyntax = try SyntaxParser.parse(source: stringSource)
      var foundQuotationMark = false
      var foundLiteral = false
      var foundString = false
      try FunctionalSyntaxScanner(
        checkExtendedSyntax: { syntax, _ in
          if let token = syntax as? ExtendedTokenSyntax,
            token.kind == .quotationMark
          {
            foundQuotationMark = true
            XCTAssert(token.ancestors().contains(where: { $0.text == "\u{22}new\u{22}" }))
            for _ in token.ancestors() {}
          } else if let literal = syntax as? StringLiteralSyntax {
            foundLiteral = true
            XCTAssertNil(literal.ancestors().makeIterator().next())
            XCTAssertEqual(literal.firstToken()?.text, "\u{22}")
            XCTAssertEqual(literal.lastToken()?.text, "\u{22}")
          } else if let token = syntax as? ExtendedTokenSyntax,
            token.kind == .string
          {
            foundString = true
            XCTAssertEqual(token.nextToken()?.text, "\u{22}")
            XCTAssertEqual(token.previousToken()?.text, "\u{22}")
            XCTAssertNil(token.nextToken()?.nextToken()?.text)
            XCTAssertNil(token.previousToken()?.previousToken()?.text)
          }
          return true
        }).scan(stringSyntax)
      XCTAssert(foundQuotationMark)
      XCTAssert(foundLiteral)
      XCTAssert(foundString)
    #endif
  }

  func testTriviaPiece() {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
      XCTAssertTrue(TriviaPiece.newlines(1).isNewline)
      XCTAssertFalse(TriviaPiece.spaces(1).isNewline)
    #endif
  }
}
