/*
 VariableDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension VariableDeclSyntax : AccessControlled, Accessor, Member {

    internal var variableAPI: VariableAPI? {
        if ¬isPublic {
            return nil
        }
        guard let binding = bindings.first,
            let name = (binding.pattern as? IdentifierPatternSyntax)?.identifier.text else {
                return nil // @exempt(from: tests) Unreachable with valid source.
        }
        if name.hasPrefix("_") {
            return nil
        }
        return VariableAPI(
            documentation: documentation,
            typePropertyKeyword: typeMemberKeyword,
            name: name,
            type: binding.typeAnnotation?.type.reference,
            isSettable: isSettable)
    }

    // MARK: - Accessor

    var keyword: TokenSyntax {
        return letOrVarKeyword
    }

    var accessors: AccessorBlockSyntax? {
        return bindings.first?.accessor
    }
}
