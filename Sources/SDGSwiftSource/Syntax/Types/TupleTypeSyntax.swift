/*
 TupleTypeSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension TupleTypeSyntax {

    internal func normalized(extractingFromIndexPath indexPath: [Int] = []) -> TypeSyntax {
        if let index = indexPath.first,
            elements.indices.contains(index) {
            return elements[index].type.normalized(extractingFromIndexPath: Array(indexPath.dropFirst()))
        }

        if elements.isEmpty {
            return SyntaxFactory.makeSimpleTypeIdentifier(
                name: SyntaxFactory.makeToken(.identifier("Void")),
                genericArgumentClause: nil)
        } else {
            return SyntaxFactory.makeTupleType(
                leftParen: leftParen.generallyNormalizedAndMissingInsteadOfNil(),
                elements: elements.normalized(),
                rightParen: rightParen.generallyNormalizedAndMissingInsteadOfNil())
        }
    }
}
