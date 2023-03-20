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

  // MARK: - Initialization

  /// Creates a string literal syntax node.
  ///
  /// - Parameters:
  ///   - openingQuotationMark: Optional. The opening quotation mark.
  ///   - string: The contents of the string.
  ///   - closingQuotationMark: Optional. The closing quotation mark.
  public init(
    openingQuotationMark: ExtendedTokenSyntax = ExtendedTokenSyntax(kind: .quotationMark),
    string: ExtendedTokenSyntax,
    closingQuotationMark: ExtendedTokenSyntax = ExtendedTokenSyntax(kind: .quotationMark)
  ) {
    self.openingQuotationMark = openingQuotationMark
    self.string = string
    self.closingQuotationMark = closingQuotationMark
  }

  /// Parses a string literal.
  public init?(source: String) {
    let quotationMark = ExtendedTokenSyntax(kind: .quotationMark)
    let quotationMarkText = quotationMark.text.unicodeScalars
    let quotationMarkLength = quotationMarkText.count

    var string = source
    guard string.unicodeScalars.starts(with: quotationMarkText) else {
      return nil
    }
    self.openingQuotationMark = quotationMark
    string.unicodeScalars.removeFirst(quotationMarkLength)

    guard string.unicodeScalars.suffix(quotationMarkLength).elementsEqual(quotationMarkText) else {
      return nil
    }
    string.unicodeScalars.removeLast(quotationMarkLength)
    self.closingQuotationMark = quotationMark

    self.string = ExtendedTokenSyntax(kind: .string(string))
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
