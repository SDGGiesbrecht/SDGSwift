
import SDGLogic

/// An argument.
public class Argument : ContainerSyntaxElement {

    internal init(substructureInformation: SourceKit.Variant, source: String, tokens: [SourceKit.PrimitiveToken]) throws {
        var knownChildren: [SyntaxElement] = []

        let possibleLabel = Identifier(range: try SyntaxElement.range(from: substructureInformation, for: "key.name", in: source), isDefinition: false)
        if ¬possibleLabel.range.isEmpty {
            label = possibleLabel
            knownChildren.append(possibleLabel)
        } else {
            label = nil
        }

        try super.init(substructureInformation: substructureInformation, source: source, tokens: tokens, knownChildren: knownChildren)
    }

    // MARK: - Properties

    /// The name of the parameter.
    public let label: Identifier?
}
