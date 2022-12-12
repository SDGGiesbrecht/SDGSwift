/*
 FunctionParameterSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SDGLogic

  import SwiftSyntax

  extension FunctionParameterSyntax {

    // MARK: - Names & Labels

    internal var internalName: TokenSyntax? {
      if secondName?.isPresent == true {
        return secondName
      } else {
        return firstName
      }
    }

    // MARK: - Associated Values

    internal func forAssociatedValueName() -> FunctionParameterSyntax {
      return SyntaxFactory.makeFunctionParameter(
        attributes: nil,
        firstName: SyntaxFactory.makeToken(.wildcardKeyword),
        secondName: nil,
        colon: nil,
        type: nil,
        ellipsis: ellipsis,
        defaultArgument: nil,
        trailingComma: trailingComma
      )
    }
  }
#endif
