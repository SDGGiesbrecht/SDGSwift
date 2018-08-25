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

extension Syntax {

    // MARK: - Parsing

    public static func parse(_ source: String) throws -> SourceFileSyntax {
        let temporary = FileManager.default.url(in: .temporary, at: UUID().uuidString + ".swift")
        try? FileManager.default.removeItem(at: temporary)

        try source.save(to: temporary)
        defer { try? FileManager.default.removeItem(at: temporary) }

        return try Syntax.parse(temporary)
    }

    // MARK: - Properties

    public func source() -> String {
        var result = ""
        write(to: &result)
        return result
    }

    internal func withTriviaReducedToSpaces() -> Syntax {
        class TriviaNormalizer : SyntaxRewriter {
            override func visit(_ token: TokenSyntax) -> Syntax {
                var token = token
                if ¬token.leadingTrivia.isEmpty {
                    token = token.withLeadingTrivia(Trivia(pieces: [.spaces(1)]))
                }
                if ¬token.trailingTrivia.isEmpty {
                    token = token.withTrailingTrivia(Trivia(pieces: [.spaces(1)]))
                }
                return token
            }
        }
        return TriviaNormalizer().visit(self)
    }

    public func location(in source: String) -> Range<String.ScalarView.Index> {
        let start: String.ScalarView.Index
        if let parent = self.parent {
            var position = parent.location(in: source).lowerBound
            for index in 0 ..< indexInParent {
                let sibling = parent.child(at: index)!
                position = source.scalars.index(position, offsetBy: sibling.source().scalars.count)
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

    public static var css: StrictString {
        return (try! StrictString(file: Resources.syntaxHighlighting, origin: nil)).dropping(through: "*/\n\n")
    }

    internal static func wrap(syntaxHighlighting: String, inline: Bool) -> String {
        var result = "<code class=\u{22}swift"
        if ¬inline {
            result += " blockquote"
        }
        result += "\u{22}>"
        result += syntaxHighlighting
        result += "</code>"
        return result
    }

    public func syntaxHighlightedHTML(inline: Bool, internalIdentifiers: Set<String> = []) -> String {
        return Syntax.wrap(syntaxHighlighting: nestedSyntaxHighlightedHTML(internalIdentifiers: internalIdentifiers), inline: inline)
    }

    private func nestedSyntaxHighlightedHTML(internalIdentifiers: Set<String>) -> String {
        switch self {
        case let token as TokenSyntax :
            var result = token.leadingTrivia.nestedSyntaxHighlightedHTML(internalIdentifiers: internalIdentifiers)

            if let extended = token.extended {
                result = extended.nestedSyntaxHighlightedHTML(internalIdentifiers: internalIdentifiers)
            } else {
                var source = token.text
                if let `class` = token.syntaxHighlightingClass(internalIdentifiers: internalIdentifiers) {
                    source.prepend(contentsOf: "<span class=\u{22}\(`class`)\u{22}>")
                    source.append(contentsOf: "</span>")
                }
                result += source
            }

            result += token.trailingTrivia.nestedSyntaxHighlightedHTML(internalIdentifiers: internalIdentifiers)
            return result
        default:
            var identifiers = internalIdentifiers
            switch self {
            case let function as FunctionDeclSyntax :
                let parameters = function.signature.parameterList.map({ $0.localName.identifierText }).compactMap({ $0 })
                identifiers ∪= Set(parameters)
            default:
                break
            }
            return children.map({ $0.nestedSyntaxHighlightedHTML(internalIdentifiers: identifiers) }).joined()
        }
    }

    // MARK: - API

    internal func apiChildren() -> [APIElement] {
        let elements = Array(children.map({ $0.api() }).joined())
        return APIElement.merge(elements: elements)
    }

    internal func isPublic() -> Bool {

        let hasPublicKeyword = children.contains(where: { node in
            if let modifier = node as? DeclModifierSyntax,
                modifier.name.tokenKind == .publicKeyword {
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

    // @documentation(SDGSwiftSource.Syntax.api())
    /// Returns the API provided by this node.
    public func api() -> [APIElement] {
        if isConditionalCompilation { // UnknownStmtSyntax or UnknownDeclSyntax
            return conditionallyCompiledChildren
        }
        switch self {
        case let unknown as UnknownDeclSyntax :
            if unknown.isTypeSyntax {
                return unknown.typeAPI.flatMap({ [$0] }) ?? []
            } else if unknown.isTypeAliasSyntax {
                return unknown.typeAliasAPI.flatMap({ [$0] }) ?? []
            } else if unknown.isAssociatedTypeSyntax {
                return unknown.associatedTypeAPI.flatMap({ [$0] }) ?? [] // @exempt(from: tests) Never nil for valid source.
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
                return unknown.caseAPI.flatMap({[$0]}) ?? [] // @exempt(from: tests) Never nil for valid source.
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
            return child(at: 0)?.firstToken
        }
    }

    internal var documentation: DocumentationSyntax? {
        if let token = firstToken {
            let leading = token.leadingTrivia
            for index in leading.indices.lazy.reversed() {
                let trivia = leading[index]
                switch trivia {
                case .docLineComment:
                    let line = trivia.syntax(siblings: leading, index: index) as? LineDocumentationSyntax
                    return line?.content.context as? DocumentationSyntax
                case .docBlockComment:
                    let block = trivia.syntax(siblings: leading, index: index) as? BlockDocumentationSyntax
                    return block?.content.first as? DocumentationSyntax
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
        for child in children {
            if let token = child as? TokenSyntax,
                token.tokenKind == .poundIfKeyword {
                return token
            }
        }
        return nil
    }

    internal var isConditionalCompilation: Bool {
        return compilerIfKeyword ≠ nil
    }

    internal var conditionallyCompiledChildren: [APIElement] {
        var previousConditions: [String] = []
        var currentCondition: String? = nil
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
                currentCondition = condition.withTriviaReducedToSpaces().source()
            case let condition as IdentifierExprSyntax :
                currentCondition = condition.withTriviaReducedToSpaces().source()
            default:
                var composedConditions = "#if "
                composedConditions.append(contentsOf: previousConditions.map({ "\u{21}(" + $0 + ")" }).joined(separator: " \u{26}& "))
                if previousConditions.isEmpty {
                    composedConditions.append(contentsOf: (currentCondition ?? "")) // @exempt(from: tests) Never nil in valid source.
                } else {
                    if let current = currentCondition {
                        composedConditions.append(contentsOf: " \u{26}& (" + current + ")")
                    }
                }
                for element in child.api() {
                    currentSet.insert(element)
                    if var existing = element.compilationConditions {
                        existing.removeFirst(4)
                        var new = composedConditions
                        new.removeFirst(4)
                        existing.prepend("(")
                        existing.append(")")
                        existing.prepend(contentsOf: "(" + new + ") \u{26}& ")
                        existing.prepend(contentsOf: "#if ")
                        element.compilationConditions = existing
                    } else {
                        element.compilationConditions = composedConditions
                    }
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
