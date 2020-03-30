/*
 GenericRequirementListSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
  import SDGControlFlow
  import SDGLogic
  import SDGMathematics

  import SwiftSyntax

  extension GenericRequirementListSyntax: Mergeable {

    internal func normalized() -> GenericRequirementListSyntax {
      var requirements = map({ $0.normalizedGenericRequirement(comma: true) }).sorted(
        by: GenericRequirementListSyntax.arrangeGenericRequirements
      )
      if ¬requirements.isEmpty {
        let last = requirements.removeLast()
        requirements.append(last.normalizedGenericRequirement(comma: false))
      }
      return SyntaxFactory.makeGenericRequirementList(requirements)
    }

    private enum Group: OrderedEnumeration {
      case conformance
      case sameType
      case unknown
    }
    private static func group(for requirement: GenericRequirementSyntax) -> Group {
      if requirement.body.is(ConformanceRequirementSyntax.self) {
        return .conformance
      } else if requirement.body.is(SameTypeRequirementSyntax.self) {
        return .sameType
      } else {  // @exempt(from: tests)
        requirement.warnUnidentified()
        return .unknown
      }
    }
    private static func arrangeGenericRequirements(lhs: GenericRequirementSyntax, rhs: GenericRequirementSyntax) -> Bool {
      return (group(for: lhs), lhs.source()) < (group(for: rhs), rhs.source())
    }

    // MARK: - Mergeable

    internal mutating func merge(with other: GenericRequirementListSyntax) {
      self = SyntaxFactory.makeGenericRequirementList(Array(self) + Array(other)).normalized()
    }
  }
#endif
