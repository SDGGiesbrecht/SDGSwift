/*
 FunctionalSyntaxScanner.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A syntax scanner that can be used by providing closures instead of subclassing.
public class FunctionalSyntaxScanner : SyntaxScanner {

    // MARK: - Initialization

    /// Creates a syntax scanner with behaviour defined by the provided closures.
    public init(
        checkSyntax: @escaping (Syntax, SyntaxContext) -> Bool = { _, _ in true },
        checkExtendedSyntax: @escaping (ExtendedSyntax) -> Bool = { _ in true },
        checkTrivia: @escaping (Trivia) -> Bool = { _ in true },
        checkTriviaPiece: @escaping (TriviaPiece) -> Bool = { _ in true },
        shouldExtendToken: @escaping (TokenSyntax) -> Bool = { _ in true },
        shouldExtendFragment: @escaping (CodeFragmentSyntax) -> Bool = { _ in true }) {

        self.checkSyntax = checkSyntax
        self.checkExtendedSyntax = checkExtendedSyntax
        self.checkTrivia = checkTrivia
        self.checkTriviaPiece = checkTriviaPiece
        self.shouldExtendToken = shouldExtendToken
        self.shouldExtendFragment = shouldExtendFragment
    }

    // MARK: - Properties

    private let checkSyntax: (Syntax, SyntaxContext) -> Bool
    private let checkExtendedSyntax: (ExtendedSyntax) -> Bool
    private let checkTrivia: (Trivia) -> Bool
    private let checkTriviaPiece: (TriviaPiece) -> Bool
    private let shouldExtendToken: (TokenSyntax) -> Bool
    private let shouldExtendFragment: (CodeFragmentSyntax) -> Bool

    // MARK: - SyntaxScanner

    public override func visit(_ node: Syntax, context: SyntaxContext) -> Bool {
        return checkSyntax(node, context)
    }

    public override func visit(_ node: ExtendedSyntax) -> Bool {
        return checkExtendedSyntax(node)
    }

    public override func visit(_ node: Trivia) -> Bool {
        return checkTrivia(node)
    }

    public override func visit(_ node: TriviaPiece) -> Bool {
        return checkTriviaPiece(node)
    }

    public override func shouldExtend(_ node: TokenSyntax) -> Bool {
        return shouldExtendToken(node)
    }

    public override func shouldExtend(_ node: CodeFragmentSyntax) -> Bool {
        return shouldExtendFragment(node)
    }
}
