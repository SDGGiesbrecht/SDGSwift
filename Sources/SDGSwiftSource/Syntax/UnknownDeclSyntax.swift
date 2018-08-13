/*
 UnknownDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
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
            `switch`: switch child {
            case is MemberDeclBlockSyntax, is SyntaxCollection<DeclSyntax> :
                foundConformancesSection = true
            case is GenericWhereClauseSyntax :
                break `switch`
            case let type as SimpleTypeIdentifierSyntax :
                if foundConformancesSection {
                    if let `extension` = extensionKeyword {
                        if type.indexInParent ≠ `extension`.indexInParent + 1 {
                            result.append(type.conformance)
                        } else {
                            break search
                        }
                    } else {
                        result.append(type.conformance)
                    }
                }
            case let token as TokenSyntax :
                if token.tokenKind == .comma
                    ∨ token.tokenKind == .leftBrace
                    ∨ token.tokenKind == .rightBrace {
                    break `switch`
                } else {
                    fallthrough
                }
            default:
                if foundConformancesSection {
                    break search
                }
            }
        }
        return result
    }

    private func genericArguments(of typeName: TokenSyntax) -> ([TypeReferenceAPI], [ConstraintAPI]) {
        guard let next = child(at: typeName.indexInParent + 1),
            (next as? TokenSyntax)?.tokenKind == .leftAngle else {
                return ([], [])
        }
        var arguments: [TypeReferenceAPI] = []
        var constraints: [ConstraintAPI] = []
        var token = next
        while var next = child(at: token.indexInParent + 1),
            (next as? TokenSyntax)?.tokenKind ≠ .rightAngle {
                defer { token = next }

                if let generic = next as? TokenSyntax {
                    switch generic.tokenKind {
                    case .identifier:
                        arguments.append(TypeReferenceAPI(name: generic.text, genericArguments: []))
                    case .colon:
                        if let last = arguments.last,
                            let following = child(at: next.indexInParent + 1),
                            let conformance = following as? SimpleTypeIdentifierSyntax {
                            next = following
                            constraints.append(.conformance(last, conformance.reference))
                        }
                    default:
                        break // @exempt(from: tests) Unreachable with valid source.
                    }
                }
        }
        return (arguments, constraints)
    }

    private var constraints: [ConstraintAPI] {
        for child in children {
            if let whereClause = child as? GenericWhereClauseSyntax {
                return whereClause.constraints
            }
        }
        return []
    }

    internal var typeAPI: TypeAPI? {
        if ¬isPublic() {
            return nil
        }
        if let keyword = typeKeyword,
            let nameToken = (self.child(at: keyword.indexInParent + 1) as? TokenSyntax),
            let name = nameToken.identifierText {
            let (genericArguments, constraints) = self.genericArguments(of: nameToken)
            return TypeAPI(keyword: keyword.text, name: TypeReferenceAPI(name: name, genericArguments: genericArguments), conformances: conformances, constraints: constraints + self.constraints, children: apiChildren())
        }
        return nil // @exempt(from: tests) Theoretically unreachable.
    }

    // MARK: - Type Alias Syntax

    private var typeAliasKeyword: TokenSyntax? {
        for child in children {
            if let token = child as? TokenSyntax,
                token.tokenKind == .typealiasKeyword {
                return token
            }
        }
        return nil
    }

    internal var isTypeAliasSyntax: Bool {
        return typeAliasKeyword ≠ nil
    }

    internal var typeAliasAPI: TypeAPI? {
        if ¬isPublic() {
            return nil
        }
        if let keyword = typeAliasKeyword,
            let nameToken = (self.child(at: keyword.indexInParent + 1) as? TokenSyntax),
            let name = nameToken.identifierText {
            return TypeAPI(keyword: keyword.text, name: TypeReferenceAPI(name: name, genericArguments: []), conformances: [], constraints: [], children: [])
        }
        return nil // @exempt(from: tests) Theoretically unreachable.
    }

    // MARK: - Associated Type Syntax

    private var associatedTypeKeyword: TokenSyntax? {
        for child in children {
            if let token = child as? TokenSyntax,
                token.tokenKind == .associatedtypeKeyword {
                return token
            }
        }
        return nil
    }

    internal var isAssociatedTypeSyntax: Bool {
        return associatedTypeKeyword ≠ nil
    }

    internal var associatedTypeAPI: TypeAPI? {
        if let keyword = associatedTypeKeyword,
            let nameToken = (self.child(at: keyword.indexInParent + 1) as? TokenSyntax),
            let name = nameToken.identifierText {
            return TypeAPI(keyword: keyword.text, name: TypeReferenceAPI(name: name, genericArguments: []), conformances: conformances, constraints: constraints + self.constraints, children: [])
        }
        return nil // @exempt(from: tests) Theoretically unreachable.
    }

    // MARK: - Protocol Syntax

    private var protocolKeyword: TokenSyntax? {
        for child in children {
            if let token = child as? TokenSyntax,
                token.tokenKind == .protocolKeyword {
                return token
            }
        }
        return nil
    }

    internal var isProtocolSyntax: Bool {
        return protocolKeyword ≠ nil
    }

    internal var protocolAPI: ProtocolAPI? {
        if ¬isPublic() {
            return nil
        }
        if let keyword = protocolKeyword,
            let nameToken = (self.child(at: keyword.indexInParent + 1) as? TokenSyntax),
            let name = nameToken.identifierText {
            return ProtocolAPI(name: name, conformances: conformances, constraints: constraints + self.constraints, children: apiChildren())
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

    private var typePropertyKeyword: String? {
        for child in children {
            if let modifier = child as? DeclModifierSyntax,
                modifier.name.tokenKind == .staticKeyword ∨ modifier.name.tokenKind == .classKeyword {
                return modifier.name.text
            }
        }
        return nil
    }

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
            return VariableAPI(typePropertyKeyword: typePropertyKeyword, name: name, type: type, isSettable: isSettable)
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
            let possibleArgumentList = child.argumentListAPI(forSubscript: forSubscript)
            if ¬possibleArgumentList.isEmpty {
                return possibleArgumentList
            }
        }
        return []
    }

    private var returnType: TypeReferenceAPI? {
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
            let conformances = self.conformances
            if ¬children.isEmpty ∨ ¬conformances.isEmpty {
                return ExtensionAPI(type: type.reference, conformances: conformances, constraints: constraints, children: children)
            }
        } // @exempt(from: tests) Theoretically unreachable.
        return nil
    }
}
