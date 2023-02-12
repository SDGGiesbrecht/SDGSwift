/*
 SyntaxHighlighter.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGText

/// A namespace for syntax highlighting.
public enum SyntaxHighlighter {

  /// The CSS to use with syntax‐highlighted HTML.
  public static var css: StrictString {
    return StrictString(Resources.syntaxHighlighting).dropping(through: "*/\n\n")
  }

  internal static func frame(
    highlightedSyntax: String,
    inline: Bool
  ) -> String {  // @exempt(from: tests)  Unreachable from tvOS.
    var result = "<code class=\u{22}swift"
    if ¬inline {
      result += " blockquote"
    }
    result += "\u{22}>"
    result += highlightedSyntax
    result += "</code>"
    return result
  }
}
