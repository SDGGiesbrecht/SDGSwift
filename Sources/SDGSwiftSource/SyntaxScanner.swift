/*
 SyntaxScanner.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A scanner for read‐only handling of a syntax tree.
open class SyntaxScanner {

    /// Creates a syntax scanner.
    public init() {}

    // MARK: - Scanning

    // @documentation(SDGSwiftSource.SyntaxScanner.scan)
    /// Scans the node and its children.
    public func scan(_ node: SourceFileSyntax) throws {
        try scan(node, context: SyntaxContext(fragmentContext: node.source(), fragmentOffset: 0, parentContext: nil))
    }
    private func scan(_ node: Syntax, context: SyntaxContext) throws {
        if let token = node as? TokenSyntax {
            let leadingTriviaContext = TriviaContext(token: token, tokenContext: context, leading: true)
            try scan(token.leadingTrivia, context: leadingTriviaContext)
            if shouldExtend(token),
                let extended = token.extended {
                let newContext = ExtendedSyntaxContext.token(token, context: context)
                if visit(extended, context: newContext) {
                    for child in extended.children {
                        try scan(child, context: newContext)
                    }
                }
            } else {
                _ = visit(token, context: context)
            }
            let trailingTriviaContext = TriviaContext(token: token, tokenContext: context, leading: false)
            try scan(token.trailingTrivia, context: trailingTriviaContext)
        } else {
            if visit(node, context: context) {
                for child in node.children {
                    try scan(child, context: context)
                }
            }
        }
    }

    private func scan(_ node: ExtendedSyntax, context: ExtendedSyntaxContext) throws {
        if let code = node as? CodeFragmentSyntax,
            shouldExtend(code),
            let children = try code.syntax() {
            var offset = 0
            for child in children {
                switch child {
                case .syntax(let node):
                    let newContext = SyntaxContext(fragmentContext: code.context, fragmentOffset: code.offset, parentContext: context)
                    try scan(node, context: newContext)
                    offset += node.source().scalars.count
                case .extendedSyntax(let node):
                    try scan(node, context: .fragment(code, context: context, offset: offset))
                    offset += node.text.scalars.count
                case .trivia(let node, let siblings, let index):
                    try scan(node, siblings: siblings, index: index, context: .fragment(code, context: context, offset: offset))
                    offset += node.text.scalars.count
                }
            }
        } else {
            if visit(node, context: context) {
                for child in node.children {
                    try scan(child, context: context)
                }
            }
        }
    }

    private func scan(_ trivia: Trivia, context: TriviaContext) throws {
        if visit(trivia, context: context) {
            for index in trivia.indices {
                let newContext = TriviaPieceContext.trivia(trivia, index: index, parent: context)
                let piece = trivia[index]
                try scan(piece, siblings: trivia, index: index, context: newContext)
            }
        }
    }

    private func scan(_ piece: TriviaPiece, siblings: Trivia, index: Trivia.Index, context: TriviaPieceContext) throws {
        if visit(piece, context: context) {
            let newContext = ExtendedSyntaxContext.trivia(piece, context: context)
            try scan(piece.syntax(siblings: siblings, index: index), context: newContext)
        }
    }

    // MARK: - Subclassing

    // @documentation(SDGSwiftSource.SyntaxScanner.visit)
    /// Visits a syntax node.
    ///
    /// Subclass this to read information from a particular node.
    ///
    /// - Parameters:
    ///     - node: The current node.
    ///
    /// - Returns: Whether or not the scanner should visit the node’s children. The superclass implementation returns `true`, thus scanning the entire syntax tree. Subclasses can speed up the scan by returning `false` if it is already known that nothing relevant could be nested within the node. For example, a scanner concerned with the exposed API does not care about function bodies, and can skip scanning them entirely by returning `false` whenever they appear.
    open func visit(_ node: Syntax, context: SyntaxContext) -> Bool {
        return true
    }

    // #documentation(SDGSwiftSource.SyntaxScanner.visit)
    /// Visits a syntax node.
    ///
    /// Subclass this to read information from a particular node.
    ///
    /// - Parameters:
    ///     - node: The current node.
    ///
    /// - Returns: Whether or not the scanner should visit the node’s children. The superclass implementation returns `true`, thus scanning the entire syntax tree. Subclasses can speed up the scan by returning `false` if it is already known that nothing relevant could be nested within the node. For example, a scanner concerned with the exposed API does not care about function bodies, and can skip scanning them entirely by returning `false` whenever they appear.
    open func visit(_ node: ExtendedSyntax, context: ExtendedSyntaxContext) -> Bool {
        return true
    }

    // #documentation(SDGSwiftSource.SyntaxScanner.visit)
    /// Visits a syntax node.
    ///
    /// Subclass this to read information from a particular node.
    ///
    /// - Parameters:
    ///     - node: The current node.
    ///
    /// - Returns: Whether or not the scanner should visit the node’s children. The superclass implementation returns `true`, thus scanning the entire syntax tree. Subclasses can speed up the scan by returning `false` if it is already known that nothing relevant could be nested within the node. For example, a scanner concerned with the exposed API does not care about function bodies, and can skip scanning them entirely by returning `false` whenever they appear.
    open func visit(_ node: Trivia, context: TriviaContext) -> Bool {
        return true
    }

    // #documentation(SDGSwiftSource.SyntaxScanner.visit)
    /// Visits a syntax node.
    ///
    /// Subclass this to read information from a particular node.
    ///
    /// - Parameters:
    ///     - node: The current node.
    ///
    /// - Returns: Whether or not the scanner should visit the node’s children. The superclass implementation returns `true`, thus scanning the entire syntax tree. Subclasses can speed up the scan by returning `false` if it is already known that nothing relevant could be nested within the node. For example, a scanner concerned with the exposed API does not care about function bodies, and can skip scanning them entirely by returning `false` whenever they appear.
    open func visit(_ node: TriviaPiece, context: TriviaPieceContext) -> Bool {
        return true
    }

    /// Checks whether a node should be scanned in its extended form.
    ///
    /// Subclass this to skip extended parsing for particular tokens.
    ///
    /// - Parameters:
    ///     - node: A `TokenSyntax` instance.
    ///
    /// - Returns: Whether extended parsing should be applied to a node. Return `true` to try to have the token visited as an `ExtendedSyntax` subclass; return `false` to skip extended parsing and have the token visited as a `TokenSyntax` instance. If the node does not support extended parsing, the result will be ignored and a `TokenSyntax` instance will be visited regardless.
    open func shouldExtend(_ node: TokenSyntax) -> Bool {
        return true
    }

    /// Checks whether a node should be scanned in its extended form.
    ///
    /// Subclass this to skip extended parsing for particular tokens.
    ///
    /// - Parameters:
    ///     - node: A `CodeFragmentSyntax` instance.
    ///
    /// - Returns: Whether extended parsing should be applied to a node. Return `true` to try to have the token visited as `Syntax` subclasses; return `false` to skip extended parsing and have the token visited as a `CodeFragmentSyntax` instance.
    open func shouldExtend(_ node: CodeFragmentSyntax) -> Bool {
        return true
    }
}
