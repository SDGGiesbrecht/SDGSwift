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

    // MARK: - Type Syntax

    private var typeKeyword: TokenSyntax? {
        for child in children {
            if let token = child as? TokenSyntax,
                token.tokenKind == .structKeyword ∨ token.tokenKind == .classKeyword ∨ token.tokenKind == .enumKeyword {
                return token
            }
        }
        return nil
    }

    internal var isTypeSyntax: Bool {
        return typeKeyword ≠ nil
    }

    internal var typeAPI: TypeAPI? {
        if ¬isPublic() {
            return nil
        }
        if let keyword = typeKeyword,
            let nameToken = (self.child(at: keyword.indexInParent + 1) as? TokenSyntax),
            let name = nameToken.identifierText {
            return TypeAPI(keyword: keyword.text, name: name, conformances: [], children: apiChildren())
        }
        return nil // @exempt(from: tests) Theoretically unreachable.
    }

    // MARK: - Initializer Syntax

    private var initializerKeyword: TokenSyntax? {
        for child in children {
            if let token = child as? TokenSyntax,
                token.tokenKind == .initKeyword {
                return token
            }
        }
        return nil
    }

    internal var isInitializerSyntax: Bool {
        return initializerKeyword ≠ nil
    }

    internal var initializerAPI: InitializerAPI? {
        // @warning(Does not handle failable initializers.
        if ¬isPublic() {
            return nil
        }
        if initializerKeyword ≠ nil {
            let `throws` = children.contains(where: { ($0 as? TokenSyntax)?.tokenKind == .throwsKeyword })
            return InitializerAPI(isFailable: false, arguments: arguments(forSubscript: false), throws: `throws`)
        }
        return nil // @exempt(from: tests) Theoretically unreachable.
    }

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

    private var hasReducedSetterAccessLevel: Bool {
        for child in children {
            if let modifier = child as? DeclModifierSyntax {
                switch modifier.name.tokenKind {
                case .privateKeyword, .fileprivateKeyword, .internalKeyword:
                    return true // Reduced setter access level.
                default:
                    break
                }
            }
        }
        return false
    }

    private var isStored: Bool {
        for child in children {
            if let token = child as? TokenSyntax,
                token.tokenKind == .leftBrace {
                return false
            }
        }
        return true // @exempt(from: tests) Theoretically unreachable.
    }

    private var hasSetter: Bool {
        for child in children {
            if let token = child as? TokenSyntax,
                token.tokenKind == .unknown {
                return true
            }
        }
        return false
    }

    private var isSettable: Bool {
        if variableKeyword?.tokenKind == .varKeyword ∨ subscriptKeyword ≠ nil,
            ¬hasReducedSetterAccessLevel,
            isStored ∨ hasSetter {
            return true
        }
        return false
    }

    internal var variableAPI: VariableAPI? {
        if ¬isPublic() {
            return nil
        }
        if let keyword = variableKeyword,
            let nameToken = (self.child(at: keyword.indexInParent + 1) as? TokenSyntax),
            let name = nameToken.identifierText {
            let typeName = (child(at: nameToken.indexInParent + 2) as? SimpleTypeIdentifierSyntax)?.name.text
            return VariableAPI(name: name, type: typeName, isSettable: isSettable)
        }
        return nil // @exempt(from: tests) Theoretically unreachable.
    }

    // MARK: - Variable Syntax

    private var subscriptKeyword: TokenSyntax? {
        for child in children {
            if let token = child as? TokenSyntax,
                token.tokenKind == .subscriptKeyword {
                return token
            }
        }
        return nil
    }

    internal var isSubscriptSyntax: Bool {
        return subscriptKeyword ≠ nil
    }

    internal var subscriptAPI: SubscriptAPI? {
        print(#function)
        if ¬isPublic() {
            return nil
        }
        if isSubscriptSyntax,
            let returnType = self.returnType {
            return SubscriptAPI(arguments: arguments(forSubscript: true), returnType: returnType, isSettable: isSettable)
        }
        return nil // @exempt(from: tests) Theoretically unreachable.
    }

    // MARK: - Function Syntax

    private var functionKeyword: TokenSyntax? {
        for child in children {
            if let token = child as? TokenSyntax,
                token.tokenKind == .funcKeyword {
                return token
            }
        }
        return nil
    }

    internal var isFunctionSyntax: Bool {
        return functionKeyword ≠ nil
    }

    private func arguments(forSubscript: Bool) -> [ArgumentAPI] {
        for child in children where type(of: child) == Syntax.self {
            return child.argumentListAPI(forSubscript: forSubscript)
        }
        return []
    }

    private var returnType: String? {
        for child in children {
            if let type = child as? SimpleTypeIdentifierSyntax {
                return type.name.text
            }
        }
        return nil
    }

    internal var functionAPI: FunctionAPI? {
        if ¬isPublic() {
            return nil
        }
        if let keyword = functionKeyword,
            let name = (child(at: keyword.indexInParent + 1) as? TokenSyntax)?.identifierText {
            let `throws` = children.contains(where: { ($0 as? TokenSyntax)?.tokenKind == .throwsKeyword })
            return FunctionAPI(name: name, arguments: arguments(forSubscript: false), throws: `throws`, returnType: returnType)
        }
        return nil // @exempt(from: tests) Theoretically unreachable.
    }

    // MARK: - Extension Syntax

    private var extensionKeyword: TokenSyntax? {
        for child in children {
            if let token = child as? TokenSyntax,
                token.tokenKind == .extensionKeyword {
                return token
            }
        }
        return nil
    }

    internal var isExtensionSyntax: Bool {
        return extensionKeyword ≠ nil
    }

    internal var extensionAPI: ExtensionAPI? {
        // @warning(Does not handle conformances yet.)
        if let keyword = extensionKeyword,
            let type = child(at: keyword.indexInParent + 1) as? SimpleTypeIdentifierSyntax {
            let children = apiChildren()
            if ¬children.isEmpty {
                return ExtensionAPI(type: type.name.text, conformances: [], children: children)
            }
        } // @exempt(from: tests) Theoretically unreachable.
        return nil
    }
}
