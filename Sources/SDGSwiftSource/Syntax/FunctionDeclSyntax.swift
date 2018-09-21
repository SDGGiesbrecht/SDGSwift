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

    internal var functionAPI: FunctionAPI? {
        if ¬isPublic {
            return nil
        }
        return FunctionAPI(
            documentation: documentation,
            isOpen: isOpen,
            typeMethodKeyword: typeMemberKeyword,
            isMutating: modifiers?.contains(where: { $0.name.text == "mutating" }) == true,
            name: identifier.text,
            arguments: parameters(forSubscript: false),
            throws: signature.throwsOrRethrowsKeyword ≠ nil,
            returnType: signature.output?.returnType.reference,
            isOperator: identifier.isOperator)
    }

    // MARK: - FunctionLike

    internal var parameters: ParameterClauseSyntax {
        return signature.input
    }
}
