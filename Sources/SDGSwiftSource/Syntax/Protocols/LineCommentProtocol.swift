/*
 LineCommentProtocol.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

/// Functionality shared between line comments and line documentation.
internal protocol LineCommentProtocol: StreamedViaChildren, SyntaxNode {
  associatedtype Content: LineCommentContentProtocol
  static var delimiter: Token.Kind { get }
  var delimiter: Token { get }
  var indent: Token? { get }
  var content: Fragment<Content> { get }
}

extension LineCommentProtocol {

  // MARK: - Initialization

  internal static func parse(
    precedingContentContext: String,
    source: String,
    followingContentContext: String
  ) -> (
    delimiter: Token,
    indent: Token?,
    content: Fragment<Content>
  )? {
    let delimiter = Token(kind: Self.delimiter)

    var line = source
    guard line.scalars.hasPrefix(delimiter.text().scalars) else {
      return nil
    }
    line.scalars.removeFirst(delimiter.text().scalars.count)

    let indent: Token?
    if line.scalars.first == " " {
      line.scalars.removeFirst()
      let indentSyntax = Token(kind: .whitespace(" "))
      indent = indentSyntax
    } else {
      indent = nil
    }

    let content = Content(source: precedingContentContext + line + followingContentContext)
    let precedingCount = precedingContentContext.scalars.count
    let fragment = Fragment(
      scalarOffsets: precedingCount..<precedingCount + line.scalars.count,
      in: content
    )

    return (delimiter: delimiter, indent: indent, content: fragment)
  }

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    var result: [SyntaxNode] = [delimiter]
    if let indent = indent {
      result.append(indent)
    }
    result.append(content)
    return result
  }
}
