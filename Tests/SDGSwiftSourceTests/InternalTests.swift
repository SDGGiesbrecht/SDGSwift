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

#if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
  import SwiftSyntax
#endif

@testable import SDGSwiftSource

import SDGSwiftLocalizations

import XCTest

import SDGXCTestUtilities

import SDGSwiftTestUtilities

// #workaround(workspace version 0.30.1, Test case names only need to disambiguate for WindowsMain.swift.)
class SDGSwiftSourceInternalTests: SDGSwiftTestUtilities.TestCase {

  func testEmptySyntax() {
    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
      XCTAssert(SyntaxFactory.makeBlankUnknownExpr().documentation.isEmpty)
    #endif
  }

  func testExtendedSyntaxContext() {
    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
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
    #if !os(Android)  // #workaround(Swift 5.1.3, Illegal instruction)
      for localization in InterfaceLocalization.allCases {
        LocalizationSetting(orderOfPrecedence: [localization.code]).do {
          // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
          #if !(os(Windows) || os(Android))
            _ = LibraryAPI.reportForParsing(module: "[...]").resolved()
            _ = PackageAPI.reportForLoadingInheritance(from: "[...]").resolved()
          #endif
        }
      }
    #endif
  }

  func testStringLiteral() {
    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
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
    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
      let tokens: [TokenKind] = [
        .stringSegment("\u{C0}"),
        .dollarIdentifier("$0"),
        .unspacedBinaryOperator("=="),
        .prefixOperator("!"),
        .postfixOperator("..."),
        .integerLiteral("0"),
        .floatingLiteral("0"),
        .contextualKeyword("mutating"),
        .unknown("...")
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
