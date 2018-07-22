/*
 CodeFragmentSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

public class CodeFragmentSyntax : ExtendedSyntax {

    init(range: Range<String.ScalarView.Index>, in source: String) {
        self.context = source
        self.range = range
        let fragmentSource = String(source.scalars[range])
        let fragment = ExtendedTokenSyntax(text: fragmentSource, kind: .source)
        self.source = fragment

        super.init(children: [fragment])
    }

    // MARK: - Properties

    public let source: ExtendedTokenSyntax

    internal let context: String

    internal let range: Range<String.ScalarView.Index>

    /// The syntax of the source code contained in this token.
    public func syntax() throws -> [Syntax] {
        let parsed = try Syntax.parse(context)
        return syntax(of: parsed)
    }

    private func syntax(of node: Syntax) -> [Syntax] {
        let location = node.location(in: context)
        if location.overlaps(range) {
            if location ⊆ range {
                return [node]
            } else {
                return Array(node.children.map({ syntax(of: $0) }).joined())
            }
        } else {
            return []
        }
    }
}
