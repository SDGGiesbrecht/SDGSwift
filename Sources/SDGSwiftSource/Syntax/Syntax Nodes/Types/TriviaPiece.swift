/*
 TriviaPiece.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SDGLogic
  import SDGMathematics

  import SwiftSyntax

  import SDGSwift

  import SDGSwiftLocalizations

  extension TriviaPiece {

    /// The source code of the trivia piece.
    public var text: String {
      var result = ""
      write(to: &result)
      return result
    }

    // MARK: - Location

    /// Returns the lower bound of the trivia piece.
    ///
    /// - Parameters:
    ///     - context: The trivia piece’s context.
    public func lowerBound(in context: TriviaPieceContext) -> String.ScalarOffset {
      switch context {
      case ._trivia(let trivia, let index, let parent):
        var location = trivia.lowerBound(in: parent)
        for predecessor in trivia.indices where predecessor < index {
          location += trivia[predecessor].text.scalars.count
        }
        return location
      case ._fragment(let code, context: let codeContext, let offset):
        let fragmentLocation: String.ScalarOffset = code.lowerBound(in: codeContext)
        return fragmentLocation + offset
      }
    }

    private func upperBound(
      from lowerBound: String.ScalarOffset,
      in context: TriviaPieceContext
    ) -> String.ScalarOffset {
      return lowerBound + text.scalars.count
    }
    /// Returns the upper bound of the trivia piece.
    ///
    /// - Parameters:
    ///     - context: The trivia piece’s context.
    public func upperBound(in context: TriviaPieceContext) -> String.ScalarOffset {
      return upperBound(from: lowerBound(in: context), in: context)
    }

    /// Returns the range of the trivia piece.
    ///
    /// - Parameters:
    ///     - context: The trivia piece’s context.
    public func range(in context: TriviaPieceContext) -> Range<String.ScalarOffset> {
      let lowerBound = self.lowerBound(in: context)
      return lowerBound..<upperBound(from: lowerBound, in: context)
    }

    // MARK: - Syntax Tree

    private func parentRelationship(context: TriviaPieceContext) -> (
      parent: Trivia, index: Trivia.Index
    )? {
      switch context {
      case ._trivia(let trivia, let index, parent: _):
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
        relationship.index ≠ relationship.parent.endIndex
      else {
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
      case .lineComment:
        result = LineDeveloperCommentSyntax(source: text, siblings: siblings, index: index)
      case .blockComment:
        result = BlockDeveloperCommentSyntax(source: text)
      case .docLineComment:
        result = LineDocumentationSyntax(source: text, siblings: siblings, index: index)
      case .docBlockComment:
        result = BlockDocumentationSyntax(source: text)
      case .unexpectedText, .shebang:  // @exempt(from: tests)
        result = ExtendedTokenSyntax(text: text, kind: .source)
      }
      result.determinePositions()
      return result
    }
  }
#endif
