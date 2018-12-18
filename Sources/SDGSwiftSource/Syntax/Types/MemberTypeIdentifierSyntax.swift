/*
 MemberTypeIdentifierSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension MemberTypeIdentifierSyntax {

    internal func normalized() -> TypeSyntax {

        let newName = self.name.generallyNormalizedAndMissingInsteadOfNil()
        // #workaround(SwiftSyntax 0.40200.0, Prevents invalid index use by SwiftSyntax.)
        let newGenericArgumentClause = source().contains("<") ? genericArgumentClause?.normalized() : nil

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
}
