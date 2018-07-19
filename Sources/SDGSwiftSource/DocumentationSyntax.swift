/*
 DocumentationSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGCMarkShims

public class DocumentationSyntax : MarkdownSyntax {

    // MARK: - Initialization

    internal init(source: String) {
        var cSource = source.cString(using: .utf8)!
        cSource.removeLast() // Remove trailing NULL.
        let tree = cmark_parse_document(cSource, cSource.count, CMARK_OPT_DEFAULT)
        defer { cmark_node_free(tree) }
        super.init(node: tree)
    }
}
