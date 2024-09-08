/*
 CodeBlockNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// A block of code used in documentation.
public struct CodeBlockNode: StreamedViaChildren, SyntaxNode {

  // MARK: - Initialization

  /// Parses a code block node.
  ///
  /// - Parameters:
  ///   - source: The source.
  public init?(source: String) {
    let delimiter = Token(kind: .codeDelimiter("```"))
    let delimiterText = delimiter.text().unicodeScalars
    let delimiterLength = delimiterText.count

    var string = source
    guard string.unicodeScalars.starts(with: delimiterText) else {
      return nil
    }
    self.openingDelimiter = delimiter
    string.unicodeScalars.removeFirst(delimiterLength)

    var language = ""
    while string.first?.isNewline == false {
      language.append(string.removeFirst())
    }
    if ¬language.isEmpty {
      self.language = Token(kind: .language(language))
    } else {
      self.language = nil
    }

    guard string.first?.isNewline == true else {
      return nil
    }
    self.openingVerticalMargin = Token(kind: .lineBreaks(String(string.removeFirst())))

    guard string.unicodeScalars.suffix(delimiterLength).elementsEqual(delimiterText) else {
      return nil
    }
    string.unicodeScalars.removeLast(delimiterLength)
    self.closingDelimiter = delimiter

    if string.last?.isNewline == true {
      self.closingVerticalMargin = Token(kind: .lineBreaks(String(string.removeLast())))
    } else {
      self.closingVerticalMargin = nil
    }

    var isSwift: Bool?
    if language == "swift" {
      isSwift = true
    } else if ¬language.isEmpty {
      isSwift = false
    }
    self.source = CodeContent(
      source: string,
      isSwift: isSwift
    )
  }

  // MARK: - Properties

  /// The opening delimiter.
  public let openingDelimiter: Token

  /// The language identifier.
  public let language: Token?

  /// The line break between the opening delimiter and the code.
  public let openingVerticalMargin: Token

  /// The contents of the inline code.
  public let source: CodeContent

  /// The line break between the code and the closing delimiter.
  public let closingVerticalMargin: Token?

  /// The closing delimiter.
  public let closingDelimiter: Token

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    var children: [SyntaxNode] = [openingDelimiter]
    if let language = language {
      children.append(language)
    }
    children.append(contentsOf: [openingVerticalMargin, source])
    if let closing = closingVerticalMargin {
      children.append(closing)
    }
    children.append(contentsOf: [closingDelimiter])
    return children
  }
}
