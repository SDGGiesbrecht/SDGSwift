/*
 TokenTriviaSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A trivia syntax node representing a single token.
public class TokenTriviaSyntax : TriviaSyntax {

    // MARK: - Initialization

    internal init(text: String, kind: TriviaTokenKind) {
        self._text = text
        self.kind = kind
        super.init(children: [])
    }

    // MARK: - Properties

    private let _text: String

    /// The kind of the token.
    public let kind: TriviaTokenKind

    // MARK: - TextOutputStreamable

    public override func write<Target>(to target: inout Target) where Target : TextOutputStream {
        _text.write(to: &target)
    }
}
