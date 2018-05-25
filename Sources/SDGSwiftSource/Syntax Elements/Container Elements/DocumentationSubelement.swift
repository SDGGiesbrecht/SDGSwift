
/// A container element related to symbol documentation.
public class DocumentationContainerElement : ContainerSyntaxElement {

    internal func parseIndents(in source: String) {
        parseNewlines(in: source)
        parseUnidentified(in: source, for: "///") { DocumentationToken(range: $0) }
    }

    internal func parseChildren(in source: String) {
        parseIndents(in: source)
    }
}
