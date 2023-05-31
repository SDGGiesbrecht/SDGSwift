/*
 LineCommentSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

  import SDGLocalization

  import SwiftSyntax

  /// A line comment.
  public class LineCommentSyntax: ExtendedSyntax {  // @exempt(from: classFinality)

    // MARK: - Class Properties

    internal class var delimiter: ExtendedTokenSyntax {
      primitiveMethod()
    }

    internal class func parse(contents: String, siblings: Trivia, index: Trivia.Index)
      -> ExtendedSyntax
    {
      primitiveMethod()
    }

    // MARK: - Initialization

    internal init(source: String, siblings: Trivia, index: Trivia.Index) {
      let delimiter = type(of: self).delimiter

      var line = source
      line.removeFirst(delimiter.text.count)
      self.delimiter = delimiter
      var children: [ExtendedSyntax] = [delimiter]

      if line.first == " " {
        line.removeFirst()
        let indent = ExtendedTokenSyntax(text: " ", kind: .whitespace)
        self.indent = indent
        children.append(indent)
      } else {
        self.indent = nil
      }

      let content = type(of: self).parse(contents: line, siblings: siblings, index: index)
      _content = content
      children.append(content)

      super.init(children: children)
    }

    // MARK: - Properties

    /// The delimiter.
    public let delimiter: ExtendedTokenSyntax

    /// The intent.
    public let indent: ExtendedTokenSyntax?

    internal var _content: ExtendedSyntax

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
