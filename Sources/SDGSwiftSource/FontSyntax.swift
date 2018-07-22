/*
 FontSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public class FontSyntax : MarkdownSyntax {

    internal init(node: cmark_node, in documentation: String, delimiter: String) {
        super.init(node: node, in: documentation, precedingChildren: [ExtendedTokenSyntax(text: delimiter, kind: .fontModificationDelimiter)], followingChildren: [ExtendedTokenSyntax(text: delimiter, kind: .fontModificationDelimiter)])
    }
}
