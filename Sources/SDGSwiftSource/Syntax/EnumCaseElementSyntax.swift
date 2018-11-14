/*
 EnumCaseElementSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension EnumCaseElementSyntax {

    internal func normalizedForAPIDeclaration() -> EnumCaseElementSyntax {
        return SyntaxFactory.makeEnumCaseElement(
            identifier: identifier.generallyNormalized(),
            associatedValue: associatedValue?.normalizedForAssociatedValue(),
            rawValue: nil,
            trailingComma: nil)
    }

    internal func forName() -> EnumCaseElementSyntax {
        return SyntaxFactory.makeEnumCaseElement(
            identifier: identifier,
            associatedValue: associatedValue?.forAssociatedValueName(),
            rawValue: nil,
            trailingComma: nil)
    }
}
