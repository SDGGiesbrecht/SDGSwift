/*
 FunctionParameterListSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3.1, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  import SDGLogic
  import SDGCollections

  import SwiftSyntax

  extension FunctionParameterListSyntax {

    internal func normalizedForDeclaration(labelBehaviour: FunctionParameterSyntax.LabelBehaviour)
      -> FunctionParameterListSyntax
    {
      return SyntaxFactory.makeFunctionParameterList(
        map({ $0.normalizedForDeclaration(labelBehaviour: labelBehaviour) })
      )
    }

    internal func forOverloadPattern(labelBehaviour: FunctionParameterSyntax.LabelBehaviour)
      -> FunctionParameterListSyntax
    {
      return SyntaxFactory.makeFunctionParameterList(
        map({ $0.forOverloadPattern(labelBehaviour: labelBehaviour) })
      )
    }

    internal func forName(labelBehaviour: FunctionParameterSyntax.LabelBehaviour)
      -> FunctionParameterListSyntax
    {
      return SyntaxFactory.makeFunctionParameterList(
        map({ $0.forName(labelBehaviour: labelBehaviour) })
      )
    }

    internal func identifierList(labelBehaviour: FunctionParameterSyntax.LabelBehaviour) -> Set<
      String
    > {
      return reduce(into: Set<String>()) { $0 ∪= $1.identifierList(labelBehaviour: labelBehaviour) }
    }

    internal func normalizedForAssociatedValue() -> FunctionParameterListSyntax {
      return SyntaxFactory.makeFunctionParameterList(map({ $0.normalizedForAssociatedValue() }))
    }

    internal func forAssociatedValueName() -> FunctionParameterListSyntax {
      return SyntaxFactory.makeFunctionParameterList(map({ $0.forAssociatedValueName() }))
    }
  }
#endif
