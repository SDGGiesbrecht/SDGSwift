
/// A newline.
public class Newline : AtomicSyntaxElement {

    // MARK: - Static Properties

    /// The characters recognized by the Swift compiler as belonging to newlines.
    public static let newlineCharacters: Set<Unicode.Scalar> = [
        // From https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/LexicalStructure.html#//apple_ref/doc/uid/TP40014097-CH30-ID410
        "\u{A}", // “line feed”
        "\u{D}" // “carriage return”
    ]

    // MARK: - Properties

    // [_Inherit Documentation: SyntaxElement.textFreedom_]
    /// How much freedom the user has in choosing the text of the element.
    public override var textFreedom: TextFreedom {
        return .invariable
    }
}
