
/// An asterism in symbol documentation.
public class DocumentationAsterism : AtomicSyntaxElement {

    // MARK: - Properties

    // [_Inherit Documentation: SyntaxElement.textFreedom_]
    /// How much freedom the user has in choosing the text of the element.
    public override var textFreedom: TextFreedom {
        return .invariable
    }
}
