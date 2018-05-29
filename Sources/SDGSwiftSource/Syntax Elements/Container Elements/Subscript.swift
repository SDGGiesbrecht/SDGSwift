
import SDGLogic

/// A subscript.
public class Subscript : ContainerSyntaxElement {

    internal init(substructureInformation: SourceKit.Variant, source: String, tokens: [SourceKit.PrimitiveToken]) throws {
        try super.init(substructureInformation: substructureInformation, source: source, tokens: tokens)
    }
}
