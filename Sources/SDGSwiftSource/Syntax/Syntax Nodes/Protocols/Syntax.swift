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

import SwiftSyntax
import enum SDGHTML.HTML

extension Syntax {

    // MARK: - Properties

    /// Returns the source code of this syntax node.
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

    /// Returns the lower bound of the leading trivia.
    ///
    /// - Parameters:
    ///     - context: The node’s context.
    public func lowerTriviaBound(in context: SyntaxContext) -> String.ScalarView.Index {
        return index(in: context, for: position)
    }

    /// Returns the lower bound of the node excluding leading trivia.
    ///
    /// - Parameters:
    ///     - context: The node’s context.
    public func lowerSyntaxBound(in context: SyntaxContext) -> String.ScalarView.Index {
        return index(in: context, for: positionAfterSkippingLeadingTrivia)
    }

    /// Returns the upper bound of the node excluding trailing trivia.
    ///
    /// - Parameters:
    ///     - context: The node’s context.
    public func upperSyntaxBound(in context: SyntaxContext) -> String.ScalarView.Index {
        return index(in: context, for: endPositionBeforeTrailingTrivia)
    }

    /// Returns the upper bound of the trailing trivia.
    ///
    /// - Parameters:
    ///     - context: The node’s context.
    public func upperTriviaBound(in context: SyntaxContext) -> String.ScalarView.Index {
        return index(in: context, for: endPosition)
    }

    /// Returns the range of the node excluding trivia.
    ///
    /// - Parameters:
    ///     - context: The node’s context.
    public func syntaxRange(in context: SyntaxContext) -> Range<String.ScalarView.Index> {
        return lowerSyntaxBound(in: context) ..< upperSyntaxBound(in: context)
    }

    /// Returns the range of the node including trivia.
    ///
    /// - Parameters:
    ///     - context: The node’s context.
    public func triviaRange(in context: SyntaxContext) -> Range<String.ScalarView.Index> {
        return lowerTriviaBound(in: context) ..< upperTriviaBound(in: context)
    }

    // MARK: - Syntax Tree

    // @documentation(SDGSwiftSource.Syntax.ancestors())
    /// All the node’s ancestors in order from its immediate parent to the root node.
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

    // @documentation(SDGSwiftSource.Syntax.firstToken())
    /// Return the first token of the node.
    public func firstToken() -> TokenSyntax? {
        if let token = self as? TokenSyntax,
            token.isPresent {
            return token
        }
        return children.lazy.compactMap({ $0.firstToken() }).first
    }

    // @documentation(SDGSwiftSource.Syntax.lastToken())
    /// Returns the last token of the node.
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
                var source = HTML.escapeTextForCharacterData(token.text)
                if let `class` = token.syntaxHighlightingClass(internalIdentifiers: internalIdentifiers) {
                    source.prepend(contentsOf: "<span class=\u{22}\(`class`)\u{22}>")
                    source.append(contentsOf: "</span>")
                }
                if token.tokenKind.shouldBeCrossLinked,
                    let url = symbolLinks[token.text] {
                    source.prepend(contentsOf: "<a href=\u{22}\(HTML.escapeTextForAttribute(url))\u{22}>")
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
            var result = children.map({ $0.nestedSyntaxHighlightedHTML(internalIdentifiers: identifiers, symbolLinks: symbolLinks) }).joined()
            if self is StringLiteralExprSyntax {
                result.prepend(contentsOf: "<span class=\u{22}string\u{22}>")
                result.append(contentsOf: "</span>")
            }
            return result
        }
    }

    // MARK: - API

    internal func apiChildren() -> [APIElement] {
        let elements = Array(children.map({ $0.api() }).joined())
        return APIElement.merge(elements: elements)
    }

    /// Returns the API provided by this node.
    public func api() -> [APIElement] {
        if let element = self as? APISyntax {
            return element.parseAPI()
        }
        switch self {
        case let conditionallyCompiledSection as IfConfigDeclSyntax:
            return conditionallyCompiledSection.conditionalAPI
        default:
            return apiChildren()
        }
    }

    internal var documentation: [SymbolDocumentation] {
        var result: [SymbolDocumentation] = []
        if let token = firstToken() {
            let leading = token.leadingTrivia
            for index in leading.indices.lazy.reversed() {
                let trivia = leading[index]
                switch trivia {
                case .docLineComment, .docBlockComment, .lineComment:
                    let comment = trivia.syntax(siblings: leading, index: index)
                    if let line = comment as? LineDocumentationSyntax,
                        let documentation = line.content.context as? DocumentationSyntax {
                        if documentation.text ≠ result.last?.documentationComment.text {
                            result.append(SymbolDocumentation(documentation))
                        }
                    } else if let block = comment as? BlockDocumentationSyntax {
                        result.append(SymbolDocumentation(block.documentation))
                    } else if let other = comment as? LineDeveloperCommentSyntax,
                        ¬result.isEmpty {
                        result[result.indices.last!].developerComments.prepend(other)
                    }
                default:
                    break
                }
            }
        }
        return result.reversed()
    }

    internal func smallestSubnode<P>(containing searchTerm: P) -> Syntax?
      where P : SDGCollections.Pattern, P.Element == Unicode.Scalar {
        guard source().scalars.contains(searchTerm) else {
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
        default: // @exempt(from: tests)
            warnUnidentified()
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
        default: // @exempt(from: tests)
            warnUnidentified()
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
        default: // @exempt(from: tests)
            warnUnidentified()
            return .unknown
        }
    }

    internal static func arrangePrecedenceAttributes(lhs: Syntax, rhs: Syntax) -> Bool {
        return (lhs.precedenceAttributeGroup(), lhs.source()) < (rhs.precedenceAttributeGroup(), lhs.source())
    }

    internal func attributeIndicatesAbsence() -> Bool {
        switch self {
        case let attribute as AttributeSyntax:
            return attribute.indicatesAbsence()
        default: // @exempt(from: tests)
            warnUnidentified()
            return false
        }
    }

    internal func normalizedAttributeForAPIDeclaration() -> AttributeSyntax? {
        switch self {
        case let attribute as AttributeSyntax:
            return attribute.normalizedForAPIDeclaration()
        default: // @exempt(from: tests)
            warnUnidentified()
            return self as? AttributeSyntax
        }
    }

    internal func normalizedAttributeArgument() -> Syntax {
        switch self {
        case let availablitiy as AvailabilitySpecListSyntax:
            return availablitiy.normalized()
        default: // @exempt(from: tests)
            warnUnidentified()
            return self
        }
    }

    internal func normalizedAvailabilityArgument() -> Syntax {
        switch self {
        case let token as TokenSyntax:
            return token.generallyNormalizedAndMissingInsteadOfNil()
        case let labeled as AvailabilityLabeledArgumentSyntax:
            return labeled.normalized()
        case let restriction as AvailabilityVersionRestrictionSyntax:
            return restriction.normalized()
        default: // @exempt(from: tests)
            warnUnidentified()
            return self
        }
    }

    internal func normalizedAvailability() -> Syntax {
        switch self {
        case let token as TokenSyntax:
            return token.generallyNormalizedAndMissingInsteadOfNil()
        case let version as VersionTupleSyntax:
            return version.normalized()
        default: // @exempt(from: tests)
            warnUnidentified()
            return self
        }
    }

    internal func normalizedVersion() -> Syntax {
        switch self {
        case let token as TokenSyntax:
            return token.generallyNormalizedAndMissingInsteadOfNil()
        default: // @exempt(from: tests)
            warnUnidentified()
            return self
        }
    }

    // MARK: - Compilation Conditions

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

    // MARK: - Debugging

    internal func warnUnidentified(file: StaticString = #file, function: StaticString = #function) { // @exempt(from: tests)
        #if UNIDENTIFIED_SYNTAX_WARNINGS
        switch self {
        case is UnknownSyntax,
             is UnknownPatternSyntax,
             is UnknownTypeSyntax:
            break
        default: // @exempt(from: tests)
            let fileName = URL(fileURLWithPath: "\(file)").deletingPathExtension().lastPathComponent
            print("Unidentified syntax node: \(Swift.type(of: self)) (\(fileName).\(function))")
        }
        #endif
    }
}
