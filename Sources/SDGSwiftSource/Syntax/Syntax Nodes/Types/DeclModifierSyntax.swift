/*
 DeclModifierSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3.1, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  import SDGControlFlow
  import SDGMathematics

  import SwiftSyntax

  extension DeclModifierSyntax {

    internal func normalizedForAPIDeclaration(operatorFunction: Bool) -> DeclModifierSyntax? {
      func normalize() -> DeclModifierSyntax {
        return SyntaxFactory.makeDeclModifier(
          name: name.generallyNormalizedAndMissingInsteadOfNil(trailingTrivia: .spaces(1)),
          detailLeftParen: nil,
          detail: nil,
          detailRightParen: nil
        )
      }
      switch name.tokenKind {
      case .staticKeyword, .classKeyword:
        // Type membership.
        return operatorFunction ? nil : normalize()
      default:
        let conditionalKeyword = name.text
        switch conditionalKeyword {
        case "open":
          // External overridability.
          return normalize()
        case "final":
          // Internal overridability.
          return nil
        case "override":  // @exempt(from: tests) Filtered before it gets here.
          // Inheritance.
          return nil
        case "public", "internal", "fileprivate", "private":
          // Access control.
          return nil
        case "required":
          // Requirement.
          return normalize()
        case "convenience":
          // Designation.
          return normalize()
        case "mutating", "nonmutating":
          return normalize()
        case "indirect", "lazy":
          return nil
        case "weak", "unowned":
          return normalize()
        case "infix", "prefix", "postfix":
          // Operator position.
          return normalize()
        default:  // @exempt(from: tests)
          conditionalKeyword.warnUnidentified()
          return nil
        }
      }
    }

    private enum Group: OrderedEnumeration {
      case unknown
      case accessControl
      case requirement
      case designation
      case memoryManagement
      case classMembership
      case staticity
      case mutation
      case operatorPosition
    }
    private func group() -> Group {
      switch name.tokenKind {
      case .staticKeyword:
        return .staticity
      case .classKeyword:
        return .classMembership
      default:
        switch name.text {
        case "open", "public", "internal", "fileprivate", "private":
          return .accessControl
        case "required":  // @exempt(from: tests) Cannot appear with any other groups for sorting.
          return .requirement
        case "convenience":  // @exempt(from: tests) Never with any other groups for sorting.
          return .designation
        case "weak", "unowned":
          return .memoryManagement
        case "mutating", "nonmutating":
          return .mutation
        case "infix", "prefix", "postfix":  // @exempt(from: tests)
          // Cannot appear with any other groups for sorting.
          return .operatorPosition
        default:  // @exempt(from: tests)
          name.text.warnUnidentified()
          return .unknown
        }
      }
    }

    internal static func arrange(lhs: DeclModifierSyntax, rhs: DeclModifierSyntax) -> Bool {
      return (lhs.group(), lhs.name.text) < (rhs.group(), rhs.name.text)
    }

    internal func forOverloadPattern() -> DeclModifierSyntax? {
      switch name.tokenKind {
      case .staticKeyword:
        return self
      case .classKeyword:
        return withName(
          SyntaxFactory.makeToken(.staticKeyword, trailingTrivia: name.trailingTrivia)
        )
      default:
        switch name.text {
        case "open", "public", "internal", "fileprivate", "private":
          return nil
        case "required":
          return nil
        case "convenience":
          return nil
        case "weak", "unowned":
          return nil
        case "mutating", "nonmutating":
          return nil
        case "infix", "prefix", "postfix":
          return self
        default:  // @exempt(from: tests)
          name.text.warnUnidentified()
          return nil
        }
      }
    }
  }
#endif
