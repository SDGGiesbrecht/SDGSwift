/*
 LineCommentSyntaxProtocol.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Functionality shared between line comments and line documentation.
internal protocol LineCommentSyntaxProtocol {
  associatedtype Content: LineCommentContentProtocol
  static var delimiter: ExtendedTokenKind { get }
  var delimiter: ExtendedTokenSyntax { get }
  var indent: ExtendedTokenSyntax? { get }
  var content: Content { get }
}

extension LineCommentSyntaxProtocol {

  // MARK: - Initialization

  internal static func parse(
    source: String
  ) -> (
    delimiter: ExtendedTokenSyntax,
    indent: ExtendedTokenSyntax?,
    content: Content
  ) {
    let delimiter = ExtendedTokenSyntax(kind: Self.delimiter)

    var line = source
    line.removeFirst(delimiter.text.count)

    let indent: ExtendedTokenSyntax?
    if line.first == " " {
      line.removeFirst()
      let indentSyntax = ExtendedTokenSyntax(kind: .whitespace(" "))
      indent = indentSyntax
    } else {
      indent = nil
    }

    let content = Content(source: line)

    return (delimiter: delimiter, indent: indent, content: content)
  }

  // MARK: - ExtendedSyntax

  public var children: [ExtendedSyntax] {
    var result: [ExtendedSyntax] = [delimiter]
    if let indent = indent {
      result.append(indent)
    }
    result.append(content)
    return result
  }
}
