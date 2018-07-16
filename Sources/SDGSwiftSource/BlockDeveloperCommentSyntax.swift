
public class BlockDeveloperCommentSyntax : BlockCommentSyntax {

    // MARK: - Class Properties

    internal override class var openingDelimiter: ExtendedTokenSyntax {
        return ExtendedTokenSyntax(text: "/*", kind: .openingBlockCommentDelimiter)
    }

    internal override class func parse(contents: String) -> ExtendedSyntax {
        return CommentContentSyntax(source: contents)
    }
}
