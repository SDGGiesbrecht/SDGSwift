/*
 SubscriptDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension SubscriptDeclSyntax : AccessControlled, Accessor, FunctionLike, Member {

    internal var subscriptAPI: SubscriptAPI? {
        if ¬isPublic {
            return nil
        }
        return SubscriptAPI(
            documentation: documentation,
            arguments: parameters(forSubscript: true),
            returnType: result.returnType.reference,
            isSettable: isSettable)
    }

    // MARK: - Accessor

    var keyword: TokenSyntax {
        return subscriptKeyword
    }

    var accessors: AccessorBlockSyntax? {
        return accessor
    }

    // MARK: - FunctionLike

    var parameters: ParameterClauseSyntax {
        return indices
    }
}
