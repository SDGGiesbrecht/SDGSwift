/*
 Member.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.2.4, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  import SDGLogic

  import SwiftSyntax

  /// A declaration which can be either a type or instance member.
  public protocol Member: SyntaxProtocol {
    /// The declaration modifiers.
    var modifiers: ModifierListSyntax? { get }
  }

  extension Member {

    private func typeMemberKeyword() -> TokenKind? {
      guard let modifiers = self.modifiers else {
        return nil  // @exempt(from: tests) SwiftSyntax seems to prefer empty over nil.
      }
      for modifier in modifiers {
        let tokenKind = modifier.name.tokenKind
        if tokenKind == .staticKeyword ∨ tokenKind == .classKeyword {
          return tokenKind
        }
      }
      return nil
    }

    /// Returns whether or not the declaration defines a type member (as opposed to an instance member).
    public func isTypeMember() -> Bool {
      return typeMemberKeyword() ≠ nil
    }
  }
#endif
