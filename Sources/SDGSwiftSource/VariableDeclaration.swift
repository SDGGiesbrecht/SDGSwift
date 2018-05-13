
/// A variable declaration.
public class VariableDeclaration : ContainerSyntaxElement {
    
    internal init(substructureInformation: SourceKit.Variant, in source: String) throws {
        name = Identifier(range: try SyntaxElement.range(from: substructureInformation, for: "key.name", in: source))
        try super.init(substructureInformation: substructureInformation, in: source, knownChildren: [name])
        print(substructureInformation.asAny())
    }
    
    // MARK: - Properties
    
    let name: Identifier
}
