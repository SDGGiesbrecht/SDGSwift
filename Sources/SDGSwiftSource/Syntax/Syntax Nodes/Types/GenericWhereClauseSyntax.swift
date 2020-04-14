/*
 GenericWhereClauseSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.2.1, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  import SDGLogic

  import SwiftSyntax

  extension GenericWhereClauseSyntax: Mergeable {

    internal func normalized() -> GenericWhereClauseSyntax? {
      return SyntaxFactory.makeGenericWhereClause(
        whereKeyword: whereKeyword.generallyNormalizedAndMissingInsteadOfNil(
          leadingTrivia: .spaces(1),
          trailingTrivia: .spaces(1)
        ),
        requirementList: requirementList.normalized()
      )
    }

    // MARK: - Mergeable

    internal mutating func merge(with other: GenericWhereClauseSyntax) {
      var requirementList = self.requirementList
      requirementList.merge(with: other.requirementList)
      self = withRequirementList(requirementList)
    }
  }
#endif
