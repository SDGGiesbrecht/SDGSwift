
/// An argument.
public class Argument : ContainerSyntaxElement {

    internal init(substructureInformation: SourceKit.Variant, source: String, tokens: [SourceKit.PrimitiveToken]) throws {
        label = Identifier(range: try SyntaxElement.range(from: substructureInformation, for: "key.name", in: source), isDefinition: false)
        try super.init(substructureInformation: substructureInformation, source: source, tokens: tokens, knownChildren: [label])
    }

    // MARK: - Properties

    /// The name of the parameter.
    public let label: Identifier
}
