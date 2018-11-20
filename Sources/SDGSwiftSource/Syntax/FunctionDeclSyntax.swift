/*
 FunctionDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension FunctionDeclSyntax : AccessControlled, FunctionLike, Member {

    internal func functionAPI() -> [FunctionAPI] {
        if ¬isPublic {
            return []
        }
        let name = identifier.text
        if name.hasPrefix("_") {
            return []
        }
        return [FunctionAPI(documentation: documentation, declaration: self)]
    }

    internal func normalizedAPIDeclaration() -> FunctionDeclSyntax {

    }

    internal func overloadPattern() -> FunctionDeclSyntax {

    }

    internal func name() -> FunctionDeclSyntax {

    }

    internal func identifierList() -> Set<String> {

    }

    // MARK: - FunctionLike

    internal var parameters: ParameterClauseSyntax {
        return signature.input
    }
}
