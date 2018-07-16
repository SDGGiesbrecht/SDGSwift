/*
 TokenTriviaSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A syntax node representing a single token.
///
/// This type is comparable to `TokenSyntax`, but represents syntax not handled by the `SwiftSyntax` module.
public class ExtendedTokenSyntax : ExtendedSyntax {

    // MARK: - Initialization

    internal init(text: String, kind: ExtendedTokenKind) {
        self._text = text
        self.kind = kind
        super.init(children: [])
    }

    // MARK: - Properties

    private let _text: String

    /// The kind of the token.
    public let kind: ExtendedTokenKind

    // MARK: - TextOutputStreamable

    public override func write<Target>(to target: inout Target) where Target : TextOutputStream {
        _text.write(to: &target)
    }
}
