
/// A list element in symbol documentation.
public class DocumentationCallout : DocumentationContainerElement {

    internal init(bullet: Punctuation, callout: Keyword, colon: Punctuation, end: String.ScalarView.Index, in source: String) {
        self.bullet = bullet
        self.callout = callout
        self.colon = colon
        super.init(range: bullet.range.lowerBound ..< end, children: [bullet, callout, colon])
        parseChildren(in: source)
    }

    // MARK: - Properties

    /// The bullet.
    public let bullet: Punctuation

    /// The callout.
    public let callout: Keyword

    /// The colon.
    public let colon: Punctuation
}
