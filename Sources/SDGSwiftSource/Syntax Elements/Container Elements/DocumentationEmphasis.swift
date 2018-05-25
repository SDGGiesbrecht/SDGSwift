
/// Emphasized text in symbol documentation.
public class DocumentationEmphasis : DocumentationContainerElement {

    internal init(startToken: Punctuation, endToken: Punctuation, in source: String) {
        self.startToken = startToken
        self.endToken = endToken
        super.init(range: startToken.range.lowerBound ..< endToken.range.upperBound, children: [startToken, endToken])
        parseChildren(in: source)
    }

    // MARK: - Properties

    /// The start token.
    public let startToken: Punctuation

    /// The end token.
    public let endToken: Punctuation
}
