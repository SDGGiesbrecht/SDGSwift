
/// A parameter.
public class Parameter : ContainerSyntaxElement {
    
    internal init(substructureInformation: SourceKit.Variant, in source: String) throws {
        name = Identifier(range: try SyntaxElement.range(from: substructureInformation, for: "key.name", in: source))
        try super.init(substructureInformation: substructureInformation, in: source, knownChildren: [name])
    }
    
    // MARK: - Properties
    
    let name: Identifier
}
