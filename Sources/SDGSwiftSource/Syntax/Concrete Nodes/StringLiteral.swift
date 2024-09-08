/*
 StringLiteral.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A string literal.
public struct StringLiteral: StreamedViaChildren, SyntaxNode {

  // MARK: - Initialization

  /// Parses a string literal.
  ///
  /// - Parameters:
  ///   - source: The source.
  public init?(source: String) {
    let quotationMark = Token(kind: .swiftSyntax(.stringQuote))
    let quotationMarkText = quotationMark.text().unicodeScalars
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

      self.string = Token(kind: .swiftSyntax(.stringSegment(string)))
  }

  // MARK: - Properties

  /// The opening quotation mark.
  public let openingQuotationMark: Token

  /// The content.
  public let string: Token

  /// The closing quotation mark.
  public let closingQuotationMark: Token

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    return [openingQuotationMark, string, closingQuotationMark]
  }
}
