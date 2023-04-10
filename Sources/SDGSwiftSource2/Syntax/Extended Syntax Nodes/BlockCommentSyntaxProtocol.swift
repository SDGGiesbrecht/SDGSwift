/*
 BlockCommentSyntaxProtocol.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic
import SDGCollections
import SDGText

/// Functionality shared between line comments and line documentation.
internal protocol BlockCommentSyntaxProtocol {
  associatedtype Content: BlockCommentContentProtocol
  static var openingDelimiter: ExtendedTokenKind { get }
  static var closingDelimiter: ExtendedTokenKind { get }
  var openingDelimiter: ExtendedTokenSyntax { get }
  var openingVerticalMargin: ExtendedTokenSyntax? { get }
  var content: [LineFragmentSyntax<FragmentSyntax<Content>>] { get }
  var closingVerticalMargin: ExtendedTokenSyntax? { get }
  var closingDelimiterIndentation: ExtendedTokenSyntax? { get }
  var closingDelimiter: ExtendedTokenSyntax { get }
}

extension BlockCommentSyntaxProtocol {

  internal static func parse(source: String) -> (
    openingDelimiter: ExtendedTokenSyntax,
    openingVerticalMargin: ExtendedTokenSyntax?,
    content: [LineFragmentSyntax<FragmentSyntax<Content>>],
    closingVerticalMargin: ExtendedTokenSyntax?,
    closingDelimiterIndentation: ExtendedTokenSyntax?,
    closingDelimiter: ExtendedTokenSyntax
  ) {
    let openingDelimiter = ExtendedTokenSyntax(kind: Self.openingDelimiter)
    let closingDelimiter = ExtendedTokenSyntax(kind: Self.closingDelimiter)

    var block = source
    block.scalars.removeFirst(openingDelimiter.text.scalars.count)

    block.scalars.removeLast(closingDelimiter.text.scalars.count)

    let closingDelimiterIndentation: ExtendedTokenSyntax?
    if block.scalars.last == " " {
      block.scalars.removeLast()
      closingDelimiterIndentation = ExtendedTokenSyntax(kind: .whitespace(" "))
    } else {
      closingDelimiterIndentation = nil
    }

    let openingVerticalMargin: ExtendedTokenSyntax?
    if block.scalars.first == "\n" {
      block.scalars.removeFirst()
      openingVerticalMargin = ExtendedTokenSyntax(kind: .lineBreaks("\n"))
    } else {
      openingVerticalMargin = nil
    }

    let closingVerticalMargin: ExtendedTokenSyntax?
    if block.scalars.last == "\n" {
      block.scalars.removeLast()
      closingVerticalMargin = ExtendedTokenSyntax(kind: .lineBreaks("\n"))
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

    var content: [LineFragmentSyntax<FragmentSyntax<Content>>] = []
    var index = 0
    for line in contentsString.lines {
      defer { index += 1 }
      let indent = indents[index]
      let indentNode: ExtendedTokenSyntax? =
        indent.isEmpty ? nil : ExtendedTokenSyntax(kind: .whitespace(indent))
      let lowerOffset = contentsString.scalars.distance(
        from: contentsString.scalars.startIndex,
        to: line.line.startIndex
      )
      let upperOffset = contentsString.scalars.distance(
        from: contentsString.scalars.startIndex,
        to: line.line.endIndex
      )
      let contentNode = FragmentSyntax(scalarOffsets: lowerOffset..<upperOffset, in: parsed)
      let newline = newlines[index]
      let lineBreakNode: ExtendedTokenSyntax? =
        newline.isEmpty ? nil : ExtendedTokenSyntax(kind: .lineBreaks(newline))
      content.append(
        LineFragmentSyntax(indent: indentNode, content: contentNode, lineBreak: lineBreakNode)
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
}
