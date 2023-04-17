/*
 TriviaPiece.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax

  extension TriviaPiece {

    /// The source code of the trivia piece.
    public var text: String {
      var result = ""
      write(to: &result)
      return result
    }

    /// The extended syntax of the trivia piece.
    public var extended: ExtendedSyntax {
      let result: ExtendedSyntax
      switch self {
      case .spaces, .tabs:
        result = ExtendedTokenSyntax(kind: .whitespace(text))
      case .verticalTabs, .formfeeds, .newlines, .carriageReturns, .carriageReturnLineFeeds:
        result = ExtendedTokenSyntax(kind: .lineBreaks(text))
      case .lineComment:
        result = LineCommentSyntax(source: text)
      case .blockComment:
        result = BlockCommentSyntax(source: text)
      case .docLineComment:
        result = LineDocumentationSyntax(source: text)
      case .docBlockComment:
        // #workaround(Not implemented yet.)
        result = ExtendedTokenSyntax(kind: .skipped(text))
      case .unexpectedText:  // @exempt(from: tests)
        result = ExtendedTokenSyntax(kind: .source(text))
      case .shebang:
        // #workaround(Not implemented yet.)
        result = ExtendedTokenSyntax(kind: .skipped(text))
      }
      return result
    }
  }
#endif
