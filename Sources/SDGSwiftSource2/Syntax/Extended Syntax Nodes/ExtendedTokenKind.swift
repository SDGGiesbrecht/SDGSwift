/*
 ExtendedTokenKind.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Enumerates the kinds of extended tokens.
///
/// This type is comparable to `TokenKind`, but represents syntax not handled by the `SwiftSyntax` module.
public enum ExtendedTokenKind: Sendable {

  // MARK: - Cases

  case string(String)
  case quotationMark

  /// The textual representation of this token kind.
  public var text: String {
    switch self {
    case .string(let string):
      return string
    case .quotationMark:
      return "\u{22}"
    }
  }
}
