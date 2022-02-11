/*
 StringLiteralSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

/// A string literal.
public final class StringLiteralSyntax: ExtendedSyntax {

  // MARK: - Class Properties

  private static
    var quotationMark: ExtendedTokenSyntax
  {  // @exempt(from: tests)  Unreachable from tvOS.
    return ExtendedTokenSyntax(text: "\u{22}", kind: .quotationMark)
  }

  // MARK: - Initialization

  internal init(source: String) {  // @exempt(from: tests)  Unreachable from tvOS.
    let openingQuotationMark = StringLiteralSyntax.quotationMark
    let closingQuotationMark = StringLiteralSyntax.quotationMark

    var string = source
    string.removeFirst(openingQuotationMark.text.count)
    self.openingQuotationMark = openingQuotationMark
    let opening: [ExtendedTokenSyntax] = [openingQuotationMark]

    string.removeLast(closingQuotationMark.text.count)
    self.closingQuotationMark = closingQuotationMark
    let closing: [ExtendedTokenSyntax] = [closingQuotationMark]

    let content = ExtendedTokenSyntax(text: string, kind: .string)
    self.string = content
    super.init(children: opening + [content] + closing)
  }

  // MARK: - Properties

  /// The opening quotation mark.
  public let openingQuotationMark: ExtendedTokenSyntax

  /// The content.
  public let string: ExtendedTokenSyntax

  /// The closing quotation mark.
  public let closingQuotationMark: ExtendedTokenSyntax

  // MARK: - ExtendedSyntax

  internal override func nestedSyntaxHighlightedHTML(
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String]
  ) -> String {  // @exempt(from: tests)  Unreachable from tvOS.
    var source = super.nestedSyntaxHighlightedHTML(
      internalIdentifiers: internalIdentifiers,
      symbolLinks: symbolLinks
    )
    source.prepend(contentsOf: "<span class=\u{22}string\u{22}>")
    source.append(contentsOf: "</span>")
    return source
  }
}
