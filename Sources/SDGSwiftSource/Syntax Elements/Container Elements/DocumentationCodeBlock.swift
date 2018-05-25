
import SDGLogic
import SDGCollections

/// A code block in symbol documentation.
public class DocumentationCodeBlock : DocumentationSubelement {

    internal init(startFence: Punctuation, endFence: Punctuation, in source: String) {
        self.startFence = startFence
        self.endFence = endFence
        var children: [SyntaxElement] = [startFence, endFence]

        var languageEnd = startFence.range.upperBound
        source.scalars.advance(&languageEnd, over: RepetitionPattern(ConditionalPattern({ $0 ∉ Newline.newlineCharacters })))
        languageEnd.decrease(to: endFence.range.lowerBound)
        if languageEnd ≠ startFence.range.upperBound {
            let language = Keyword(range: startFence.range.upperBound ..< languageEnd)
            self.language = language
            children.append(language)
        } else {
            self.language = nil
        }

        super.init(range: startFence.range.lowerBound ..< endFence.range.upperBound, children: children)
        parseIndents(in: source)
    }

    // MARK: - Properties

    /// The start fence.
    public let startFence: Punctuation

    /// The end fence.
    public let endFence: Punctuation

    /// The language specifier.
    public let language: Keyword?
}
