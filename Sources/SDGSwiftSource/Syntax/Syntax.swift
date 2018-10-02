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
            case let `subscript` as SubscriptDeclSyntax :
                let parameters = `subscript`.indices.parameterList.map({ $0.secondName?.identifierText }).compactMap({ $0 })
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

    // @documentation(SDGSwiftSource.Syntax.api())
    /// Returns the API provided by this node.
    public func api() -> [APIElement] {
        if isConditionalCompilation { // UnknownStmtSyntax or UnknownDeclSyntax
            return conditionallyCompiledChildren
        }
        switch self {
        case let structure as StructDeclSyntax :
            return structure.typeAPI.flatMap({ [$0] }) ?? []
        case let `class` as ClassDeclSyntax :
            return `class`.typeAPI.flatMap({ [$0] }) ?? []
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
