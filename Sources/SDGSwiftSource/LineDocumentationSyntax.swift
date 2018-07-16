/*
 LineDocumentationSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public class LineDocumentationSyntax : LineCommentSyntax {

    // MARK: - Class Properties

    internal override class var delimiter: TokenTriviaSyntax {
        return TokenTriviaSyntax(text: "///", kind: .lineDocumentationDelimiter)
    }

    internal override class var contentKind: TriviaTokenKind {
        return .documentationText
    }
}
