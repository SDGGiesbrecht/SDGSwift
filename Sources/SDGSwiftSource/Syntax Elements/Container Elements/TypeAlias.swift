
/// A type alias.
public class TypeAlias : ContainerSyntaxElement {

    internal init(substructureInformation: SourceKit.Variant, source: String, tokens: [SourceKit.PrimitiveToken]) throws {
        name = TypeIdentifier(range: try SyntaxElement.range(from: substructureInformation, for: "key.name", in: source), isDefinition: true)
        try super.init(substructureInformation: substructureInformation, source: source, tokens: tokens, knownChildren: [name])
    }

    // MARK: - Properties

    /// The name of the variable.
    public let name: TypeIdentifier
}
