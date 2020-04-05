/*
 AttributeSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(workspace version 0.32.0, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(Android))
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

    internal func normalizedForAPIDeclaration() -> AttributeSyntax? {
      let attribute = attributeName.text
      if attribute.hasPrefix("_") {
        // @exempt(from: tests) Currently unreachable because SwiftSyntax does not properly detect these in 0.40200.0).
        return nil
      }

      switch attribute {
      case "available":
        // Availability
        return normalized()
      case "escaping", "autoclosure", "discardableResult":
        // Call site
        return normalized()
      case "propertyWrapper":
        // Usable as a property wrapper
        return normalized()
      case "objc", "nonobjc", "objcMembers":
        // Objective‐C interface
        return normalized()
      case "IBOutlet", "IBDesignable", "IBInspectable", "GKInspectable":
        // Xcode interface
        return normalized()

      case "inlinable", "usableFromInline", "inline", "dynamicMemberLookup", "convention":
        // Implementation details
        return nil
      case "NSCopying", "NSManaged":
        // Objective‐C implementation details
        return SyntaxFactory.makeAttribute(
          atSignToken: SyntaxFactory.makeToken(.atSign),
          attributeName: SyntaxFactory.makeToken(
            .contextualKeyword("objc"),
            trailingTrivia: .spaces(1)
          ),
          leftParen: nil,
          argument: nil,
          rightParen: nil,
          tokenList: nil
        )
      case "testable":  // @exempt(from: tests)
        // Not relevant to API symbols
        return nil
      case "NSApplicationMain", "UIApplicationMain":  // @exempt(from: tests)
        // Not relevant to API
        return nil
      case "requires_stored_property_inits", "warn_unqualified_access":  // @exempt(from: tests)
        // Source checks
        return nil
      case "frozen":  // @exempt(from: tests)
        // Not relevant outside library evolution mode.
        return nil

      default:  // @exempt(from: tests)
        attribute.warnUnidentified()
        return nil
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

    private enum Group: OrderedEnumeration {
      case unknown
      case availability
      case interfaceBuilder
      case objectiveC
      case discardability
      case escapability
      case autoclosure
    }
    private func group() -> Group {
      switch attributeName.text {
      case "available":
        return .availability
      case "escaping":
        return .escapability
      case "autoclosure":
        return .autoclosure
      case "discardableResult":
        return .discardability
      case "objc", "nonobjc", "objcMembers":
        return .objectiveC
      case "IBOutlet", "IBDesignable", "IBInspectable", "GKInspectable":
        // Objective‐C implementation details
        return .interfaceBuilder
      default:  // @exempt(from: tests)
        attributeName.text.warnUnidentified()
        return .unknown
      }
    }

    internal static func arrange(lhs: AttributeSyntax, rhs: AttributeSyntax) -> Bool {
      return (lhs.group(), lhs.attributeName.text) < (rhs.group(), rhs.attributeName.text)
    }
  }
#endif
