/*
 MemberTypeIdentifierSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax

  extension MemberTypeIdentifierSyntax {

    // MARK: - Merging

    internal func rootType() -> TypeSyntax {
      guard let member = baseType.as(MemberTypeIdentifierSyntax.self) else {
        return baseType
      }
      return member.rootType()
    }

    internal func strippingRootType() -> TypeSyntax {
      guard let member = baseType.as(MemberTypeIdentifierSyntax.self) else {
        return TypeSyntax(
          SyntaxFactory.makeSimpleTypeIdentifier(
            name: name,
            genericArgumentClause: genericArgumentClause
          )
        )
      }

      return TypeSyntax(withBaseType(member.strippingRootType()))
    }
  }
#endif
