/*
 FunctionSignatureSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax

  extension FunctionSignatureSyntax {

    internal func forOverloadPattern(labelBehaviour: FunctionParameterSyntax.LabelBehaviour)
      -> FunctionSignatureSyntax
    {
      return SyntaxFactory.makeFunctionSignature(
        input: input.forOverloadPattern(labelBehaviour: labelBehaviour),
        asyncOrReasyncKeyword: nil,
        throwsOrRethrowsKeyword: nil,
        output: nil
      )
    }

    internal func forName(labelBehaviour: FunctionParameterSyntax.LabelBehaviour)
      -> FunctionSignatureSyntax
    {
      return SyntaxFactory.makeFunctionSignature(
        input: input.forName(labelBehaviour: labelBehaviour),
        asyncOrReasyncKeyword: nil,
        throwsOrRethrowsKeyword: nil,
        output: nil
      )
    }

    internal func identifierList(
      labelBehaviour: FunctionParameterSyntax.LabelBehaviour
    ) -> Set<String> {
      return input.identifierList(labelBehaviour: labelBehaviour)
    }
  }
#endif
