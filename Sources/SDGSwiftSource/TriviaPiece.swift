/*
 TriviaPiece.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwiftLocalizations

extension TriviaPiece {

    internal init(syntax: TriviaPieceSyntax) {
        switch syntax.child {
        case let token as ExtendedTokenSyntax:
            switch token.kind {
            case .whitespace, .newlines, .escape:
                guard let first = token.text.first else {
                    preconditionFailure(UserFacing<StrictString, APILocalization>({ localization in
                        switch localization {
                        case .englishCanada:
                            return StrictString("Empty trivia.")
                        }
                    }))
                }
                switch first {
                case " ":
                    self = .spaces(token.text.count)
                case "\u{9}":
                    self = .tabs(token.text.count)
                case "\u{A}":
                    self = .newlines(token.text.count)
                case "`":
                    self = .backticks(token.text.count)
                case "\u{B}":
                    self = .verticalTabs(token.text.count)
                case "\u{C}":
                    self = .formfeeds(token.text.count)
                default:
                    preconditionFailure(UserFacing<StrictString, APILocalization>({ localization in
                        switch localization {
                        case .englishCanada:
                            return StrictString("Invalid trivia characters: \(token.text)")
                        }
                    }))
                }
            default:
                preconditionFailure(UserFacing<StrictString, APILocalization>({ localization in
                    switch localization {
                    case .englishCanada:
                        return StrictString("Invalid trivia piece: \(token)")
                    }
                }))
            }
        case let documentation as LineDocumentationSyntax:
            self = .docLineComment(documentation.text)
        case let comment as LineCommentSyntax:
            self = .lineComment(comment.text)
        case let documentation as BlockDocumentationSyntax:
            self = .blockComment(documentation.text)
        case let comment as BlockCommentSyntax:
            self = .blockComment(comment.text)
        default:
            preconditionFailure(UserFacing<StrictString, APILocalization>({ localization in
                switch localization {
                case .englishCanada:
                    return StrictString("Invalid direct child of trivia piece: \(type(of: syntax.child))")
                }
            }))
        }
    }

    public var syntax: TriviaPieceSyntax {
        return TriviaPieceSyntax.parse(self)
    }

    public var text: String {
        var result = ""
        write(to: &result)
        return result
    }
}
