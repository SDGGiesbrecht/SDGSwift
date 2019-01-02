/*
 PrecedenceGroupAttributeListSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

extension PrecedenceGroupAttributeListSyntax {

    internal enum PrecedenceAttributeGroup : OrderedEnumeration {
        case before
        case after
        case associativity
        case unknown
    }

    internal func normalizedForAPIDeclaration() -> PrecedenceGroupAttributeListSyntax {
        let normalized = map({ $0.normalizedPrecedenceAttribute() })
        let sorted = normalized.sorted(by: PrecedenceGroupAttributeListSyntax.arrangePrecedenceAttributes)
        return SyntaxFactory.makePrecedenceGroupAttributeList(sorted)
    }
}
