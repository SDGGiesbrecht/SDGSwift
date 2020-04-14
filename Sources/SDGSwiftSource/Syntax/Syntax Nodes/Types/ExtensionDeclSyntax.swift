/*
 ExtensionDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.2.1, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  import SDGLogic

  import SwiftSyntax

  extension ExtensionDeclSyntax: Attributed, APISyntax, Constrained, Hidable, Inheritor {

    // MARK: - APISyntax

    internal func isPublic() -> Bool {
      return true
    }

    internal var shouldLookForChildren: Bool {
      return true
    }

    internal func createAPI(children: [APIElement]) -> [APIElement] {
      guard ¬children.isEmpty else {
        return []
      }
      return [
        .extension(
          ExtensionAPI(
            type: extendedType,
            constraints: genericWhereClause,
            children: children
          )
        )
      ]
    }

    // MARK: - Hidable

    internal var hidabilityIdentifier: TokenSyntax? {
      return extendedType.hidabilityIdentifier
    }
  }
#endif
