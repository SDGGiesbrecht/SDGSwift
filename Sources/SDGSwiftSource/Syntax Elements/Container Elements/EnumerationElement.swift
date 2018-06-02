
/// An enumeration element declaration.
public class EnumerationElement : ContainerSyntaxElement {

    internal init(substructureInformation: SourceKit.Variant, source: String, tokens: [SourceKit.PrimitiveToken]) throws {
        name = Identifier(range: try SyntaxElement.range(from: substructureInformation, for: "key.name", in: source), isDefinition: true)
        try super.init(substructureInformation: substructureInformation, source: source, tokens: tokens, knownChildren: [name])
    }

    // MARK: - Properties

    /// The name of the variable.
    public let name: Identifier
}
