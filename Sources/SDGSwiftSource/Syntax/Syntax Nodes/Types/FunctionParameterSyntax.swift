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

    internal enum LabelBehaviour {

      case function
      case `operator`
      case `subscript`

      internal var hasLabelByDefault: Bool {
        switch self {
        case .function:
          return true
        case .operator, .subscript:
          return false
        }
      }
    }

    internal func externalLabel(labelBehaviour: LabelBehaviour) -> TokenSyntax? {
      switch labelBehaviour {
      case .function:
        return firstName
      case .operator:
        return nil
      case .subscript:
        if secondName?.isPresent == true {
          return firstName
        } else {
          return nil
        }
      }
    }

    internal var internalName: TokenSyntax? {
      if secondName?.isPresent == true {
        return secondName
      } else {
        return firstName
      }
    }

    // MARK: - API

    internal func forName(labelBehaviour: LabelBehaviour) -> FunctionParameterSyntax {
      return SyntaxFactory.makeFunctionParameter(
        attributes: nil,
        firstName: externalLabel(labelBehaviour: labelBehaviour)
          ?? SyntaxFactory.makeToken(.wildcardKeyword),
        secondName: nil,
        colon: SyntaxFactory.makeToken(.colon),
        type: nil,
        ellipsis: nil,
        defaultArgument: nil,
        trailingComma: nil
      )
    }

    internal func identifierList(labelBehaviour: LabelBehaviour) -> Set<String> {
      var result: Set<String> = []
      if let label = externalLabel(labelBehaviour: labelBehaviour) {
        result.insert(label.text)
      }
      return result
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
