/*
 StringLiteralSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A string literal.
public struct StringLiteralSyntax: ExtendedSyntax {

  // MARK: - Static Properties

  private static var quotationMark: ExtendedTokenSyntax {
    return ExtendedTokenSyntax(kind: .quotationMark)
  }

  // MARK: - Initialization

  internal init(source: String) {
    let quotationMark = StringLiteralSyntax.quotationMark
    let quotationMarkLength = quotationMark.text.unicodeScalars.count

    self.openingQuotationMark = quotationMark

    var string = source
    string.unicodeScalars.removeFirst(quotationMarkLength)
    string.unicodeScalars.removeLast(quotationMarkLength)
    self.string = ExtendedTokenSyntax(kind: .string(string))

    self.closingQuotationMark = quotationMark
  }

  // MARK: - Properties

  /// The opening quotation mark.
  public let openingQuotationMark: ExtendedTokenSyntax

  /// The content.
  public let string: ExtendedTokenSyntax

  /// The closing quotation mark.
  public let closingQuotationMark: ExtendedTokenSyntax

  // MARK: - ExtendedSyntax

  public var children: [ExtendedSyntax] {
    return [openingQuotationMark, string, closingQuotationMark]
  }
}
