/*
 InternalTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

// #workaround(workspace version 0.32.0, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(Android))
  import SwiftSyntax
#endif

@testable import SDGSwiftSource

import SDGSwiftLocalizations

import XCTest

import SDGXCTestUtilities

import SDGSwiftTestUtilities

class InternalTests: SDGSwiftTestUtilities.TestCase {

  func testEmptySyntax() {
    // #workaround(workspace version 0.32.0, SwiftSyntax won’t compile.)
    #if !(os(Windows) || os(Android))
      XCTAssert(SyntaxFactory.makeBlankUnknownExpr().documentation.isEmpty)
    #endif
  }

  func testExtendedSyntaxContext() {
    // #workaround(workspace version 0.32.0, SwiftSyntax won’t compile.)
    #if !(os(Windows) || os(Android))
      let context = ExtendedSyntaxContext._token(
        SyntaxFactory.makeToken(.comma),
        context: SyntaxContext(fragmentContext: "", fragmentOffset: 0, parentContext: nil)
      )
      _ = context.source
      let source = ""
      _ =
        ExtendedSyntaxContext._fragment(
          CodeFragmentSyntax(range: source.bounds, in: source, isSwift: false),
          context: context,
          offset: 0
        ).source
    #endif
  }

  func testLocalizations() {
    for localization in InterfaceLocalization.allCases {
      LocalizationSetting(orderOfPrecedence: [localization.code]).do {
        // #workaround(workspace version 0.32.0, SwiftSyntax won’t compile.)
        #if !(os(Windows) || os(Android))
          _ = LibraryAPI.reportForParsing(module: "[...]").resolved()
          _ = PackageAPI.reportForLoadingInheritance(from: "[...]").resolved()
        #endif
      }
    }
  }

  func testStringLiteral() {
    // #workaround(workspace version 0.32.0, SwiftSyntax won’t compile.)
    #if !(os(Windows) || os(Android))
      let literal = "\u{22}...\u{22}"
      let kind = TokenKind.stringLiteral(literal).normalized()
      if case .stringLiteral(let normalized) = kind {
        XCTAssertEqual(normalized, literal)
      } else {
        XCTFail("String literal not found.")
      }
    #endif
  }

  func testTokenNormalization() {
    // #workaround(workspace version 0.32.0, SwiftSyntax won’t compile.)
    #if !(os(Windows) || os(Android))
      let tokens: [TokenKind] = [
        .stringSegment("\u{C0}"),
        .dollarIdentifier("$0"),
        .unspacedBinaryOperator("=="),
        .prefixOperator("!"),
        .postfixOperator("..."),
        .integerLiteral("0"),
        .floatingLiteral("0"),
        .contextualKeyword("mutating"),
        .unknown("..."),
      ]
      for kind in tokens {
        let token = SyntaxFactory.makeToken(kind)
        XCTAssert(
          token.generallyNormalizedAndMissingInsteadOfNil().text.scalars.elementsEqual(
            token.text.decomposedStringWithCanonicalMapping.scalars
          ),
          "Token kind not normalized."
        )
      }
    #endif
  }
}
