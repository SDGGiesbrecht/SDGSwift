/*
 EnumCaseElementSyntax.swift

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

  extension EnumCaseElementSyntax: Hidable {

    internal func normalizedForAPIDeclaration() -> EnumCaseElementSyntax {
      return SyntaxFactory.makeEnumCaseElement(
        identifier: identifier.generallyNormalizedAndMissingInsteadOfNil(),
        associatedValue: associatedValue?.normalizedForAssociatedValue(),
        rawValue: nil,
        trailingComma: nil
      )
    }

    internal func forName() -> EnumCaseElementSyntax {
      return SyntaxFactory.makeEnumCaseElement(
        identifier: identifier,
        associatedValue: associatedValue?.forAssociatedValueName(),
        rawValue: nil,
        trailingComma: nil
      )
    }

    // MARK: - Hidable

    internal var hidabilityIdentifier: TokenSyntax? {
      return identifier
    }
  }
#endif
