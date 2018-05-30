/*
 StringLiteralText.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The text of a string literal.
public class StringLiteralText : AtomicSyntaxElement {

    // MARK: - Properties

    // [_Inherit Documentation: SyntaxElement.textFreedom_]
    /// How much freedom the user has in choosing the text of the element.
    public override var textFreedom: TextFreedom {
        return .arbitrary
    }
}
