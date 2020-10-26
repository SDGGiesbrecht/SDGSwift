/*
 LineSeparatorSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  /// An explicit line separator in documentation.
  public final class LineSeparatorSyntax: MarkdownSyntax {

    internal init() {
      super.init(children: [
        ExtendedTokenSyntax(text: "  ", kind: .lineSeparator),
        ExtendedTokenSyntax(text: "\n", kind: .newlines),
      ])
    }
  }
#endif
