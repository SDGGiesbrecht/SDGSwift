/*
 ParameterClauseSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax

  extension ParameterClauseSyntax {

    internal func normalizedForDeclaration(labelBehaviour: FunctionParameterSyntax.LabelBehaviour)
      -> ParameterClauseSyntax
    {
      return SyntaxFactory.makeParameterClause(
        leftParen: leftParen.generallyNormalizedAndMissingInsteadOfNil(),
        parameterList: parameterList.normalizedForDeclaration(labelBehaviour: labelBehaviour),
        rightParen: rightParen.generallyNormalizedAndMissingInsteadOfNil()
      )
    }

    internal func forOverloadPattern(labelBehaviour: FunctionParameterSyntax.LabelBehaviour)
      -> ParameterClauseSyntax
    {
      return SyntaxFactory.makeParameterClause(
        leftParen: leftParen.generallyNormalizedAndMissingInsteadOfNil(),
        parameterList: parameterList.forOverloadPattern(labelBehaviour: labelBehaviour),
        rightParen: rightParen.generallyNormalizedAndMissingInsteadOfNil()
      )
    }

    internal func forName(
      labelBehaviour: FunctionParameterSyntax.LabelBehaviour
    ) -> ParameterClauseSyntax {
      return SyntaxFactory.makeParameterClause(
        leftParen: leftParen.generallyNormalizedAndMissingInsteadOfNil(),
        parameterList: parameterList.forName(labelBehaviour: labelBehaviour),
        rightParen: rightParen.generallyNormalizedAndMissingInsteadOfNil()
      )
    }

    internal func identifierList(
      labelBehaviour: FunctionParameterSyntax.LabelBehaviour
    ) -> Set<String> {
      return parameterList.identifierList(labelBehaviour: labelBehaviour)
    }

    internal func normalizedForAssociatedValue() -> ParameterClauseSyntax {
      return SyntaxFactory.makeParameterClause(
        leftParen: leftParen.generallyNormalizedAndMissingInsteadOfNil(),
        parameterList: parameterList.normalizedForAssociatedValue(),
        rightParen: rightParen.generallyNormalizedAndMissingInsteadOfNil()
      )
    }

    internal func forAssociatedValueName() -> ParameterClauseSyntax {
      return SyntaxFactory.makeParameterClause(
        leftParen: leftParen,
        parameterList: parameterList.forAssociatedValueName(),
        rightParen: rightParen
      )
    }
  }
#endif
