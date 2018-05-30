
/// A protocol declaration.
public class ProtocolDeclaration : ContainerSyntaxElement {

    internal init(substructureInformation: SourceKit.Variant, source: String, tokens: [SourceKit.PrimitiveToken]) throws {
        name = TypeIdentifier(range: try SyntaxElement.range(from: substructureInformation, for: "key.name", in: source), isDefinition: true)
        try super.init(substructureInformation: substructureInformation, source: source, tokens: tokens, knownChildren: [name])
    }

    // MARK: - Properties

    let name: TypeIdentifier
}
