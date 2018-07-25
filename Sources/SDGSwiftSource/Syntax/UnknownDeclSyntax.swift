/*
 UnknownDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension UnknownDeclSyntax {

    // MARK: - Variable Syntax

    private var variableKeyword: TokenSyntax? {
        for child in children {
            if let token = child as? TokenSyntax,
                token.tokenKind == .varKeyword ∨ token.tokenKind == .letKeyword {
                return token
            }
        }
        return nil
    }

    internal var isVariableSyntax: Bool {
        return variableKeyword ≠ nil
    }

    internal var variableAPI: VariableAPI? {
        if ¬isPublic() {
            return nil
        }
        if let keyword = variableKeyword,
            let nameToken = (self.child(at: keyword.indexInParent + 1) as? TokenSyntax),
            let name = nameToken.identifierText {

            let typeName = (child(at: nameToken.indexInParent + 2) as? SimpleTypeIdentifierSyntax)?.name.text
            var isSettable = false
            if keyword.tokenKind == .varKeyword {
                if ¬children.contains(where: { node in
                    if let modifier = node as? DeclModifierSyntax {
                        switch modifier.name.tokenKind {
                        case .privateKeyword, .fileprivateKeyword, .internalKeyword:
                            return true // Reduced setter access level.
                        default:
                            break
                        }
                    }
                    return false
                }) {
                    // No setter access reduction.

                    if children.contains(where: { node in
                        if let token = node as? TokenSyntax {
                            switch token.tokenKind {
                            case .unknown, // “set”
                            .equal: // Stored property, not computed.
                                return true
                            default:
                                break
                            }
                        }
                        return false
                    }) {
                        isSettable = true
                    }
                }
            }
            return VariableAPI(name: name, type: typeName, isSettable: isSettable)
        }
        return nil
    }
}
