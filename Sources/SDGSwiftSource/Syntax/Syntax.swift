/*
 Syntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic
import SDGMathematics
import SDGCollections
import SDGText
import SDGPersistence
import SDGLocalization

extension Syntax {

    // MARK: - Properties

    public func source() -> String {
        var result = ""
        write(to: &result)
        return result
    }

    internal func withTriviaReducedToSpaces() -> Syntax {
        return TriviaNormalizer().visit(self)
    }

    public func location(in source: String) -> Range<String.ScalarView.Index> {
        let start: String.ScalarView.Index
        if let parent = self.parent {
            var position = parent.location(in: source).lowerBound
            for index in 0 ..< indexInParent {
                if let sibling = parent.child(at: index) {
                    position = source.scalars.index(position, offsetBy: sibling.source().scalars.count)
                }
            }
            start = position
        } else {
            start = source.scalars.startIndex
        }
        return start ..< source.scalars.index(start, offsetBy: self.source().scalars.count)
    }

    public func ancestors() -> AnySequence<Syntax> {
        if let parent = self.parent {
            return AnySequence(sequence(first: parent, next: { $0.parent }))
        } else {
            return AnySequence([])
        }
    }

    // MARK: - Syntax Highlighting

    public func syntaxHighlightedHTML(inline: Bool, internalIdentifiers: Set<String> = [], symbolLinks: [String: String] = [:]) -> String {
        return SyntaxHighlighter.frame(highlightedSyntax: nestedSyntaxHighlightedHTML(internalIdentifiers: internalIdentifiers, symbolLinks: symbolLinks), inline: inline)
    }

    internal func nestedSyntaxHighlightedHTML(internalIdentifiers: Set<String>, symbolLinks: [String: String]) -> String {
        switch self {
        case let token as TokenSyntax :
            var result = token.leadingTrivia.nestedSyntaxHighlightedHTML(internalIdentifiers: internalIdentifiers, symbolLinks: symbolLinks)

            if let extended = token.extended {
                result = extended.nestedSyntaxHighlightedHTML(internalIdentifiers: internalIdentifiers, symbolLinks: symbolLinks)
            } else {
                var source = HTML.escape(token.text)
                if let `class` = token.syntaxHighlightingClass(internalIdentifiers: internalIdentifiers) {
                    source.prepend(contentsOf: "<span class=\u{22}\(`class`)\u{22}>")
                    source.append(contentsOf: "</span>")
                }
                if let url = symbolLinks[token.text] {
                    source.prepend(contentsOf: "<a href=\u{22}\(url)\u{22}>")
                    source.append(contentsOf: "</a>")
                }
                result += source
            }

            result += token.trailingTrivia.nestedSyntaxHighlightedHTML(internalIdentifiers: internalIdentifiers, symbolLinks: symbolLinks)
            return result
        default:
            var identifiers = internalIdentifiers
            switch self {
            case let function as FunctionDeclSyntax :
                let parameters = function.signature.input.parameterList.map({ $0.secondName?.identifierText }).compactMap({ $0 })
                identifiers ∪= Set(parameters)
            default:
                break
            }
            return children.map({ $0.nestedSyntaxHighlightedHTML(internalIdentifiers: identifiers, symbolLinks: symbolLinks) }).joined()
        }
    }

    // MARK: - API

    internal func apiChildren() -> [APIElement] {
        let elements = Array(children.map({ $0.api() }).joined())
        return APIElement.merge(elements: elements)
    }

    internal func _isPublic() -> Bool {

        let hasPublicKeyword = children.contains(where: { node in
            if let modifier = node as? DeclModifierSyntax,
                modifier.name.tokenKind == .publicKeyword ∨ modifier.name.text == "open" {
                return true
            }
            return false
        })

        if hasPublicKeyword {
            return true
        } else {
            return ancestors().contains(where: { ($0 as? UnknownDeclSyntax)?.isProtocolSyntax == true })
        }
    }

    internal func _isOpen() -> Bool {
        return children.contains(where: { node in
            if let modifier = node as? DeclModifierSyntax,
                modifier.name.text == "open" {
                return true
            }
            return false
        })
    }

    // @documentation(SDGSwiftSource.Syntax.api())
    /// Returns the API provided by this node.
    public func api() -> [APIElement] {
        if isConditionalCompilation { // UnknownStmtSyntax or UnknownDeclSyntax
            return conditionallyCompiledChildren
        }
        switch self {
        case let structure as StructDeclSyntax :
            return structure.typeAPI.flatMap({ [$0] }) ?? []
        case let enumeration as EnumDeclSyntax :
            return enumeration.typeAPI.flatMap({ [$0] }) ?? []
        case let typeAlias as TypealiasDeclSyntax :
            return typeAlias.typeAPI.flatMap({ [$0] }) ?? []
        case let associatedType as AssociatedtypeDeclSyntax :
            return associatedType.typeAPI.flatMap({ [$0] }) ?? []
        case let `protocol` as ProtocolDeclSyntax :
            return `protocol`.protocolAPI.flatMap({ [$0] }) ?? []
        case let `case` as EnumCaseDeclSyntax :
            return `case`.caseAPI.flatMap({ [$0] }) ?? []
        case let initializer as InitializerDeclSyntax :
            return initializer.initializerAPI.flatMap({ [$0] }) ?? []
        case let variable as VariableDeclSyntax :
            return variable.variableAPI.flatMap({ [$0] }) ?? []
        case let `subscript` as SubscriptDeclSyntax :
            return `subscript`.subscriptAPI.flatMap({ [$0] }) ?? []
        case let function as FunctionDeclSyntax :
            return function.functionAPI.flatMap({ [$0] }) ?? []
        case let `extension` as ExtensionDeclSyntax :
            return `extension`.extensionAPI.flatMap({ [$0] }) ?? []
        case let conditionallyCompiledSection as IfConfigDeclSyntax :
            return conditionallyCompiledSection.conditionalAPI
        case let unknown as UnknownDeclSyntax :
            if unknown.isTypeSyntax {
                return unknown.typeAPI.flatMap({ [$0] }) ?? []
            } else if unknown.isTypeAliasSyntax {
                return unknown.typeAliasAPI.flatMap({ [$0] }) ?? []
            } else if unknown.isAssociatedTypeSyntax {
                return unknown.associatedTypeAPI.flatMap({ [$0] }) ?? []
            } else if unknown.isProtocolSyntax {
                return unknown.protocolAPI.flatMap({ [$0] }) ?? []
            } else if unknown.isInitializerSyntax {
                return unknown.initializerAPI.flatMap({ [$0] }) ?? []
            } else if unknown.isVariableSyntax {
                return unknown.variableAPI.flatMap({ [$0] }) ?? []
            } else if unknown.isSubscriptSyntax {
                return unknown.subscriptAPI.flatMap({ [$0] }) ?? []
            } else if unknown.isFunctionSyntax {
                return unknown.functionAPI.flatMap({ [$0] }) ?? []
            } else if unknown.isCaseSyntax {
                return unknown.caseAPI.flatMap({[$0]}) ?? []
            } else if unknown.isExtensionSyntax {
                return unknown.extensionAPI.flatMap({ [$0] }) ?? []
            } else {
                return apiChildren()
            }
        default:
            return apiChildren()
        }
    }

    internal var firstToken: TokenSyntax? {
        if let token = self as? TokenSyntax {
            return token
        } else {
            return children.first(where: { _ in true })?.firstToken
        }
    }

    internal var documentation: DocumentationSyntax? {
        if let token = firstToken {
            let leading = token.leadingTrivia
            for index in leading.indices.lazy.reversed() {
                let trivia = leading[index]
                switch trivia {
                case .docLineComment, .docBlockComment:
                    let comment = trivia.syntax(siblings: leading, index: index)
                    if let line = comment as? LineDocumentationSyntax {
                        return line.content.context as? DocumentationSyntax
                    } else if let block = comment as? BlockDocumentationSyntax {
                        return block.content.first as? DocumentationSyntax
                    }
                default:
                    continue
                }
            }
        }
        return nil
    }

    internal func smallestSubnode(containing searchTerm: String) -> Syntax? {
        guard source().contains(searchTerm) else {
            return nil
        }
        for child in children {
            if let found = child.smallestSubnode(containing: searchTerm) {
                return found
            }
        }
        return self
    }

    // MARK: - Argument List API

    internal func argumentListAPI(forSubscript: Bool) -> [ParameterAPI] {
        var arguments: [ParameterAPI] = []
        for child in children {
            if let argument = child.parameterAPI(forSubscript: forSubscript) {
                arguments.append(argument)
            }
        }
        return arguments
    }

    // MARK: - Argument API

    private var possibleArgumentLabel: TokenSyntax? {
        for child in children {
            if let token = child as? TokenSyntax,
                token.identifierText ≠ nil {
                return token
            }
        }
        return nil // @exempt(from: tests) Theoretically unreachable.
    }

    private var argumentType: TypeReferenceAPI? {
        for child in children {
            if let type = child as? TypeSyntax {
                return type.reference
            }
        }
        return nil // @exempt(from: tests) Theoretically unreachable.
    }

    private var isInOut: Bool {
        if let unknownType = children.first(where: ({ $0 is UnknownTypeSyntax })),
            let type = unknownType as? UnknownTypeSyntax,
            type.children.contains(where: { ($0 as? TokenSyntax)?.tokenKind == .inoutKeyword }) {
            return true
        }
        return false
    }

    private var hasDefault: Bool {
        return children.contains(where: { ($0 as? TokenSyntax)?.tokenKind == .equal })
    }

    private func parameterAPI(forSubscript: Bool) -> ParameterAPI? {
        if let possibleLabelSyntax = possibleArgumentLabel,
            let possibleLabel: String = possibleLabelSyntax.identifierText,
            let type = argumentType {
            var label: String? = possibleLabel

            var name: String
            if let differentName = (child(at: possibleLabelSyntax.indexInParent + 1) as? TokenSyntax)?.identifierText {
                name = differentName
            } else {
                name = possibleLabel
                if forSubscript {
                    label = nil
                }
            }

            if (child(at: possibleLabelSyntax.indexInParent − 1) as? TokenSyntax)?.tokenKind == .wildcardKeyword {
                label = nil
            }

            return ParameterAPI(label: label, name: name, isInOut: isInOut, type: type, hasDefault: hasDefault)
        }
        return nil // @exempt(from: tests) Theoretically unreachable.
    }

    // MARK: - Compilation Conditions

    private var compilerIfKeyword: TokenSyntax? {
        if let statement = children.first(where: { _ in true }) as? UnknownSyntax,
            let token = statement.children.first(where: { _ in true }) as? TokenSyntax,
            token.tokenKind == .poundIfKeyword {
            return token
        }
        return nil
    }

    internal var isConditionalCompilation: Bool {
        return compilerIfKeyword ≠ nil
    }

    internal var conditionallyCompiledChildren: [APIElement] {
        return (try? SyntaxTreeParser.parse(source()).apiChildren()) ?? []
        var previousConditions: [Syntax] = []
        var currentCondition: Syntax? = nil
        var universalSet: Set<APIElement> = []
        var filledUniversalSet: Bool = false
        var elseOccurred: Bool = false
        var currentSet: Set<APIElement> = []
        var api: [APIElement] = []
        for child in children {
            switch child {
            case let token as TokenSyntax : // “#if”, “#elseif” or “#else”
                switch token.tokenKind {
                case .poundElseKeyword:
                    elseOccurred = true
                    fallthrough
                case .poundElseifKeyword:
                    defer { filledUniversalSet = true }
                    if let current = currentCondition {
                        previousConditions.append(current)
                        currentCondition = nil
                    }
                    if ¬filledUniversalSet {
                        universalSet = currentSet
                    } else {
                        universalSet ∩= currentSet
                    }
                    currentSet = []
                default:
                    break
                }
            case let condition as UnknownExprSyntax :
                let tokens = condition.withTriviaReducedToSpaces().tokens()
                currentCondition = SyntaxFactory.makeUnknownSyntax(tokens: tokens)
            case let condition as IdentifierExprSyntax :
                let tokens = condition.withTriviaReducedToSpaces().tokens()
                currentCondition = SyntaxFactory.makeUnknownSyntax(tokens: tokens)
            case let condition as SequenceExprSyntax :
                let tokens = condition.withTriviaReducedToSpaces().tokens()
                currentCondition = SyntaxFactory.makeUnknownSyntax(tokens: tokens)
            default:
                var composedConditions: [TokenSyntax] = [SyntaxFactory.makeToken(.poundIfKeyword, trailingTrivia: .spaces(1))]

                composedConditions.append(contentsOf: previousConditions.map({ [
                    SyntaxFactory.makeToken(.prefixOperator("!")),
                    SyntaxFactory.makeToken(.leftParen)
                    ] + $0.tokens() + [
                        SyntaxFactory.makeToken(.rightParen)
                    ]
                }).joined(separator: [
                    SyntaxFactory.makeToken(.spacedBinaryOperator("\u{26}&"), leadingTrivia: .spaces(1), trailingTrivia: .spaces(1))
                    ]))

                if previousConditions.isEmpty {
                    composedConditions.append(contentsOf: (currentCondition?.tokens() ?? [])) // @exempt(from: tests) Never nil in valid source.
                } else {
                    if let current = currentCondition {
                        composedConditions.append(contentsOf: [
                            SyntaxFactory.makeToken(.spacedBinaryOperator("\u{26}&"), leadingTrivia: .spaces(1), trailingTrivia: .spaces(1)),
                            SyntaxFactory.makeToken(.leftParen)
                            ] + current.tokens() + [
                                SyntaxFactory.makeToken(.rightParen)
                            ])
                    }
                }
                for element in child.api() {
                    currentSet.insert(element)
                    element.prependCompilationCondition(SyntaxFactory.makeUnknownSyntax(tokens: composedConditions))
                    api.append(element)
                }
            }
        }
        if elseOccurred {
            for element in universalSet {
                element.compilationConditions = nil
                api = api.filter({ $0 ≠ element })
                api.append(element)
            }
        }
        return api
    }

    // MARK: - Disection

    internal func tokens() -> [TokenSyntax] {
        var tokens: [TokenSyntax] = []
        for child in children {
            if let token = child as? TokenSyntax {
                tokens.append(token)
            } else {
                tokens.append(contentsOf: child.tokens())
            }
        }
        return tokens
    }
}
