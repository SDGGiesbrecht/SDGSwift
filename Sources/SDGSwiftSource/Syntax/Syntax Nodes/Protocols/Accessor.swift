/*
 Accessor.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.2.2, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  import SDGLogic

  import SwiftSyntax

  internal protocol Accessor: AccessControlled {
    var keyword: TokenSyntax { get }
    var accessors: Syntax? { get }
  }

  extension Accessor {

    private var hasReducedSetterAccessLevel: Bool {
      guard let modifiers = self.modifiers else {
        return false  // @exempt(from: tests) SwiftSyntax seems to prefer empty over nil.
      }
      for modifier in modifiers {
        if let detail = modifier.detail {
          let kind = modifier.name.tokenKind
          if kind == .internalKeyword ∨ kind == .fileprivateKeyword ∨ kind == .privateKeyword,
            detail.text == "set"
          {
            return true
          }
        }
      }
      return false
    }

    internal var isSettable: Bool {
      if keyword.tokenKind == .letKeyword {
        // let
        return false
      } else {
        // var
        if hasReducedSetterAccessLevel {
          return false
        }
        guard let accessors = self.accessors else {
          // Stored.
          return true
        }
        if let accessorBlock = accessors.as(AccessorBlockSyntax.self) {
          if accessorBlock.accessors.count > 1 {
            // Two accessors: get + set
            return true
          } else {
            // Just one accessor: get
            return false
          }
        } else {
          // Computed.
          return false
        }
      }
    }

    internal func accessorListForAPIDeclaration() -> AccessorBlockSyntax {
      var accessors: [AccessorDeclSyntax] = [
        SyntaxFactory.makeAccessorDecl(
          attributes: nil,
          modifier: nil,
          accessorKind: SyntaxFactory.makeToken(.contextualKeyword("get")),
          parameter: nil,
          body: nil
        )
      ]
      if isSettable {
        accessors.append(
          SyntaxFactory.makeAccessorDecl(
            attributes: nil,
            modifier: nil,
            accessorKind: SyntaxFactory.makeToken(
              .contextualKeyword("set"),
              leadingTrivia: .spaces(1)
            ),
            parameter: nil,
            body: nil
          )
        )
      }
      return SyntaxFactory.makeAccessorBlock(
        leftBrace: SyntaxFactory.makeToken(
          .leftBrace,
          leadingTrivia: .spaces(1),
          trailingTrivia: .spaces(1)
        ),
        accessors: SyntaxFactory.makeAccessorList(accessors),
        rightBrace: SyntaxFactory.makeToken(.rightBrace, leadingTrivia: .spaces(1))
      )
    }
  }
#endif
