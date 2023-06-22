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

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN
  import Markdown
#endif

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
