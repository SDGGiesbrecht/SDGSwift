/*
 DocumentationAsterism.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An asterism in symbol documentation.
public class DocumentationAsterism : AtomicSyntaxElement {

    // MARK: - Properties

    // #documentation(SyntaxElement.textFreedom)
    /// How much freedom the user has in choosing the text of the element.
    public override var textFreedom: TextFreedom {
        return .invariable
    }
}
