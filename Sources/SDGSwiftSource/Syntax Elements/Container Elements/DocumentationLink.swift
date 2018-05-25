
/// A link in symbol documentation.
public class DocumentationLink : DocumentationContainerElement {

    internal init(start: String.ScalarView.Index, medialToken: Range<String.ScalarView.Index>, end: String.ScalarView.Index, in source: String) {

        let startToken = Punctuation(range: start ..< source.scalars.index(after: start))
        self.startToken = startToken

        let medialToken = Punctuation(range: medialToken)
        self.medialToken = medialToken

        let endToken = Punctuation(range: source.scalars.index(before: end) ..< end)
        self.endToken = endToken

        super.init(range: start ..< end, children: [startToken, medialToken, endToken])
        parseChildren(in: source)
    }

    // MARK: - Properties

    /// The start token.
    public let startToken: Punctuation

    /// The token marking the end of the link text and the start of the URL.
    public let medialToken: Punctuation

    /// The end token.
    public let endToken: Punctuation
}
