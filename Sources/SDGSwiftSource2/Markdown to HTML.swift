/*
 Markdown to HTML.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Can docc do this?)

import SDGLogic

import SDGHTML

extension SyntaxNode {

  public var _renderedHtmlElement: String? {
    return nil
  }

  public var _renderedHTMLAttributes: [String: String] {
    return [:]
  }

  public func renderedHTML(
    localization: String,
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String],
    parserCache: inout ParserCache
  ) -> String {
    var result = ""
    let possibleElement = _renderedHtmlElement
    if let element = possibleElement {
      result.append(contentsOf: "<" + element)
      let attributes = _renderedHTMLAttributes
      if ¬attributes.isEmpty {
        for key in attributes.keys.sorted() {
          result.append(contentsOf: " " + key + "=\u{22}" + attributes[key]! + "\u{22}")
        }
      }
      result.append(contentsOf: ">")
    }
    for child in children(cache: &parserCache) {
      result.append(
        contentsOf: child.renderedHTML(
          localization: localization,
          internalIdentifiers: internalIdentifiers,
          symbolLinks: symbolLinks,
          parserCache: &parserCache
        )
      )
    }
    if let element = possibleElement {
      result.append(contentsOf: "</" + element + ">")
    }
    return result
  }
}

extension Token {
  public func renderedHTML(
    localization: String,
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String],
    parserCache: inout ParserCache
  ) -> String {
    switch kind {
    case .swiftSyntax, .lineCommentDelimiter, .openingBlockCommentDelimiter, .closingBlockCommentDelimiter, .commentText, .commentURL, .mark, .sourceHeadingText, .lineDocumentationDelimiter, .openingBlockDocumentationDelimiter, .closingBlockDocumentationDelimiter, .bullet, .codeDelimiter, .language, .source, .headingDelimiter, .asterism, .emphasisDelimiter, .strengthDelimiter, .openingLinkContentDelimiter, .closingLinkContentDelimiter, .openingLinkTargetDelimiter, .closingLinkTargetDelimiter, .linkURL, .imageDelimiter, .quotationDelimiter, .calloutParameter, .calloutColon, .fragment, .shebang:
      return ""
    case .whitespace, .lineBreaks:
      return " "
    case .documentationText:
      var escaped = HTML.escapeTextForCharacterData(text())
      // Prevent escaping escapes.
      escaped.replaceMatches(for: "&#x0026;", with: "&")
      return escaped
    case .callout:
      let text = self.text()
      return "<p class=\u{22}callout‐label \(text.lowercased())\u{22}>"
        + HTML.escapeTextForCharacterData(String(Callout(text)!.localizedText(localization)))
        + "</p>"
    case .markdownLineBreak:
      return "<br>"
    }
  }
}

extension CalloutNode {
  public var _renderedHtmlElement: String? {
    return "div"
  }
  public var _renderedHTMLAttributes: [String: String] {
    return ["class": "callout \(name.text().lowercased())"]
  }
}

extension CodeBlockNode {
  public func renderedHTML(
    localization: String,
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String],
    parserCache: inout ParserCache
  ) -> String {
    #warning("Syntax Highlighting not implemented yet.")
    return text()
    /*return source.syntaxHighlightedHTML(
      inline: false,
      internalIdentifiers: internalIdentifiers,
      symbolLinks: symbolLinks
    )*/
  }
}

extension FontNode {
  public var _renderedHtmlElement: String? {
    if openingDelimiter.text().count == 2 {
      return "strong"
    } else {
      return "em"
    }
  }
}

extension ImageNode {
  public func renderedHTML(
    localization: String,
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String],
    parserCache: inout ParserCache
  ) -> String {
    let alternate = HTML.escapeTextForCharacterData(link.content.contents.map({ $0.text() }).joined())
    return "<img alt=\u{22}" + alternate + "\u{22} src=\u{22}"
      + HTML.escapeTextForAttribute(link.target.target.text()) + "\u{22}>"
  }
}

extension InlineCodeNode {
  public func renderedHTML(
    localization: String,
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String],
    parserCache: inout ParserCache
  ) -> String {
    #warning("Syntax highlighting not implemented yet.")
    return text()
    /*return source.syntaxHighlightedHTML(
      inline: true,
      internalIdentifiers: internalIdentifiers,
      symbolLinks: symbolLinks
    )*/
  }
}

extension LinkNode {
  public var _renderedHtmlElement: String? {
    return "a"
  }
  public var _renderedHTMLAttributes: [String: String] {
    return [
      "href": HTML.escapeTextForAttribute(target.target.text())
    ]
  }
}

extension ListNode {
  public var _renderedHtmlElement: String? {
    return isOrdered ? "ol" : "ul"
  }
}
extension ListItemNode {
  public var _renderedHtmlElement: String? {
    return "li"
  }
}

extension MarkdownHeading {
  public var _renderedHtmlElement: String? {
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

extension ParagraphNode {
  public var _renderedHtmlElement: String? {
    return "p"
  }
  public var _renderedHTMLAttributes: [String: String] {
    return text().unicodeScalars.first == "―" ? ["class": "citation"] : [:]
  }
}

extension Quotation {
  public var _renderedHtmlElement: String? {
    return "blockquote"
  }
}
