/*
 LineFragmentSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A line fragment.
public struct LineFragmentSyntax<Content>: ExtendedSyntax where Content: ExtendedSyntax {

  // MARK: - Initialization

  /// Creates a line fragment node.
  ///
  /// - Parameters:
  ///   - indent: The indent.
  ///   - content: The content.
  ///   - lineBreak: The trailing line break.
  public init(indent: ExtendedTokenSyntax?, content: Content, lineBreak: ExtendedTokenSyntax?) {
    self.indent = indent
    self.content = content
    self.lineBreak = lineBreak
  }

  // MARK: - Properties

  /// The indent.
  public var indent: ExtendedTokenSyntax?

  /// The content.
  public var content: Content

  /// The trailing lineBreak
  public var lineBreak: ExtendedTokenSyntax?

  // MARK: - ExtendedSyntax

  public var children: [ExtendedSyntax] {
    var result: [ExtendedSyntax] = []
    if let indent = indent {
      result.append(indent)
    }
    result.append(content)
    if let lineBreak = lineBreak {
      result.append(lineBreak)
    }
    return result
  }
}
