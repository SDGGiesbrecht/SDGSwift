/*
 TriviaSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A syntax node for trivia.
public class TriviaSyntax : TextOutputStreamable {

    internal init(children: [TriviaSyntax]) {
        self.children = children
    }

    // MARK: - Properties

    /// The children of this node.
    public let children: [TriviaSyntax]

    public var text: String {
        var result = ""
        write(to: &result)
        return result
    }

    // MARK: - Parsing

    internal static func parse(_ piece: TriviaPiece) -> TriviaPieceSyntax {
        let children: [TriviaSyntax]
        switch piece {
        case .spaces, .tabs:
            children = [TokenTriviaSyntax(text: piece.text, kind: .whitespace)]
        case .verticalTabs, .formfeeds, .newlines:
            children = [TokenTriviaSyntax(text: piece.text, kind: .newlines)]
        case .backticks:
            children = [TokenTriviaSyntax(text: piece.text, kind: .escape)]
        case .lineComment:
            children = [LineCommentSyntax(source: piece.text)]
        case .blockComment:
            children = [BlockCommentSyntax(source: piece.text)]
        case .docLineComment:
            children = [LineDocumentationSyntax(source: piece.text)]
        case .docBlockComment:
            children = [BlockDocumentationSyntax(source: piece.text)]
        }
        return TriviaPieceSyntax(children: children)
    }

    // MARK: - TextOutputStreamable

    public func write<Target>(to target: inout Target) where Target : TextOutputStream {
        for child in children {
            child.write(to: &target)
        }
    }
}
