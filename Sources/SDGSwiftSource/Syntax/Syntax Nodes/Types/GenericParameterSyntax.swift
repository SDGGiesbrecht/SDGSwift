/*
 GenericParameterSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.2.2, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  import SwiftSyntax

  extension GenericParameterSyntax {

    internal func normalizedForAPIDeclaration() -> (
      GenericParameterSyntax, ConformanceRequirementSyntax?
    ) {
      let normalizedName = self.name.generallyNormalizedAndMissingInsteadOfNil()
      let parameter = SyntaxFactory.makeGenericParameter(
        attributes: attributes?.normalizedForAPIDeclaration(),
        name: normalizedName,
        colon: nil,
        inheritedType: nil,
        trailingComma: trailingComma?.generallyNormalized(trailingTrivia: .spaces(1))
      )
      var requirement: ConformanceRequirementSyntax?
      if let conformance = inheritedType {
        requirement = SyntaxFactory.makeConformanceRequirement(
          leftTypeIdentifier: TypeSyntax(
            SyntaxFactory.makeSimpleTypeIdentifier(
              name: normalizedName,
              genericArgumentClause: nil
            )
          ),
          colon: SyntaxFactory.makeToken(
            .colon,
            leadingTrivia: .spaces(1),
            trailingTrivia: .spaces(1)
          ),
          rightTypeIdentifier: conformance.normalized()
        )
      }
      return (parameter, requirement)
    }
  }
#endif
