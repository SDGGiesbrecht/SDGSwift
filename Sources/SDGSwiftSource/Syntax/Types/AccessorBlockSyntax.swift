/*
 AccessorBlockSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension AccessorBlockSyntax {

    internal func normalizedForAPIDeclaration() -> AccessorBlockSyntax {
        return SyntaxFactory.makeAccessorBlock(
            leftBrace: leftBrace.generallyNormalizedAndMissingInsteadOfNil(leadingTrivia: .spaces(1), trailingTrivia: .spaces(1)),
            accessorListOrStmtList: accessorListOrStmtList.normalizedAccessorListForAPIDeclaration(),
            rightBrace: rightBrace.generallyNormalizedAndMissingInsteadOfNil(leadingTrivia: .spaces(1)))
    }
}
