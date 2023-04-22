/*
 TriviaPieceContext.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax
#endif

/// The context of a trivia piece.
public struct TriviaPieceContext {

  // MARK: - Properties

  internal var precedingDocumentationContext: String?
  internal var followingDocumentationContext: String?
}
