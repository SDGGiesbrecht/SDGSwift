/*
 MemberTypeIdentifierSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

extension MemberTypeIdentifierSyntax {

    // MARK: - Normalization

    internal func normalized() -> TypeSyntax {

        let newName = self.name.generallyNormalizedAndMissingInsteadOfNil()
        let newGenericArgumentClause = genericArgumentClause?.normalized()

        if let simple = baseType as? SimpleTypeIdentifierSyntax,
            simple.name.tokenKind == .capitalSelfKeyword {
            return SyntaxFactory.makeSimpleTypeIdentifier(
                name: newName,
                genericArgumentClause: newGenericArgumentClause)
        } else {
            return SyntaxFactory.makeMemberTypeIdentifier(
                baseType: baseType.normalized(),
                period: period.generallyNormalizedAndMissingInsteadOfNil(),
                name: newName,
                genericArgumentClause: newGenericArgumentClause)
        }
    }

    // MARK: - Merging

    internal func rootType() -> TypeSyntax {
        guard let member = baseType as? MemberTypeIdentifierSyntax else {
            return baseType
        }
        return member.rootType()
    }

    internal func strippingRootType() -> TypeSyntax {
        guard let member = baseType as? MemberTypeIdentifierSyntax else {
            return SyntaxFactory.makeSimpleTypeIdentifier(
                name: name,
                genericArgumentClause: genericArgumentClause)
        }

        return withBaseType(member.strippingRootType())
    }
}
