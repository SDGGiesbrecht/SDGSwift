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

    private var conformances: [ConformanceAPI] {
        var result: [ConformanceAPI] = []
        var foundConformancesSection = false
        search: for child in children.reversed() {
            switch child {
            case is MemberDeclBlockSyntax :
                foundConformancesSection = true
            case let type as SimpleTypeIdentifierSyntax :
                if foundConformancesSection {
                    result.append(ConformanceAPI(protocolName: type.name.text))
                }
            default:
                if foundConformancesSection {
                    break search
                }
            }
        }
        return result
    }

    private func genericArguments(of typeName: TokenSyntax) -> [TypeReference] {
        guard let next = child(at: typeName.indexInParent + 1),
            (next as? TokenSyntax)?.tokenKind == .leftAngle else {
                return []
        }
        var arguments: [TypeReference] = []
        var token = next
        while let next = child(at: token.indexInParent + 1),
            (next as? TokenSyntax)?.tokenKind ≠ .rightAngle {
            defer { token = next }

            if let generic = next as? TokenSyntax,
                case .identifier = generic.tokenKind {
                arguments.append(TypeReference(name: generic.text, genericArguments: []))
            }
        }
        return arguments
    }

    internal var typeAPI: TypeAPI? {
        if ¬isPublic() {
            return nil
        }
        if let keyword = typeKeyword,
            let nameToken = (self.child(at: keyword.indexInParent + 1) as? TokenSyntax),
            let name = nameToken.identifierText {
            return TypeAPI(keyword: keyword.text, name: TypeReference(name: name, genericArguments: genericArguments(of: nameToken)), conformances: conformances, children: apiChildren())
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
        if ¬isPublic() {
            return nil
        }
        if let keyword = initializerKeyword {
            let `throws` = children.contains(where: { ($0 as? TokenSyntax)?.tokenKind == .throwsKeyword })
            let isFailable = (child(at: keyword.indexInParent + 1) as? TokenSyntax)?.tokenKind == .postfixQuestionMark
            return InitializerAPI(isFailable: isFailable, arguments: arguments(forSubscript: false), throws: `throws`)
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
            let type = (child(at: nameToken.indexInParent + 2) as? SimpleTypeIdentifierSyntax)?.reference
            return VariableAPI(name: name, type: type, isSettable: isSettable)
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

    private var returnType: TypeReference? {
        for child in children {
            if let type = child as? SimpleTypeIdentifierSyntax {
                return type.reference
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
            let isMutating = children.contains(where: { ($0 as? DeclModifierSyntax)?.name.identifierText == "mutating" })
            let `throws` = children.contains(where: { ($0 as? TokenSyntax)?.tokenKind == .throwsKeyword })
            return FunctionAPI(isMutating: isMutating, name: name, arguments: arguments(forSubscript: false), throws: `throws`, returnType: returnType)
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
        if let keyword = extensionKeyword,
            let type = child(at: keyword.indexInParent + 1) as? SimpleTypeIdentifierSyntax {
            let children = apiChildren()
            if ¬children.isEmpty {
                return ExtensionAPI(type: type.reference, conformances: conformances, children: children)
            }
        } // @exempt(from: tests) Theoretically unreachable.
        return nil
    }
}
