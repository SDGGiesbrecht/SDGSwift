
/// A list element in symbol documentation.
public class DocumentationListElement : DocumentationContainerElement {

    internal init(bullet: Punctuation, end: String.ScalarView.Index, in source: String) {
        self.bullet = bullet
        super.init(range: bullet.range.lowerBound ..< end, children: [bullet])
        parseChildren(in: source)
    }

    // MARK: - Properties

    /// The bullet.
    public let bullet: Punctuation?
}
