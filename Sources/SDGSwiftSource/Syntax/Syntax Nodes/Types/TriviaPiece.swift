/*
 TriviaPiece.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

import SwiftSyntax

import SDGSwiftLocalizations

extension TriviaPiece {

    /// The source code of the trivia piece.
    public var text: String {
        var result = ""
        write(to: &result)
        return result
    }

    /// Whether or not the trivia piece represents a newline.
    public var isNewline: Bool {
        switch self {
        case .spaces, .tabs, .backticks, .lineComment, .blockComment, .docLineComment, .docBlockComment, .garbageText:
            return false
        case .verticalTabs, .formfeeds, .newlines, .carriageReturns, .carriageReturnLineFeeds:
            return true
        }
    }

    // MARK: - Location

    /// Returns the lower bound of the trivia piece.
    ///
    /// - Parameters:
    ///     - context: The trivia piece’s context.
    public func lowerBound(in context: TriviaPieceContext) -> String.ScalarView.Index {
        switch context {
        case ._trivia(let trivia, index: let index, parent: let parent):
            var location = trivia.lowerBound(in: parent)
            let source = parent.tokenContext.fragmentContext
            for predecessor in trivia.indices where predecessor < index {
                location = source.scalars.index(location, offsetBy: trivia[predecessor].text.scalars.count)
            }
            return location
        case ._fragment(let code, context: let codeContext, offset: let offset):
            let fragmentLocation = code.lowerBound(in: codeContext)
            return codeContext.source.scalars.index(fragmentLocation, offsetBy: offset)
        }
    }

    private func upperBound(from lowerBound: String.ScalarView.Index, in context: TriviaPieceContext) -> String.ScalarView.Index {
        switch context {
        case ._trivia(_, index: _, parent: let parent):
            let source = parent.tokenContext.fragmentContext
            return source.scalars.index(lowerBound, offsetBy: text.scalars.count)
        case ._fragment(_, context: let codeContext, offset: _):
            return codeContext.source.scalars.index(lowerBound, offsetBy: text.scalars.count)
        }
    }
    /// Returns the upper bound of the trivia piece.
    ///
    /// - Parameters:
    ///     - context: The trivia piece’s context.
    public func upperBound(in context: TriviaPieceContext) -> String.ScalarView.Index {
        return upperBound(from: lowerBound(in: context), in: context)
    }

    /// Returns the range of the trivia piece.
    ///
    /// - Parameters:
    ///     - context: The trivia piece’s context.
    public func range(in context: TriviaPieceContext) -> Range<String.ScalarView.Index> {
        let lowerBound = self.lowerBound(in: context)
        return lowerBound ..< upperBound(from: lowerBound, in: context)
    }

    // MARK: - Syntax Tree

    private func parentRelationship(context: TriviaPieceContext) -> (parent: Trivia, index: Trivia.Index)? {
        switch context {
        case ._trivia(let trivia, index: let index, parent: _):
            return (parent: trivia, index: index)
        case ._fragment:
            return nil
        }
    }

    /// Returns the trivia group to which the piece belongs.
    ///
    /// - Parameters:
    ///     - context: The trivia piece’s context.
    public func parentTrivia(context: TriviaPieceContext) -> Trivia? {
        return parentRelationship(context: context)?.parent
    }

    /// Returns the index of the piece in its group.
    ///
    /// - Parameters:
    ///     - context: The trivia piece’s context.
    public func indexInParent(context: TriviaPieceContext) -> Trivia.Index? {
        return parentRelationship(context: context)?.index
    }

    /// Returns the previous trivia piece in its group.
    ///
    /// - Parameters:
    ///     - context: The trivia piece’s context.
    public func previousTriviaPiece(context: TriviaPieceContext) -> TriviaPiece? {
        guard let relationship = parentRelationship(context: context) else {
            return nil
        }
        var resultIndex: Trivia.Index?
        for index in relationship.parent.indices where index < relationship.index {
            resultIndex = index
        }
        return resultIndex.map { relationship.parent[$0] }
    }

    /// Returns the next trivia piece in its group.
    ///
    /// - Parameters:
    ///     - context: The trivia piece’s context.
    public func nextTriviaPiece(context: TriviaPieceContext) -> TriviaPiece? {
        guard let relationship = parentRelationship(context: context),
            relationship.index ≠ relationship.parent.endIndex else {
            return nil
        }
        return relationship.parent[relationship.parent.index(after: relationship.index)]
    }

    // MARK: - Parsing

    /// Returns the extended syntax of the trivia piece.
    ///
    /// - Parameters:
    ///     - siblings: The group the piece belongs to.
    ///     - index: The index of the piece in its group.
    public func syntax(siblings: Trivia, index: Trivia.Index) -> ExtendedSyntax {
        let result: ExtendedSyntax
        switch self {
        case .spaces, .tabs:
            result = ExtendedTokenSyntax(text: text, kind: .whitespace)
        case .verticalTabs, .formfeeds, .newlines, .carriageReturns, .carriageReturnLineFeeds:
            result = ExtendedTokenSyntax(text: text, kind: .newlines)
        case .backticks:
            result = ExtendedTokenSyntax(text: text, kind: .escape)
        case .lineComment:
            result = LineDeveloperCommentSyntax(source: text, siblings: siblings, index: index)
        case .blockComment:
            result = BlockDeveloperCommentSyntax(source: text)
        case .docLineComment:
            result = LineDocumentationSyntax(source: text, siblings: siblings, index: index)
        case .docBlockComment:
            result = BlockDocumentationSyntax(source: text)
        case .garbageText: // @exempt(from: tests)
            result = ExtendedTokenSyntax(text: text, kind: .source)
        }
        result.determinePositions()
        return result
    }
}
