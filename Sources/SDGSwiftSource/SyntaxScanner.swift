/*
 SyntaxScanner.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

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
    public func scan(_ node: Syntax) {
        if let token = node as? TokenSyntax {
            scan(token.leadingTrivia)
            if shouldExtend(token),
                let extended = token.extended {
                if visit(extended) {
                    for child in extended.children {
                        scan(child)
                    }
                }
            } else {
                _ = visit(token)
            }
            scan(token.trailingTrivia)
        } else {
            if visit(node) {
                for child in node.children {
                    scan(child)
                }
            }
        }
    }

    // #documentation(SDGSwiftSource.SyntaxScanner.scan)
    /// Scans the node and its children.
    public func scan(_ node: ExtendedSyntax) {
        if visit(node) {
            for child in node.children {
                scan(child)
            }
        }
    }

    // #documentation(SDGSwiftSource.SyntaxScanner.scan)
    /// Scans the node and its children.
    public func scan(_ trivia: Trivia) {
        if visit(trivia) {
            for piece in trivia {
                scan(piece)
            }
        }
    }

    // #documentation(SDGSwiftSource.SyntaxScanner.scan)
    /// Scans the node and its children.
    public func scan(_ piece: TriviaPiece) {
        if visit(piece) {
            scan(piece.syntax)
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
    open func visit(_ node: Syntax) -> Bool {
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
    open func visit(_ node: ExtendedSyntax) -> Bool {
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
    open func visit(_ node: Trivia) -> Bool {
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
    open func visit(_ node: TriviaPiece) -> Bool {
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
}
