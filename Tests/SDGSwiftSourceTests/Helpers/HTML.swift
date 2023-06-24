/*
 HTML.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

func HTMLPage(content: String, cssPath: String) -> String {
  return [
    "<\u{21}DOCTYPE html>",
    "<html>",
    " <head>",
    "  <meta charset=\u{22}utf\u{2D}8\u{22}>",
    "   <link rel=\u{22}stylesheet\u{22} href=\u{22}\(cssPath)\u{22}>",
    " </head>",
    " <body>",
    "",
    content,
    "",
    " </body>",
    "</html>",
  ].joined(separator: "\n")
    .replacingMatches(for: "<span class=\u{22}TokenSyntax eof\u{22}></span>", with: "")
}
