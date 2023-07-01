/*
 InternalTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwiftSource
@testable import SDGSwiftDocumentation

  import SwiftSyntax

import XCTest

import SDGSwiftTestUtilities

class InternalTests: SDGSwiftTestUtilities.TestCase {

  func testSourceLocation() {
      let location = SourceLocation(offset: 0, converter: nil)
      XCTAssertNil(location.symbolKitPosition)
    _ = SourceLocation.convertLine(fromSymbolGraph: 10)
    _ = SourceLocation.convertColumn(fromSymbolGraphCharacter: 10)
  }

  func testSyntaxProtocol() {
    // #workaround(Swift 5.8.0, Web compiler bug leads to out of bounds memory access.)
    #if !os(WASI)
      let nestedFunction = FunctionDeclSyntax(
        attributes: nil,
        modifiers: nil,
        funcKeyword: TokenSyntax(.funcKeyword, trailingTrivia: .spaces(1), presence: .present),
        identifier: TokenSyntax(.identifier("outer"), presence: .present),
        genericParameterClause: nil,
        signature: FunctionSignatureSyntax(
          input: ParameterClauseSyntax(
            leftParen: TokenSyntax(.leftParen, presence: .present),
            parameterList: FunctionParameterListSyntax([]),
            rightParen: TokenSyntax(.rightParen, presence: .present)
          ),
          asyncOrReasyncKeyword: nil,
          throwsOrRethrowsKeyword: nil,
          output: nil
        ),
        genericWhereClause: nil,
        body: CodeBlockSyntax(
          leftBrace: TokenSyntax(
            .leftBrace,
            leadingTrivia: .spaces(1),
            trailingTrivia: .newlines(1),
            presence: .present
          ),
          statements: CodeBlockItemListSyntax([
            CodeBlockItemSyntax(
              item: CodeBlockItemSyntax.Item(
                FunctionDeclSyntax(
                  attributes: nil,
                  modifiers: nil,
                  funcKeyword: TokenSyntax(.funcKeyword, trailingTrivia: .spaces(1), presence: .present),
                  identifier: TokenSyntax(.identifier("inner"), presence: .present),
                  genericParameterClause: nil,
                  signature: FunctionSignatureSyntax(
                    input: ParameterClauseSyntax(
                      leftParen: TokenSyntax(.leftParen, presence: .present),
                      parameterList: FunctionParameterListSyntax([]),
                      rightParen: TokenSyntax(.rightParen, presence: .present)
                    ),
                    asyncOrReasyncKeyword: nil,
                    throwsOrRethrowsKeyword: nil,
                    output: nil
                  ),
                  genericWhereClause: nil,
                  body: CodeBlockSyntax(
                    leftBrace: TokenSyntax(
                      .leftBrace,
                      leadingTrivia: .spaces(1),
                      trailingTrivia: .newlines(1),
                      presence: .present
                    ),
                    statements: CodeBlockItemListSyntax([]),
                    rightBrace: TokenSyntax(.rightBrace, leadingTrivia: .newlines(1), presence: .present)
                  )
                )
              ),
              semicolon: nil,
              errorTokens: nil
            )
          ]),
          rightBrace: TokenSyntax(.rightBrace, leadingTrivia: .newlines(1), presence: .present)
        )
      )
      let found = nestedFunction.smallest(
        FunctionDeclSyntax.self,
        at: AbsolutePosition(utf8Offset: 15)
      )
      XCTAssertEqual(found?.identifier.text, "inner")

      let documented = StructDeclSyntax(
        attributes: nil,
        modifiers: nil,
        structKeyword: TokenSyntax(
          .structKeyword,
          leadingTrivia: Trivia(pieces: [
            .spaces(2),
            .docBlockComment(
              "/**\r\n   Additional documentation comment framed by Windows line breaks.\r\n   */"
            ),
            .newlines(1),
            .spaces(2),
            .lineComment("// Developer comment."),
            .newlines(1),
            .spaces(2),
            .docLineComment("/// Documentation"),
            .carriageReturnLineFeeds(1),
            .spaces(2),
            .docLineComment("/// which continues after a Windows line break."),
            .newlines(1),
            .spaces(2),
          ]),
          trailingTrivia: .spaces(1),
          presence: .present
        ),
        identifier: TokenSyntax(.identifier("Structure"), presence: .present),
        genericParameterClause: nil,
        inheritanceClause: nil,
        genericWhereClause: nil,
        members: MemberDeclBlockSyntax(
          leftBrace: TokenSyntax(
            .leftBrace,
            leadingTrivia: .spaces(1),
            trailingTrivia: .spaces(1),
            presence: .present
          ),
          members: MemberDeclListSyntax([]),
          rightBrace: TokenSyntax(
            .leftBrace,
            leadingTrivia: .spaces(1),
            presence: .present
          )
        )
      )
      let documentation = documented.documentation(
        url: "somewhere.swift",
        source: SourceFileSyntax(
          statements: CodeBlockItemListSyntax([
            CodeBlockItemSyntax(
              item: CodeBlockItemSyntax.Item(documented),
              semicolon: nil,
              errorTokens: nil
            )
          ]),
          eofToken: TokenSyntax(.eof, presence: .present)
        ),
        module: nil
      )
      XCTAssertEqual(
        documentation.last?.developerComments.lines.map({ $0.text }).joined(separator: "\n"),
        "Developer comment."
      )
      XCTAssertEqual(
        documentation.last?.documentationComment.lines.map({ $0.text }).joined(separator: "\n"),
        "Documentation\nwhich continues after a Windows line break."
      )
      XCTAssertEqual(
        documentation.first?.documentationComment.lines.map({ $0.text }).joined(separator: "\n"),
        "Additional documentation comment framed by Windows line breaks."
      )
    #endif
  }
}
