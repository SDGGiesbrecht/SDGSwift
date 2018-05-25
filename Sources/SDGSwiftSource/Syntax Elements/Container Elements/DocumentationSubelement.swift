
import SDGCollections

/// A container element related to symbol documentation.
public class DocumentationContainerElement : ContainerSyntaxElement {

    internal func parseIndents(in source: String) {
        parseNewlines(in: source)
        parseUnidentified(in: source, for: "///") { DocumentationToken(range: $0) }
    }

    internal func parseChildren(in source: String) {
        parseIndents(in: source)

        func parseInlineStyle(token: String, create: (_ start: Punctuation, _ end: Punctuation) -> SyntaxElement) {
            parseUnidentified { unidentified in
                let matches = source.scalars.matches(for: LiteralPattern(token.scalars), in: unidentified.range)
                let pairs = stride(from: 0, to: matches.endIndex.rounded(.down, toMultipleOf: 2), by: 2).map { (matches[$0], matches[$0 + 1]) }
                var result: [SyntaxElement] = []
                for pair in pairs {
                    result.append(create(Punctuation(range: pair.0.range), Punctuation(range: pair.1.range)))
                }
                return result
            }
        }

        // Inline code
        parseInlineStyle(token: "`") { DocumentationCodeBlock(startFence: $0, endFence: $1, in: source) }
        // Emphasis/Bold
        parseUnidentified(in: source, for: "*") { Punctuation(range: $0) }
        parseUnidentified(in: source, for: "_") { Punctuation(range: $0) }

        // The rest is text.
        parseUnidentified { [DocumentationText(range: $0.range)] }
    }
}
