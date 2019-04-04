/*
 FunctionSignatureSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension FunctionSignatureSyntax {

    internal func normalizedForAPIDeclaration(labelBehaviour: FunctionParameterSyntax.LabelBehaviour) -> FunctionSignatureSyntax {

        // #workaround(SwiftSyntax 0.50000.0, Prevents invalid index use by SwiftSyntax.)
        var output = self.output
        if output?.source() == "" {
            output = nil
        }

        return SyntaxFactory.makeFunctionSignature(
            input: input.normalizedForDeclaration(labelBehaviour: labelBehaviour),
            throwsOrRethrowsKeyword: throwsOrRethrowsKeyword?.generallyNormalized(leadingTrivia: .spaces(1)),
            output: output?.normalizedForFunctionDeclaration())
    }

    internal func forOverloadPattern(labelBehaviour: FunctionParameterSyntax.LabelBehaviour) -> FunctionSignatureSyntax {
        return SyntaxFactory.makeFunctionSignature(
            input: input.forOverloadPattern(labelBehaviour: labelBehaviour),
            throwsOrRethrowsKeyword: nil,
            output: nil)
    }

    internal func forName(labelBehaviour: FunctionParameterSyntax.LabelBehaviour) -> FunctionSignatureSyntax {
        return SyntaxFactory.makeFunctionSignature(
            input: input.forName(labelBehaviour: labelBehaviour),
            throwsOrRethrowsKeyword: nil,
            output: nil)
    }

    internal func identifierList(labelBehaviour: FunctionParameterSyntax.LabelBehaviour) -> Set<String> {
        return input.identifierList(labelBehaviour: labelBehaviour)
    }
}
