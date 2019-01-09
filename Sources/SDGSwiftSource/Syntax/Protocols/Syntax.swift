/*
 Syntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
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

    // MARK: - Location

    private func index(in context: SyntaxContext, for position: AbsolutePosition) -> String.ScalarView.Index {
        let string = context.fragmentContext
        let utf8 = string.utf8
        let utf8Index = utf8.index(utf8.startIndex, offsetBy: position.utf8Offset)
        let fragmentIndex = utf8Index.samePosition(in: string.scalars)!

        guard let parent = context.parentContext else {
            return fragmentIndex
        }
        let code = parent.code
        let codeFragmentContext = code.context
        let codeOffset = codeFragmentContext.scalars.distance(from: code.range.lowerBound, to: fragmentIndex)
        let codePosition = code.lowerBound(in: parent.context)
        return parent.context.source.scalars.index(codePosition, offsetBy: codeOffset)
    }

    public func lowerTriviaBound(in context: SyntaxContext) -> String.ScalarView.Index {
        return index(in: context, for: position)
    }

    public func lowerSyntaxBound(in context: SyntaxContext) -> String.ScalarView.Index {
        return index(in: context, for: positionAfterSkippingLeadingTrivia)
    }

    public func upperSyntaxBound(in context: SyntaxContext) -> String.ScalarView.Index {
        return index(in: context, for: endPosition)
    }

    public func upperTriviaBound(in context: SyntaxContext) -> String.ScalarView.Index {
        return index(in: context, for: endPositionAfterTrailingTrivia)
    }

    public func syntaxRange(in context: SyntaxContext) -> Range<String.ScalarView.Index> {
        return lowerSyntaxBound(in: context) ..< upperSyntaxBound(in: context)
    }

    public func triviaRange(in context: SyntaxContext) -> Range<String.ScalarView.Index> {
        return lowerTriviaBound(in: context) ..< upperTriviaBound(in: context)
    }

    // MARK: - Syntax Tree

    public func ancestors() -> AnySequence<Syntax> {
        if let parent = self.parent {
            return AnySequence(sequence(first: parent, next: { $0.parent }))
        } else {
            return AnySequence([])
        }
    }

    internal func ancestorRelationships() -> AnySequence<(parent: Syntax, index: Int)> {
        if let parentRelationship = self.parentRelationship {
            return AnySequence(sequence(first: parentRelationship, next: { $0.parent.parentRelationship }))
        } else {
            return AnySequence([])
        }
    }

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

    public func firstToken() -> TokenSyntax? {
        if let token = self as? TokenSyntax,
            token.isPresent {
            return token
        }
        return children.lazy.compactMap({ $0.firstToken() }).first
    }

    public func lastToken() -> TokenSyntax? {
        if let token = self as? TokenSyntax,
            token.isPresent {
            return token
        }
        return children.reversed().lazy.compactMap({ $0.lastToken() }).first
    }

    private var parentRelationship: (parent: Syntax, index: Int)? {
        guard let parent = self.parent else {
            return nil
        }
        return (parent, indexInParent)
    }

    // MARK: - Syntax Highlighting

    // @documentation(SDGSwiftSource.Syntax.syntaxHighlightedHTML)
    /// Returns a syntax‐highlighted HTML representation of the source.
    ///
    /// The resulting HTML depends on the CSS provided by `SyntaxHighlighter.css`.
    ///
    /// - Parameters:
    ///     - inline: Pass `true` to generate inline HTML instead of a separate block section.
    ///     - internalIdentifiers: Optional. A set of identifiers to consider as belonging to the module.
    ///     - symbolLinks: Optional. A dictionary of target links for cross‐linking symbols. The values will be inserted as‐is in `href` attributes. URLs must already be properly encoded for this context before passing them.
    public func syntaxHighlightedHTML(inline: Bool, internalIdentifiers: Set<String> = [], symbolLinks: [String: String] = [:]) -> String {
        return SyntaxHighlighter.frame(highlightedSyntax: nestedSyntaxHighlightedHTML(internalIdentifiers: internalIdentifiers, symbolLinks: symbolLinks), inline: inline)
    }

    internal func nestedSyntaxHighlightedHTML(internalIdentifiers: Set<String>, symbolLinks: [String: String]) -> String {
        switch self {
        case let token as TokenSyntax:
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
                    source.prepend(contentsOf: "<a href=\u{22}\(HTML.escapeAttribute(url))\u{22}>")
                    source.append(contentsOf: "</a>")
                }
                result += source
            }

            result += token.trailingTrivia.nestedSyntaxHighlightedHTML(internalIdentifiers: internalIdentifiers, symbolLinks: symbolLinks)
            return result
        default:
            var identifiers = internalIdentifiers
            var parameterClause: ParameterClauseSyntax?
            switch self {
            case let initializer as InitializerDeclSyntax:
                parameterClause = initializer.parameters
            case let `subscript` as SubscriptDeclSyntax:
                parameterClause = `subscript`.indices
            case let function as FunctionDeclSyntax:
                parameterClause = function.signature.input
            default:
                break
            }

            if let clause = parameterClause {
                let parameters = clause.parameterList.map({ $0.internalName?.text }).compactMap({ $0 })
                identifiers ∪= Set(parameters)
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
        switch self {
        case let structure as StructDeclSyntax:
            return structure.typeAPI.flatMap({ [APIElement.type($0)] }) ?? []
        case let `class` as ClassDeclSyntax:
            return `class`.typeAPI.flatMap({ [APIElement.type($0)] }) ?? []
        case let enumeration as EnumDeclSyntax:
            return enumeration.typeAPI.flatMap({ [APIElement.type($0)] }) ?? []
        case let typeAlias as TypealiasDeclSyntax:
            return typeAlias.typeAPI.flatMap({ [APIElement.type($0)] }) ?? []
        case let associatedType as AssociatedtypeDeclSyntax:
            return associatedType.typeAPI.flatMap({ [APIElement.type($0)] }) ?? []
        case let `protocol` as ProtocolDeclSyntax:
            return `protocol`.protocolAPI.flatMap({ [APIElement.protocol($0)] }) ?? []
        case let `case` as EnumCaseDeclSyntax:
            return `case`.caseAPI().map({ APIElement.case($0) })
        case let initializer as InitializerDeclSyntax:
            return initializer.initializerAPI.flatMap({ [APIElement.initializer($0)] }) ?? []
        case let variable as VariableDeclSyntax:
            return variable.variableAPI().map({ APIElement.variable($0) })
        case let `subscript` as SubscriptDeclSyntax:
            return `subscript`.subscriptAPI.flatMap({ [APIElement.subscript($0)] }) ?? []
        case let function as FunctionDeclSyntax:
            return function.functionAPI().flatMap({ [APIElement.function($0)] }) ?? []
        case let `operator` as OperatorDeclSyntax:
            return `operator`.operatorAPI().flatMap({ [APIElement.operator($0)] }) ?? []
        case let precedence as PrecedenceGroupDeclSyntax:
            return precedence.precedenceAPI().flatMap({ [APIElement.precedence($0)] }) ?? []
        case let `extension` as ExtensionDeclSyntax:
            return `extension`.extensionAPI.flatMap({ [APIElement.extension($0)] }) ?? []
        case let conditionallyCompiledSection as IfConfigDeclSyntax:
            return conditionallyCompiledSection.conditionalAPI
        default:
            if isUnidentifiedConditionalCompilation {
                return unidentifiedConditionallyCompiledChildren
            }
            if let unknown = (self as? UnknownDeclSyntax)?.unknownAPI(),
                ¬unknown.isEmpty {
                return unknown
            }
            return apiChildren()
        }
    }

    internal var documentation: DocumentationSyntax? {
        guard let token = firstToken() else {
            return nil
        }
        let leading = token.leadingTrivia
        for index in leading.indices.lazy.reversed() {
            let trivia = leading[index]
            switch trivia {
            case .docLineComment, .docBlockComment:
                let comment = trivia.syntax(siblings: leading, index: index)
                if let line = comment as? LineDocumentationSyntax {
                    return line.content.context as? DocumentationSyntax
                } else if let block = comment as? BlockDocumentationSyntax {
                    return block.documentation
                }
            default:
                continue
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

    // MARK: - Normalization

    internal func withTriviaReducedToSpaces() -> Syntax {
        return TriviaNormalizer().visit(self)
    }

    internal func normalizedGenericRequirement(comma: Bool) -> Syntax {
        switch self {
        case let conformance as ConformanceRequirementSyntax:
            return conformance.normalized(comma: comma)
        case let sameType as SameTypeRequirementSyntax:
            return sameType.normalized(comma: comma)
        default: // @exempt(from: tests) Should never occur.
            if BuildConfiguration.current == .debug { // @exempt(from: tests)
                print("Unidentified generic requirement: \(Swift.type(of: self))")
            }
            return self
        }
    }

    internal func normalizedPrecedenceAttribute() -> Syntax {
        switch self {
        case let relation as PrecedenceGroupRelationSyntax:
            return relation.normalizedForAPIDeclaration()
        case let associativity as PrecedenceGroupAssociativitySyntax:
            return associativity.normalizedForAPIDeclaration()
        case let assignment as PrecedenceGroupAssignmentSyntax:
            return assignment.normalizedForAPIDeclaration()
        default: // @exempt(from: tests) Should never occur.
            if BuildConfiguration.current == .debug { // @exempt(from: tests)
                print("Unidentified preference group attribute: \(Swift.type(of: self))")
            }
            return self
        }
    }

    private func precedenceAttributeGroup() -> PrecedenceGroupAttributeListSyntax.PrecedenceAttributeGroup {
        switch self {
        case let relation as PrecedenceGroupRelationSyntax:
            if relation.higherThanOrLowerThan.text == "lowerThan" {
                return .before
            } else {
                return .after
            }
        case is PrecedenceGroupAssociativitySyntax:
            return .associativity
        case is PrecedenceGroupAssignmentSyntax:
            return .assignment
        default: // @exempt(from: tests) Should never occur.
            if BuildConfiguration.current == .debug { // @exempt(from: tests)
                print("Unidentified preference group attribute: \(Swift.type(of: self))")
            }
            return .unknown
        }
    }

    internal static func arrangePrecedenceAttributes(lhs: Syntax, rhs: Syntax) -> Bool {
        return (lhs.precedenceAttributeGroup(), lhs.source()) < (rhs.precedenceAttributeGroup(), lhs.source())
    }

    // MARK: - Compilation Conditions

    internal var isUnidentifiedConditionalCompilation: Bool {
        if let statement = children.first(where: { _ in true }) as? UnknownSyntax,
            let token = statement.children.first(where: { _ in true }) as? TokenSyntax,
            token.tokenKind == .poundIfKeyword {
            return true
        }
        return false
    }

    internal var unidentifiedConditionallyCompiledChildren: [APIElement] {
        return (try? SyntaxTreeParser.parse(source()).apiChildren()) ?? [] // @exempt(from: tests)
    }

    internal func prependingCompilationConditions(_ addition: Syntax) -> Syntax {
        let existingCondition = Array(tokens().dropFirst())
        let newCondition = Array(addition.tokens().dropFirst())
        return SyntaxFactory.makeUnknownSyntax(tokens: [
            SyntaxFactory.makeToken(.poundIfKeyword, trailingTrivia: .spaces(1)),
            SyntaxFactory.makeToken(.leftParen)
            ] + newCondition + [
                SyntaxFactory.makeToken(.rightParen),
                SyntaxFactory.makeToken(.spacedBinaryOperator("\u{26}&"), leadingTrivia: .spaces(1), trailingTrivia: .spaces(1)),
                SyntaxFactory.makeToken(.leftParen)
            ] + existingCondition + [
                SyntaxFactory.makeToken(.rightParen)
            ])
    }
}
