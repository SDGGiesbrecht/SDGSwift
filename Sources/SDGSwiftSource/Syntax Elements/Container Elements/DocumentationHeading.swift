
import SDGLogic
import SDGCollections

/// A heading in symbol documentation.
public class DocumentationHeading : DocumentationContainerElement {

    internal init(numberSigns: Punctuation, end: String.ScalarView.Index, in source: String) {
        self.numberSigns = numberSigns
        underline = nil
        super.init(range: numberSigns.range.lowerBound ..< end, children: [numberSigns])
        parseChildren(in: source)
    }

    internal init(start: String.ScalarView.Index, underline: Punctuation, in source: String) {
        self.underline = underline
        numberSigns = nil
        super.init(range: start ..< underline.range.upperBound, children: [underline])
        parseChildren(in: source)
    }

    // MARK: - Properties

    /// The number signs.
    public let numberSigns: Punctuation?

    /// The underline.
    public let underline: Punctuation?
}
