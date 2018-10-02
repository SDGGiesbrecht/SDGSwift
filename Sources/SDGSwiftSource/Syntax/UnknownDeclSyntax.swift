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

    // MARK: - Variable Syntax

    private var typePropertyKeyword: TokenKind? {
        for child in children {
            if let modifier = child as? DeclModifierSyntax,
                modifier.name.tokenKind == .staticKeyword ∨ modifier.name.tokenKind == .classKeyword {
                return modifier.name.tokenKind
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
                case .unknown = token.tokenKind {
                return true
            }
        }
        return false
    }

    private var isSettable: Bool {
        if (parent?.parent as? UnknownDeclSyntax)?.isProtocolSyntax == true {
            // Protocol requirement.
            var unknownCount = 0
            for child in children {
                if let token = child as? TokenSyntax,
                    case .unknown = token.tokenKind {
                    unknownCount += 1
                    if unknownCount > 1 {
                        return true
                    }
                }
            }
            return false
        } else {
            // Declaration.
            if variableKeyword?.tokenKind == .varKeyword ∨ subscriptKeyword ≠ nil,
                ¬hasReducedSetterAccessLevel,
                isStored ∨ hasSetter {
                return true
            }
            return false
        }
    }

    // MARK: - Subscript Syntax

    private var typeMethodKeyword: TokenKind? {
        return typePropertyKeyword
    }

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

    private var returnType: TypeReferenceAPI? {
        for child in children {
            if let type = child as? SimpleTypeIdentifierSyntax {
                return type.reference
            }
        }
        return nil
    }

    // MARK: - Case Syntax

    private var caseKeyword: TokenSyntax? {
        for child in children {
            if let token = child as? TokenSyntax,
                token.tokenKind == .caseKeyword {
                return token
            }
        }
        return nil
    }

    internal var isCaseSyntax: Bool {
        return caseKeyword ≠ nil
    }

    private var associatedValues: [TypeReferenceAPI] {
        for tuple in children where tuple is UnknownTypeSyntax {
            var result: [TypeReferenceAPI] = []
            for component in tuple.children where Swift.type(of: component) == Syntax.self {
                for nestingLevel in component.children {
                    for child in nestingLevel.children {
                        if let type = child as? TypeSyntax {
                            result.append(type.reference)
                        }
                    }
                }
            }
            return result
        }
        return []
    }

    internal var caseAPI: CaseAPI? {
        if let keyword = caseKeyword,
            let nameToken = (self.child(at: keyword.indexInParent + 1) as? TokenSyntax),
            ¬nameToken.text.hasPrefix("_") {
            return CaseAPI(documentation: documentation, name: nameToken.text, associatedValues: associatedValues)
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
}
