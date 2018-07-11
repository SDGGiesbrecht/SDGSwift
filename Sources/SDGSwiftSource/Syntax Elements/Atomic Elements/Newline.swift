/*
 Newline.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

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

    // #documentation(SyntaxElement.textFreedom)
    /// How much freedom the user has in choosing the text of the element.
    public override var textFreedom: TextFreedom {
        return .invariable
    }
}
