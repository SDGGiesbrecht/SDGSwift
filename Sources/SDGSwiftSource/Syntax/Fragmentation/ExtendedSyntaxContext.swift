/*
 ExtendedSyntaxContext.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

  import SwiftSyntax

  /// The context of an extended syntax node.
  public indirect enum ExtendedSyntaxContext {

    // MARK: - Cases

    case _trivia(TriviaPiece, context: TriviaPieceContext)
    case _token(TokenSyntax, context: SyntaxContext)
    case _fragment(CodeFragmentSyntax, context: ExtendedSyntaxContext, offset: Int)
  }
