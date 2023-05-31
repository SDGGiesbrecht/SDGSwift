/*
 HeadingSyntax.swift

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

  import cmark_gfm

  /// A documentation heading.
  public final class HeadingSyntax: MarkdownSyntax {

    // MARK: - Initialization

    internal init(node: UnsafeMutablePointer<cmark_node>, in documentation: String) {
      var precedingChildren: [ExtendedSyntax] = []
      var followingChildren: [ExtendedSyntax] = []

      let level = Int(cmark_node_get_heading_level(node))
      self.level = level

      let nodeStart = node.lowerBound(in: documentation)
      let nodeEnd = node.upperBound(in: documentation)

      let delimiterPattern = String(repeating: "#", count: level)
      if documentation.scalars[nodeStart..<nodeEnd]
        .hasPrefix(delimiterPattern.scalars.literal(for: String.ScalarView.SubSequence.self))
      {
        let delimiterEnd = documentation.scalars.index(
          nodeStart,
          offsetBy: delimiterPattern.scalars.count
        )

        let delimiterSyntax = ExtendedTokenSyntax(text: delimiterPattern, kind: .headingDelimiter)
        numberSignDelimiter = delimiterSyntax
        precedingChildren.append(delimiterSyntax)

        var indentEnd = delimiterEnd
        while indentEnd ≠ nodeEnd,
          documentation.scalars[indentEnd].properties.isWhitespace
        {
          indentEnd = documentation.scalars.index(after: indentEnd)
        }
        let indent = ExtendedTokenSyntax(
          text: String(documentation.scalars[delimiterEnd..<indentEnd]),
          kind: .whitespace
        )
        self.indent = indent
        precedingChildren.append(indent)

        underline = nil
        trailingNewlines = nil
      } else {
        numberSignDelimiter = nil
        indent = nil

        if let newline = documentation.scalars[nodeStart..<nodeEnd].firstMatch(
          for: CharacterSet.newlinePattern(for: String.ScalarView.SubSequence.self)
        ) {

          var delimiterEnd = documentation.scalars.endIndex
          if let nextNewline = documentation.scalars[
            newline.range.upperBound..<documentation.scalars.endIndex
          ].firstMatch(
            for: CharacterSet.newlinePattern(for: String.ScalarView.SubSequence.self)
          ) {
            delimiterEnd = nextNewline.range.lowerBound
          }
          let underline = ExtendedTokenSyntax(
            text: String(documentation.scalars[newline.range.upperBound..<delimiterEnd]),
            kind: .headingDelimiter
          )
          followingChildren.append(underline)
          self.underline = underline

          var newlineEnd = nodeEnd
          if newlineEnd > delimiterEnd {
            newlineEnd = documentation.scalars.index(before: newlineEnd)
          }
          let trailingNewlinesString = String(documentation.scalars[delimiterEnd..<newlineEnd])
          if ¬trailingNewlinesString.isEmpty {
            let trailingNewlines = ExtendedTokenSyntax(
              text: trailingNewlinesString,
              kind: .newlines
            )
            self.trailingNewlines = trailingNewlines
            followingChildren.append(trailingNewlines)
          } else {
            self.trailingNewlines = nil  // @exempt(from: tests) Unreachable with valid syntax.
          }

        } else {
          underline = nil  // @exempt(from: tests) Unreachable with valid syntax.
          trailingNewlines = nil
        }
      }
      super.init(
        node: node,
        in: documentation,
        precedingChildren: precedingChildren,
        followingChildren: followingChildren
      )
    }

    // MARK: - Properties

    private let level: Int

    /// The number sign delimiter.
    public let numberSignDelimiter: ExtendedTokenSyntax?

    /// The indent after the number sign delimiter.
    public let indent: ExtendedTokenSyntax?

    /// The underline delimiter.
    public let underline: ExtendedTokenSyntax?

    /// Trailing newlines.
    public let trailingNewlines: ExtendedTokenSyntax?

    // MARK: - ExtendedSyntax

    internal override var renderedHtmlElement: String? {
      switch level {
      case ...1:
        return "h1"
      case 2:
        return "h2"
      case 3:
        return "h3"
      case 4:
        return "h4"
      case 5:
        return "h5"
      default:
        return "h6"
      }
    }
  }
