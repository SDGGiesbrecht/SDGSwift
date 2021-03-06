/*
 GenericParameterListSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SDGLogic

  import SwiftSyntax

  extension GenericParameterListSyntax {

    internal func normalizedForAPIDeclaration() -> (
      GenericParameterListSyntax, GenericRequirementListSyntax?
    ) {
      var parameters: [GenericParameterSyntax] = []
      var requirements: [GenericRequirementSyntax] = []
      for parameter in self {
        let (parameter, conformance) = parameter.normalizedForAPIDeclaration()
        parameters.append(parameter)
        if let requirement = conformance {
          requirements.append(
            SyntaxFactory.makeGenericRequirement(
              body: Syntax(requirement),
              trailingComma: nil
            )
          )
        }
      }
      return (
        SyntaxFactory.makeGenericParameterList(parameters),
        requirements.isEmpty
          ? nil : SyntaxFactory.makeGenericRequirementList(requirements).normalized()
      )
    }
  }
#endif
