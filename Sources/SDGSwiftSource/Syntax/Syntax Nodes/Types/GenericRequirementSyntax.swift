/*
 GenericRequirementSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2020–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SDGMathematics

  import SwiftSyntax

  extension GenericRequirementSyntax {

    internal func normalized(comma: Bool) -> GenericRequirementSyntax {
      let normalizedBody: Syntax
      if let conformance = body.as(ConformanceRequirementSyntax.self) {
        normalizedBody = Syntax(conformance.normalized())
      } else if let sameType = body.as(SameTypeRequirementSyntax.self) {
        normalizedBody = Syntax(sameType.normalized())
      } else {  // @exempt(from: tests)
        warnUnidentified()
        normalizedBody = body
      }
      return SyntaxFactory.makeGenericRequirement(
        body: normalizedBody,
        trailingComma: comma ? SyntaxFactory.makeToken(.comma, trailingTrivia: .spaces(1)) : nil
      )
    }

    // #warkaround(SDGCornerstone 9.0.0, RawRepresentable only necessary because of SR‐15734 evasion.)
    private enum Group: Int, Comparable, OrderedEnumeration {
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
    internal static func arrangeGenericRequirements(
      lhs: GenericRequirementSyntax,
      rhs: GenericRequirementSyntax
    ) -> Bool {
      return (group(for: lhs), lhs.source()) < (group(for: rhs), rhs.source())
    }
  }
#endif
