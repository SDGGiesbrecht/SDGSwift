/*
 InfixOperatorGroupSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension InfixOperatorGroupSyntax {

    internal func normalizedForAPIDeclaration() -> InfixOperatorGroupSyntax {
        return SyntaxFactory.makeInfixOperatorGroup(
            colon: colon.generallyNormalizedAndMissingInsteadOfNil(leadingTrivia: .spaces(1), trailingTrivia: .spaces(1)),
            precedenceGroupName: precedenceGroupName.generallyNormalizedAndMissingInsteadOfNil())
    }
}
