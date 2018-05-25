
import SDGCollections

/// A parameter in symbol documentation.
public class DocumentationParameter : DocumentationCallout {

    internal init(bullet: Punctuation, callout: Keyword, colon: Punctuation, end: String.ScalarView.Index, in source: String) {
        let range: Range<String.ScalarView.Index>
        if let nameStart = source.scalars.firstMatch(for: ConditionalPattern({ $0 ∉ Whitespace.whitespaceCharacters }), in: callout.range.upperBound ..< colon.range.lowerBound)?.range.lowerBound {
            range = nameStart ..< colon.range.lowerBound
        } else {
            // Invalid syntax anyway.
            range = callout.range.upperBound ..< colon.range.lowerBound
        }
        let parameter = Identifier(range: range, isDefinition: false)
        self.parameter = parameter
        super.init(bullet: bullet, callout: callout, colon: colon, end: end, in: source, knownChildren: [parameter])
    }

    // MARK: - Properties

    /// The parameter name.
    public let parameter: Identifier
}
