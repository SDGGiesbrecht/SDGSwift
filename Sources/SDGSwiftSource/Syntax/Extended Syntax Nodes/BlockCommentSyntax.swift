/*
 BlockCommentSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

  import Foundation

  import SDGLogic
  import SDGCollections
  import SDGText
  import SDGLocalization

  /// A block comment.
  public class BlockCommentSyntax: ExtendedSyntax {  // @exempt(from: classFinality)

    // MARK: - Class Properties

    internal class var openingDelimiter: ExtendedTokenSyntax {
      primitiveMethod()
    }
    private static var closingDelimiter: ExtendedTokenSyntax {
      return ExtendedTokenSyntax(text: "*/", kind: .closingBlockCommentDelimiter)
    }

    internal class func parse(contents: String) -> ExtendedSyntax {
      primitiveMethod()
    }

    // MARK: - Initialization

    internal init(source: String) {
      let openingDelimiter = type(of: self).openingDelimiter
      let closingDelimiter = type(of: self).closingDelimiter

      var block = source
      block.removeFirst(openingDelimiter.text.count)
      self.openingDelimiter = openingDelimiter
      var opening: [ExtendedSyntax] = [openingDelimiter]

      block.removeLast(closingDelimiter.text.count)
      self.closingDelimiter = closingDelimiter
      var closing: [ExtendedSyntax] = [closingDelimiter]

      if block.last == " " {
        block.removeLast()
        let indent = ExtendedTokenSyntax(text: " ", kind: .whitespace)
        self.closingDelimiterIndentation = indent
        closing.prepend(indent)
      } else {
        self.closingDelimiterIndentation = nil
      }

      if block.first == "\n" {
        block.removeFirst()
        let margin = ExtendedTokenSyntax(text: "\n", kind: .newlines)
        self.openingVerticalMargin = margin
        opening.append(margin)
      } else {
        self.openingVerticalMargin = nil
      }
      if block.last == "\n" {
        block.removeLast()
        let margin = ExtendedTokenSyntax(text: "\n", kind: .newlines)
        self.closingVerticalMargin = margin
        closing.prepend(margin)
      } else {
        self.closingVerticalMargin = nil
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
      let parsed = type(of: self).parse(contents: contentsString)
      internalSyntax = parsed

      var content: [ExtendedSyntax] = []
      var index = 0
      for line in contentsString.lines {
        defer { index += 1 }
        let indent = indents[index]
        if ¬indent.isEmpty {
          content.append(ExtendedTokenSyntax(text: indent, kind: .whitespace))
        }
        let lowerOffset = contentsString.scalars.distance(
          from: contentsString.scalars.startIndex,
          to: line.line.startIndex
        )
        let upperOffset = contentsString.scalars.distance(
          from: contentsString.scalars.startIndex,
          to: line.line.endIndex
        )
        content.append(FragmentSyntax(scalarOffsets: lowerOffset..<upperOffset, in: parsed))
        let newline = newlines[index]
        if ¬newline.isEmpty {
          content.append(ExtendedTokenSyntax(text: newline, kind: .newlines))
        }
      }

      self.content = content
      super.init(children: opening + content + closing)
    }

    // MARK: - Properties

    /// The opening delimiter.
    public let openingDelimiter: ExtendedTokenSyntax

    /// The opening vertical margin (a possible newline between the delimiter and the content).
    public let openingVerticalMargin: ExtendedTokenSyntax?

    /// The content.
    public let content: [ExtendedSyntax]

    /// The closing vertical margin (a possible newline between the delimiter and the content).
    public let closingVerticalMargin: ExtendedTokenSyntax?

    /// The indentation of the closing delimiter (a possible space preceding it).
    public let closingDelimiterIndentation: ExtendedTokenSyntax?

    /// The closing delimiter.
    public let closingDelimiter: ExtendedTokenSyntax

    internal var internalSyntax: ExtendedSyntax

    // MARK: - ExtendedSyntax

    internal override func nestedSyntaxHighlightedHTML(
      internalIdentifiers: Set<String>,
      symbolLinks: [String: String]
    ) -> String {
      var source = super.nestedSyntaxHighlightedHTML(
        internalIdentifiers: internalIdentifiers,
        symbolLinks: symbolLinks
      )
      source.prepend(contentsOf: "<span class=\u{22}comment\u{22}>")
      source.append(contentsOf: "</span>")
      return source
    }
  }
