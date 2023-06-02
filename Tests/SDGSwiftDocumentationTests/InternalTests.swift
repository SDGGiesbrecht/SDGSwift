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
  }

  func testSyntaxProtocol() {
    // #workaround(Swift 5.8.0, Web compiler bug leads to out of bounds memory access.)
    #if !os(WASI)
      let nestedFunction = FunctionDeclSyntax(
        attributes: nil,
        modifiers: nil,
        funcKeyword: TokenSyntax(.funcKeyword, trailingTrivia: .spaces(1)),
        identifier: TokenSyntax(.identifier("outer")),
        genericParameterClause: nil,
        signature: FunctionSignatureSyntax(
          input: ParameterClauseSyntax(
            leftParen: TokenSyntax(.leftParen),
            parameterList: FunctionParameterListSyntax([]),
            rightParen: TokenSyntax(.rightParen)
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
            trailingTrivia: .newlines(1)
          ),
          statements: CodeBlockItemListSyntax([
            CodeBlockItemSyntax(
              item: CodeBlockItemSyntax.Item(
                FunctionDeclSyntax(
                  attributes: nil,
                  modifiers: nil,
                  funcKeyword: TokenSyntax(.funcKeyword, trailingTrivia: .spaces(1)),
                  identifier: TokenSyntax(.identifier("inner")),
                  genericParameterClause: nil,
                  signature: FunctionSignatureSyntax(
                    input: ParameterClauseSyntax(
                      leftParen: TokenSyntax(.leftParen),
                      parameterList: FunctionParameterListSyntax([]),
                      rightParen: TokenSyntax(.rightParen)
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
                      trailingTrivia: .newlines(1)
                    ),
                    statements: CodeBlockItemListSyntax([]),
                    rightBrace: TokenSyntax(.rightBrace, leadingTrivia: .newlines(1))
                  )
                )
              ),
              semicolon: nil,
              errorTokens: nil
            )
          ]),
          rightBrace: TokenSyntax(.rightBrace, leadingTrivia: .newlines(1))
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
            .docBlockComment(
              "/**\r\n Additional documentation comment framed by Windows line breaks.\r\n */"
            ),
            .newlines(1),
            .lineComment("// Developer comment."),
            .newlines(1),
            .docLineComment("/// Documentation"),
            .carriageReturnLineFeeds(1),
            .docLineComment("/// which continues after a Windows line break."),
          ]),
          trailingTrivia: .spaces(1)
        ),
        identifier: TokenSyntax(.identifier("Structure")),
        genericParameterClause: nil,
        inheritanceClause: nil,
        genericWhereClause: nil,
        members: MemberDeclBlockSyntax(
          leftBrace: TokenSyntax(
            .leftBrace,
            leadingTrivia: .spaces(1),
            trailingTrivia: .spaces(1)
          ),
          members: MemberDeclListSyntax([]),
          rightBrace: TokenSyntax(
            .leftBrace,
            leadingTrivia: .spaces(1)
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
          eofToken: TokenSyntax(.eof)
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
