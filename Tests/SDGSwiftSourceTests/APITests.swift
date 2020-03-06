/*
 APITests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics
import SDGCollections

#if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
  import SwiftSyntax
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

// #workaround(workspace version 0.30.1, Test case names only need to disambiguate for WindowsMain.swift.)
class SDGSwiftSourceAPITests: SDGSwiftTestUtilities.TestCase {

  func testAPIParsing() throws {
    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
      for packageName in ["PackageToDocument", "PackageToDocument2"] {
        let package = PackageRepository(at: mocksDirectory.appendingPathComponent(packageName))
        let parsed = try PackageAPI(
          package: package.packageGraph().get(),
          reportProgress: { print($0) }
        )
        XCTAssertNotNil(parsed.documentation.last)
        XCTAssertNotNil(parsed.libraries.first?.documentation.last)
        XCTAssertNotNil(parsed.modules.first?.documentation.last)
        let summary = parsed.summary().joined(separator: "\n")
        let specification = testSpecificationDirectory().appendingPathComponent(
          "API/\(parsed.name).txt"
        )
        SDGPersistenceTestUtilities.compare(
          summary,
          against: specification,
          overwriteSpecificationInsteadOfFailing: false
        )

        if packageName == "PackageToDocument" {
          XCTAssert("Structure" ∈ parsed.identifierList())
        }

        let rootElement = APIElement.package(parsed)
        for element in rootElement.flattenedTree() {
          element.userInformation = true
        }
        for element in rootElement.flattenedTree() {
          XCTAssertEqual(element.userInformation as? Bool, true)
          _ = element.libraries
          _ = element.modules
          _ = element.types
          _ = element.extensions
          _ = element.protocols
          _ = element.cases
          _ = element.typeProperties
          _ = element.typeMethods
          _ = element.initializers
          _ = element.instanceProperties
          _ = element.subscripts
          _ = element.instanceMethods
          _ = element.operators
          _ = element.precedenceGroups
          _ = element.conformances
          _ = element.overloads
          _ = element.isProtocolRequirement
          _ = element.hasDefaultImplementation
        }
        XCTAssertFalse(rootElement < rootElement)
        XCTAssertTrue(parsed == parsed)
      }
    #endif
  }

  func testCallout() {
    #if !os(Android)  // #workaround(Swift 5.1.3, Illegal instruction)
      for localization in InterfaceLocalization.allCases {
        #if !os(Android)  // #workaround(workspace version 0.30.1, Emulator lacks permissions.)
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
        #endif
      }
    #endif
  }

  func testCodeFragmentSyntax() throws {
    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
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
          if let token = syntax as? TokenSyntax {
            if token.tokenKind == .colon {
              foundColon = true
              XCTAssertEqual(source[token.syntaxRange(in: context)], ":")
            } else if token.tokenKind == .funcKeyword {
              foundFunction = true
              XCTAssertEqual(source[token.syntaxRange(in: context)], "func")
            }
          }
          return true
        },
        checkExtendedSyntax: { syntax, context in
          if let token = syntax as? ExtendedTokenSyntax,
            token.kind == .codeDelimiter
          {
            foundCodeDelimiters = true
            XCTAssertEqual(source[token.range(in: context)], "`")
          } else if syntax is InlineCodeSyntax {
            foundCode = true
            XCTAssertEqual(source[syntax.range(in: context)], "`selector(style:notation:)`")
          }
          return true
        },
        checkTrivia: { trivia, context in
          if trivia.source() == " " {
            foundSpaces = true
            XCTAssertEqual(source[trivia.range(in: context)], " ")
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
            XCTAssertEqual(source[trivia.range(in: context)], "\n")
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
            XCTAssertEqual(moreSource[token.range(in: context)], "\u{22}")
          } else if let token = syntax as? ExtendedTokenSyntax,
            token.kind == .commentText
          {
            foundComment = true
            XCTAssertEqual(moreSource[token.range(in: context)], "Comment.")
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
            XCTAssertEqual(evenMoreSource[syntax.range(in: context)], "// Comment.")
          }
          return true
        },
        checkTriviaPiece: { trivia, context in
          if case .lineComment = trivia,
            ¬trivia.text.isEmpty
          {
            foundTriviaFragment = true
            XCTAssertEqual(evenMoreSource[trivia.range(in: context)], "// Comment.")
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
          if let token = syntax as? TokenSyntax {
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
    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
      let syntax = try SyntaxParser.parse(
        URL(fileURLWithPath: #file).deletingLastPathComponent().deletingLastPathComponent()
          .deletingLastPathComponent().appendingPathComponent(
            "Resources/SDGSwiftSource/Core Libraries/Swift.txt"
          )
      )
      var foundLessThan = false
      var foundEncodable = false
      try FunctionalSyntaxScanner(
        checkSyntax: { syntax, _ in
          if let function = syntax as? FunctionDeclSyntax {
            XCTAssert(function.identifier.text ≠ "", "Corrupt function:\n\(function)")
            if function.identifier.text == "<" {
              foundLessThan = true
            }
          } else if let `protocol` = syntax as? ProtocolDeclSyntax {
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
    #if !os(Android)  // #workaround(Swift 5.1.3, Illegal instruction)
      XCTAssert(¬SyntaxHighlighter.css.contains("Apache"))
      #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
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
    #endif
  }

  func testExtension() {
    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
      XCTAssert(ExtensionAPI(type: "String").extendsSameType(as: ExtensionAPI(type: "String")))
      XCTAssertFalse(ExtensionAPI(type: "String").extendsSameType(as: ExtensionAPI(type: "Int")))
    #endif
  }

  func testFunctionalSyntaxScanner() throws {
    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
      let source = [
        "/// ```swift",
        "/// print(\u{22}Hello, world!\u{22})",
        "/// ```",
        "func helloWorld() {",
        "    print(\u{22}Hello, world!\u{22})",
        "}"
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
    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
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
    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
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
    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
      let source = "/\u{2F} ...\nlet x = 0 \n"
      let syntax = try SyntaxParser.parse(source: source)
      var statementsFound = false
      let scanner = FunctionalSyntaxScanner(checkSyntax: { syntax, context in
        if syntax is CodeBlockItemListSyntax {
          statementsFound = true
          XCTAssertEqual(
            syntax.triviaRange(in: context),
            source.startIndex..<source.index(source.endIndex, offsetBy: −1)
          )
          XCTAssertEqual(
            syntax.syntaxRange(in: context),
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

  func testPackageDocumentation() throws {
    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
      let package = try thisRepository.package().get()
      XCTAssertNotNil(try PackageAPI.documentation(for: package))
    #endif
  }

  func testParsing() throws {
    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
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

        // API
        let api = sourceFile.api().sorted()
        let summary = api.map({ $0.summary().joined(separator: "\n") }).joined(separator: "\n")
        SDGPersistenceTestUtilities.compare(
          summary,
          against: sourceDirectory.appendingPathComponent("After").appendingPathComponent("API")
            .appendingPathComponent(url.deletingPathExtension().lastPathComponent)
            .appendingPathExtension("txt"),
          overwriteSpecificationInsteadOfFailing: false
        )

        let identifiers = api.reduce(into: Set<String>()) { $0 ∪= $1.identifierList() }
        let syntaxHighlighting = api.map({ $0.flattenedTree() }).joined().map({ element in
          if var declaration = element.declaration?.syntaxHighlightedHTML(
            inline: false,
            internalIdentifiers: identifiers
          ) {

            if let constraints = element.constraints?.syntaxHighlightedHTML(
              inline: false,
              internalIdentifiers: identifiers
            ) {
              declaration += "\n" + constraints
            }

            if let conditions = element.compilationConditions?.syntaxHighlightedHTML(
              inline: false,
              internalIdentifiers: identifiers
            ) {
              declaration = conditions + "\n" + declaration
            }

            return declaration
          } else {
            return nil
          }
        }).compactMap({ $0 }).joined(separator: "\n\n")
        SDGPersistenceTestUtilities.compare(
          HTMLPage(
            content: syntaxHighlighting,
            cssPath: "../../../../../Resources/SDGSwiftSource/Syntax%20Highlighting.css"
          ),
          against: sourceDirectory.appendingPathComponent("After").appendingPathComponent(
            "API Syntax Highlighting"
          ).appendingPathComponent(url.deletingPathExtension().lastPathComponent)
            .appendingPathExtension("html"),
          overwriteSpecificationInsteadOfFailing: false
        )

        if url.deletingPathExtension().lastPathComponent == "Documentation" {
          var found = false
          search: for element in api {
            `switch`:switch element {
            case .extension(let `extension`):
              found = true
              let method = `extension`.instanceMethods.first(where: {
                $0.name.source().hasPrefix("performAction")
              })!
              let methods = [
                method,
                `extension`.instanceMethods.first(where: {
                  $0.name.source().hasPrefix("withSeparateParameters")
                })!
              ]
              _ = method.documentation.last!.documentationComment.renderedHTML(localization: "zxx")

              for localization in InterfaceLocalization.allCases {
                let rendered = methods.map({
                  $0.documentation.last!.documentationComment.renderedSpecification(
                    localization: localization.code
                  )
                }).joined(separator: "\n")

                let specification = testSpecificationDirectory().appendingPathComponent(
                  "Source/After/Rendered Documentation/\(localization.icon!).html"
                )
                SDGPersistenceTestUtilities.compare(
                  HTMLPage(
                    content: rendered,
                    cssPath: "../../../../Resources/SDGSwiftSource/Syntax%20Highlighting.css"
                  ),
                  against: specification,
                  overwriteSpecificationInsteadOfFailing: false
                )
              }

              let blockDocumentation = `extension`.instanceMethods.first(where: {
                $0.name.source().hasPrefix("documentedWithBlockStyle")
              })!
              XCTAssertNotNil(blockDocumentation.documentation)

              break search
            default:
              break `switch`
            }
          }
          XCTAssert(found, "Failed to find test documentation.")
        }
        if url.deletingPathExtension().lastPathComponent == "Attributes" {
          var found = false
          search: for element in api {
            `switch`:switch element {
            case .function(let function):
              if function.name.identifier.text == "withHiddenAttribute" {
                XCTAssertNotNil(element.documentation)
                found = true
                break search
              }
            default:
              break `switch`
            }
          }
          XCTAssert(found, "Failed to find hidden attribute test.")
        }
      }
    #endif
  }

  func testTokenSyntax() {
    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
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
      XCTAssertEqual(declaration.api().first!.declaration!.source(), "init()")
    #endif
  }

  func testTree() throws {
    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
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
    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
      XCTAssertTrue(TriviaPiece.newlines(1).isNewline)
      XCTAssertFalse(TriviaPiece.spaces(1).isNewline)
    #endif
  }
}
