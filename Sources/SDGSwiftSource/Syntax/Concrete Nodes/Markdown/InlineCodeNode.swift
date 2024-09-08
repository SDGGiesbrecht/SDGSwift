/*
 InlineCodeNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Inline code used in documentation.
public struct InlineCodeNode: StreamedViaChildren, SyntaxNode {

  // MARK: - Initialization

  /// Parses an inline code node.
  ///
  /// - Parameters:
  ///   - source: The source.
  public init?(source: String) {
    let delimiter = Token(kind: .codeDelimiter("`"))
    let delimiterText = delimiter.text().unicodeScalars
    let delimiterLength = delimiterText.count

    var string = source
    guard string.unicodeScalars.starts(with: delimiterText) else {
      return nil
    }
    self.openingDelimiter = delimiter
    string.unicodeScalars.removeFirst(delimiterLength)

    guard string.unicodeScalars.suffix(delimiterLength).elementsEqual(delimiterText) else {
      return nil
    }
    string.unicodeScalars.removeLast(delimiterLength)
    self.closingDelimiter = delimiter

    self.source = CodeContent(
      source: string,
      isSwift: nil
    )
  }

  // MARK: - Properties

  /// The opening delimiter.
  public let openingDelimiter: Token

  /// The contents of the inline code.
  public let source: CodeContent

  /// The closing delimiter.
  public let closingDelimiter: Token

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    return [openingDelimiter, source, closingDelimiter]
  }
}
