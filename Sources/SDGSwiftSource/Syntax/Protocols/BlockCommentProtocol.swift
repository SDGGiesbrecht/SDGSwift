/*
 BlockCommentProtocol.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic
import SDGCollections
import SDGText

/// Functionality shared between block comments and block documentation.
internal protocol BlockCommentProtocol: StreamedViaChildren, SyntaxNode {
  associatedtype Content: BlockCommentContentProtocol
  static var openingDelimiter: Token.Kind { get }
  static var closingDelimiter: Token.Kind { get }
  var openingDelimiter: Token { get }
  var openingVerticalMargin: Token? { get }
  var content: [LineFragment<Fragment<Content>>] { get }
  var closingVerticalMargin: Token? { get }
  var closingDelimiterIndentation: Token? { get }
  var closingDelimiter: Token { get }
}

extension BlockCommentProtocol {

  internal static func parse(source: String) -> (
    openingDelimiter: Token,
    openingVerticalMargin: Token?,
    content: [LineFragment<Fragment<Content>>],
    closingVerticalMargin: Token?,
    closingDelimiterIndentation: Token?,
    closingDelimiter: Token
  )? {
    let openingDelimiter = Token(kind: Self.openingDelimiter)
    let closingDelimiter = Token(kind: Self.closingDelimiter)

    var block = source
    guard block.scalars.hasPrefix(openingDelimiter.text().scalars) else {
      return nil
    }
    block.scalars.removeFirst(openingDelimiter.text().scalars.count)

    guard block.scalars.hasSuffix(closingDelimiter.text().scalars) else {
      return nil
    }
    block.scalars.removeLast(closingDelimiter.text().scalars.count)

    let closingDelimiterIndentation: Token?
    var closingDelimiterIndentationString = ""
    while block.scalars.last == " " ∨ block.scalars.last == "\t" {
      closingDelimiterIndentationString.scalars.append(block.scalars.removeLast())
    }
    if ¬closingDelimiterIndentationString.isEmpty {
      closingDelimiterIndentation = Token(kind: .whitespace(closingDelimiterIndentationString))
    } else {
      closingDelimiterIndentation = nil
    }

    let openingVerticalMargin: Token?
    if block.scalars.hasPrefix("\r\n".scalars) {
      block.scalars.removeFirst(2)
      openingVerticalMargin = Token(kind: .lineBreaks("\r\n"))
    } else if block.scalars.first == "\n" {
      block.scalars.removeFirst()
      openingVerticalMargin = Token(kind: .lineBreaks("\n"))
    } else {
      openingVerticalMargin = nil
    }

    let closingVerticalMargin: Token?
    if block.scalars.hasSuffix("\r\n".scalars) {
      block.scalars.removeLast(2)
      closingVerticalMargin = Token(kind: .lineBreaks("\r\n"))
    } else if block.scalars.last == "\n" {
      block.scalars.removeLast()
      closingVerticalMargin = Token(kind: .lineBreaks("\n"))
    } else {
      closingVerticalMargin = nil
    }

    let indentMatch = block.scalars.prefix(
      upTo: ConditionalPattern({ $0 ∉ CharacterSet.whitespaces })
    )
    let indent = indentMatch.flatMap({ String($0.contents) }) ?? ""
    var indents: [String] = []
    var contents: [String] = []
    var newlines: [String] = []
    for line in block.lines {
      var contentLine = String(line.line)
      if contentLine.scalars.hasPrefix(indent.scalars) {
        indents.append(indent)
        contentLine.scalars.removeFirst(indent.scalars.count)
      } else {
        indents.append("")
      }
      contents.append(contentLine)
      newlines.append(String(line.newline))
    }
    let contentsString = contents.joined(separator: "\n")
    let parsed = Content(source: contentsString)

    var content: [LineFragment<Fragment<Content>>] = []
    var index = 0
    for line in contentsString.lines {
      defer { index += 1 }
      let indent = indents[index]
      let indentNode: Token? =
        indent.isEmpty ? nil : Token(kind: .whitespace(indent))
      let lowerOffset = contentsString.scalars.distance(
        from: contentsString.scalars.startIndex,
        to: line.line.startIndex
      )
      let upperOffset = contentsString.scalars.distance(
        from: contentsString.scalars.startIndex,
        to: line.line.endIndex
      )
      let contentNode = Fragment(scalarOffsets: lowerOffset..<upperOffset, in: parsed)
      let newline = newlines[index]
      let lineBreakNode: Token? =
        newline.isEmpty ? nil : Token(kind: .lineBreaks(newline))
      content.append(
        LineFragment(indent: indentNode, content: contentNode, lineBreak: lineBreakNode)
      )
    }

    return (
      openingDelimiter: openingDelimiter,
      openingVerticalMargin: openingVerticalMargin,
      content: content,
      closingVerticalMargin: closingVerticalMargin,
      closingDelimiterIndentation: closingDelimiterIndentation,
      closingDelimiter: closingDelimiter
    )
  }

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    var result: [SyntaxNode] = [openingDelimiter]
    if let openingVerticalMargin = openingVerticalMargin {
      result.append(openingVerticalMargin)
    }
    result.append(contentsOf: content)
    if let closingVerticalMargin = closingVerticalMargin {
      result.append(closingVerticalMargin)
    }
    if let closingDelimiterIndentation = closingDelimiterIndentation {
      result.append(closingDelimiterIndentation)
    }
    result.append(closingDelimiter)
    return result
  }
}
