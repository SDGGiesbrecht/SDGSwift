
extension SyntaxFactory {

    public static func makeToken(_ kind: TokenKind, leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
        return SyntaxFactory.makeToken(kind, presence: .present, leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
    }
}
