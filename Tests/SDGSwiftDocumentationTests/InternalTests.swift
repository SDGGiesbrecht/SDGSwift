/*
 InternalTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwiftSource
@testable import SDGSwiftDocumentation

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax
#endif

import XCTest

import SDGSwiftTestUtilities

class InternalTests: SDGSwiftTestUtilities.TestCase {

  func testSourceLocation() {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
      let location = SourceLocation(offset: 0, converter: nil)
      XCTAssertNil(location.symbolKitPosition)
    #endif
  }

  func testSyntaxProtocol() {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
      let nestedFunction = SyntaxFactory.makeFunctionDecl(
        attributes: nil,
        modifiers: nil,
        funcKeyword: SyntaxFactory.makeToken(.funcKeyword, trailingTrivia: .spaces(1)),
        identifier: SyntaxFactory.makeToken(.identifier("outer")),
        genericParameterClause: nil,
        signature: SyntaxFactory.makeFunctionSignature(
          input: SyntaxFactory.makeParameterClause(
            leftParen: SyntaxFactory.makeToken(.leftParen),
            parameterList: SyntaxFactory.makeFunctionParameterList([]),
            rightParen: SyntaxFactory.makeToken(.rightParen)
          ),
          asyncOrReasyncKeyword: nil,
          throwsOrRethrowsKeyword: nil,
          output: nil
        ),
        genericWhereClause: nil,
        body: SyntaxFactory.makeCodeBlock(
          leftBrace: SyntaxFactory.makeToken(
            .leftBrace,
            leadingTrivia: .spaces(1),
            trailingTrivia: .newlines(1)
          ),
          statements: SyntaxFactory.makeCodeBlockItemList([
            SyntaxFactory.makeCodeBlockItem(
              item: Syntax(
                SyntaxFactory.makeFunctionDecl(
                  attributes: nil,
                  modifiers: nil,
                  funcKeyword: SyntaxFactory.makeToken(.funcKeyword, trailingTrivia: .spaces(1)),
                  identifier: SyntaxFactory.makeToken(.identifier("inner")),
                  genericParameterClause: nil,
                  signature: SyntaxFactory.makeFunctionSignature(
                    input: SyntaxFactory.makeParameterClause(
                      leftParen: SyntaxFactory.makeToken(.leftParen),
                      parameterList: SyntaxFactory.makeFunctionParameterList([]),
                      rightParen: SyntaxFactory.makeToken(.rightParen)
                    ),
                    asyncOrReasyncKeyword: nil,
                    throwsOrRethrowsKeyword: nil,
                    output: nil
                  ),
                  genericWhereClause: nil,
                  body: SyntaxFactory.makeCodeBlock(
                    leftBrace: SyntaxFactory.makeToken(
                      .leftBrace,
                      leadingTrivia: .spaces(1),
                      trailingTrivia: .newlines(1)
                    ),
                    statements: SyntaxFactory.makeCodeBlockItemList([]),
                    rightBrace: SyntaxFactory.makeToken(.rightBrace, leadingTrivia: .newlines(1))
                  )
                )
              ),
              semicolon: nil,
              errorTokens: nil
            )
          ]),
          rightBrace: SyntaxFactory.makeToken(.rightBrace, leadingTrivia: .newlines(1))
        )
      )
      let found = nestedFunction.smallest(FunctionDeclSyntax.self, at: AbsolutePosition(utf8Offset: 15))
      XCTAssertEqual(found?.identifier.text, "inner")
    #endif
  }
}
