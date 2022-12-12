/*
 AttributeSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SDGControlFlow
  import SDGMathematics
  import SDGCollections

  import SwiftSyntax

  extension AttributeSyntax {

    private static let absenceIndicators = Set(["unavailable", "deprecated", "obsoleted"])
    internal func indicatesAbsence() -> Bool {
      switch attributeName.text {
      case "available":
        guard let arguments = argument?.as(AvailabilitySpecListSyntax.self) else {
          return false  // @exempt(from: tests) Should never occur.
        }
        return arguments.contains(where: { argument in
          if let token = argument.entry.as(TokenSyntax.self),
            token.text ∈ AttributeSyntax.absenceIndicators
          {
            return true
          }
          if let labelled = argument.entry.as(AvailabilityLabeledArgumentSyntax.self),
            labelled.label.text ∈ AttributeSyntax.absenceIndicators
          {
            return true
          }
          return false
        })
      default:
        return false
      }
    }

    private func normalized() -> AttributeSyntax {
      if let argument = self.argument {
        return SyntaxFactory.makeAttribute(
          atSignToken: atSignToken.generallyNormalizedAndMissingInsteadOfNil(),
          attributeName: attributeName.generallyNormalizedAndMissingInsteadOfNil(),
          leftParen: leftParen?.generallyNormalized(),
          argument: argument.normalizedAttributeArgument(),
          rightParen: rightParen?.generallyNormalized(trailingTrivia: .spaces(1)),
          tokenList: nil
        )
      } else {
        return SyntaxFactory.makeAttribute(
          atSignToken: atSignToken.generallyNormalizedAndMissingInsteadOfNil(),
          attributeName: attributeName.generallyNormalizedAndMissingInsteadOfNil(
            trailingTrivia: .spaces(1)
          ),
          leftParen: nil,
          argument: nil,
          rightParen: nil,
          tokenList: nil
        )
      }
    }

    // #warkaround(SDGCornerstone 9.0.0, RawRepresentable only necessary because of SR‐15734 evasion.)
    private enum Group: Int, Comparable, OrderedEnumeration {
      case unknown
      case availability
      case interfaceBuilder
      case objectiveC
      case discardability
      case escapability
      case autoclosure
    }
  }
#endif
