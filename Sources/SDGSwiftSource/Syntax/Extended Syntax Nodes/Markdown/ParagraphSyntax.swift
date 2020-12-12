/*
 ParagraphSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3.1, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  /// A paragraph in documentation.
  public final class ParagraphSyntax: MarkdownSyntax {

    // MARK: - Properties

    internal var isCitation = false

    // MARK: - ExtendedSyntax

    internal override var renderedHtmlElement: String? {
      return "p"
    }

    internal override var renderedHTMLAttributes: [String: String] {
      var result = super.renderedHTMLAttributes
      if isCitation {
        result["class"] = "citation"
      }
      return result
    }
  }
#endif
