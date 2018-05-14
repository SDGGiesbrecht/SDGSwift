/*
 Whitespace.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections

/// Whitespace.
public class Whitespace : AtomicSyntaxElement {

    // MARK: - Static Properties

    internal static let whitespaceCharacters: Set<Unicode.Scalar> = [
        // From https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/LexicalStructure.html#//apple_ref/doc/uid/TP40014097-CH30-ID410
        "\u{20}", // space
        "\u{A}", // “line feed”
        "\u{D}", // “carriage return”
        "\u{9}", // “horizontal tabulation”
        "\u{B}", // “vertical tabulation”
        "\u{C}", // “form feed”
        "\u{0}" // “null”
    ]

    // MARK: - Initialization

    internal convenience init?(unidentified: UnidentifiedSyntaxElement, in source: String) {
        if ¬source.scalars[unidentified.range].contains(where: { $0 ∉ Whitespace.whitespaceCharacters }) {
            self.init(range: unidentified.range)
        } else {
            return nil
        }
    }

    // MARK: - Properties

    // [_Inherit Documentation: SyntaxElement.textFreedom_]
    /// How much freedom the user has in choosing the text of the element.
    public override var textFreedom: TextFreedom {
        return .arbitrary
    }
}
