/*
 ExtendedSyntaxContext.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.2.2, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  import SwiftSyntax

  /// The context of an extended syntax node.
  public indirect enum ExtendedSyntaxContext {

    // MARK: - Cases

    case _trivia(TriviaPiece, context: TriviaPieceContext)
    case _token(TokenSyntax, context: SyntaxContext)
    case _fragment(CodeFragmentSyntax, context: ExtendedSyntaxContext, offset: Int)

    // MARK: - Properties

    internal var source: String {
      switch self {
      case ._trivia(_, let context):
        return context.source
      case ._token(_, let context):
        return context.fragmentContext
      case ._fragment(_, let context, offset: _):
        return context.source
      }
    }
  }
#endif
