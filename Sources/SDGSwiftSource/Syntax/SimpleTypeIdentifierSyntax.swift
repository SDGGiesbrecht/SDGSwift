/*
 SimpleTypeIdentifierSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension SimpleTypeIdentifierSyntax {

    internal func normalized() -> SimpleTypeIdentifierSyntax {

        // #workaround(SwiftSyntax 0.40200.0, Prevents invalid index use by SwiftSyntax.)
        let newGenericArgumentClause = source().contains("<") ? genericArgumentClause?.normalized() : nil

        return SyntaxFactory.makeSimpleTypeIdentifier(
            name: name.generallyNormalized(),
            genericArgumentClause: newGenericArgumentClause)
    }
}
