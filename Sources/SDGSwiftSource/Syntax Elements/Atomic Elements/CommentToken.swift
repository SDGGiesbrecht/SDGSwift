/*
 CommentToken.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A start or end token of a comment.
public class CommentToken : AtomicSyntaxElement {

    // MARK: - Properties

    // #documentation(SyntaxElement.textFreedom)
    /// How much freedom the user has in choosing the text of the element.
    public override var textFreedom: TextFreedom {
        return .invariable
    }
}
