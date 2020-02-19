/*
 TextFreedomHighlighter.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
  import SDGLocalization

  import SwiftSyntax

  import SDGSwiftSource

  class TextFreedomHighlighter: Highlighter {

    static var targetTestFreedom: TextFreedom = .arbitrary

    override func shouldHighlight(_ token: TokenSyntax) -> Bool {
      return token.textFreedom == type(of: self).targetTestFreedom
    }
    override func shouldHighlight(_ trivia: ExtendedTokenSyntax) -> Bool {
      return trivia.kind.textFreedom == type(of: self).targetTestFreedom
    }
  }
#endif
