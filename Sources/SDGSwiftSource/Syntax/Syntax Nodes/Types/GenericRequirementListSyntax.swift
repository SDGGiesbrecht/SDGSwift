/*
 GenericRequirementListSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SDGControlFlow
  import SDGLogic
  import SDGMathematics

  import SwiftSyntax

  extension GenericRequirementListSyntax: Mergeable {

    internal func normalized() -> GenericRequirementListSyntax {
      var requirements = map({ $0.normalized(comma: true) }).sorted(
        by: GenericRequirementSyntax.arrangeGenericRequirements
      )
      if ¬requirements.isEmpty {
        let last = requirements.removeLast()
        requirements.append(last.normalized(comma: false))
      }
      return SyntaxFactory.makeGenericRequirementList(requirements)
    }

    // MARK: - Mergeable

    internal mutating func merge(with other: GenericRequirementListSyntax) {
      self = SyntaxFactory.makeGenericRequirementList(Array(self) + Array(other)).normalized()
    }
  }
#endif
