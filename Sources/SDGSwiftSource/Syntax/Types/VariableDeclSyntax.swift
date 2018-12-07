/*
 VariableDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic

extension VariableDeclSyntax : AccessControlled, Accessor, Attributed, Member {

    internal func variableAPI() -> [VariableAPI] {
        if ¬isPublic ∨ isUnavailable() {
            return []
        }

        var list: [VariableAPI] = []
        for binding in bindings {
            switch binding.pattern {
            case let identifier as IdentifierPatternSyntax :
                if ¬identifier.identifier.text.hasPrefix("_") {
                    list.append(VariableAPI(
                        documentation: list.isEmpty ? documentation : nil, // The documentation only applies to the first.
                        declaration: SyntaxFactory.makeVariableDecl(
                            attributes: attributes,
                            modifiers: modifiers,
                            letOrVarKeyword: letOrVarKeyword,
                            bindings: SyntaxFactory.makePatternBindingList([binding]))))
                }
            default: // @exempt(from: tests) Should never occur.
                if BuildConfiguration.current == .debug { // @exempt(from: tests)
                    print("Unidentified binding pattern: \(Swift.type(of: binding))")
                }
            }
        }
        return list
    }

    internal func normalizedAPIDeclaration() -> VariableDeclSyntax {
        return SyntaxFactory.makeVariableDecl(
            attributes: attributes?.normalizedForAPIDeclaration(),
            modifiers: modifiers?.normalizedForAPIDeclaration(operatorFunction: false),
            letOrVarKeyword: SyntaxFactory.makeToken(.varKeyword, trailingTrivia: .spaces(1)),
            bindings: bindings.normalizedForVariableAPIDeclaration(accessor: accessorListForAPIDeclaration()))
    }

    internal func name() -> VariableDeclSyntax {
        return SyntaxFactory.makeVariableDecl(
            attributes: nil,
            modifiers: nil,
            letOrVarKeyword: SyntaxFactory.makeToken(.varKeyword, presence: .missing),
            bindings: bindings.forVariableName())
    }

    // MARK: - Accessor

    var keyword: TokenSyntax {
        return letOrVarKeyword
    }

    var accessors: AccessorBlockSyntax? {
        return bindings.first?.accessor
    }
}
