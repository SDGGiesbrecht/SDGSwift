/*
 Quotation.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A quotation in documentation.
public struct Quotation: StreamedViaChildren, SyntaxNode {

  // MARK: - Initialization

  internal init?(components: [SyntaxNode]) {
    var remainder = components[...]
    guard let delimiter = remainder.first as? Token,
      delimiter.text() == ">"
    else {
      return nil  // @exempt(from: tests) Believed to be unreachable.
    }
    remainder.removeFirst()
    self.delimiter = Token(kind: .quotationDelimiter)

    guard let indent = remainder.first as? Token,
      case .whitespace = indent.kind
    else {
      return nil  // @exempt(from: tests) Believed to be unreachable.
    }
    remainder.removeFirst()
    self.indent = indent

    self.contents = Array(remainder)
  }

  // MARK: - Properties

  /// The delimiter.
  public let delimiter: Token

  /// The indent between the delimiter and the contents.
  public let indent: Token

  /// The contents of the quotation.
  public let contents: [SyntaxNode]

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    return [delimiter, indent].appending(contentsOf: contents)
  }
}
