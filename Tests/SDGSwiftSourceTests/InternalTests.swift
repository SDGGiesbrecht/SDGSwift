/*
 InternalTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

  import SwiftSyntax

@testable import SDGSwiftSource

import SDGSwiftLocalizations

import XCTest

import SDGXCTestUtilities

import SDGSwiftTestUtilities

class InternalTests: SDGSwiftTestUtilities.TestCase {

  func testBlockDocumentationSyntax() {
      let documentationComment = BlockDocumentationSyntax(source: "/** ... */")
      let documentation = documentationComment.documentation
      XCTAssertEqual(documentation.text, "...")
  }

  func testCodeBlockSyntax() {
      let documentationComment = BlockDocumentationSyntax(
        source: [
          "/**",
          " Some documentation.",
          "",
          " ```swift",
          " let code = this",
          " ```",
          " */",
        ].joined(separator: "\n")
      )
      let documentation = documentationComment.documentation
      for child in documentation.children {
        if let code = child as? SDGSwiftSource.CodeBlockSyntax {
          _ = code.syntaxHighlightedHTML(inline: false)
        }
      }
  }

  func testExtendedSyntaxContext() {
      let contextSource = ""
      let context = ExtendedSyntaxContext._token(
        TokenSyntax(.comma),
        context: SyntaxContext(
          fragmentContext: contextSource,
          fragmentOffset: contextSource.offset(of: contextSource.scalars.startIndex),
          parentContext: nil
        )
      )
      let source = ""
      _ =
        ExtendedSyntaxContext._fragment(
          CodeFragmentSyntax(
            range: source.offsets(of: source.bounds),
            in: source,
            isSwift: false
          ),
          context: context,
          offset: 0
        )
  }
}
