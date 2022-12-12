/*
 VariableDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SDGControlFlow
  import SDGLogic

  import SwiftSyntax

  extension VariableDeclSyntax {

    // MARK: - Accessor

    internal var keyword: TokenSyntax {
      return letOrVarKeyword
    }

    internal var accessors: Syntax? {
      return bindings.first?.accessor
    }

    // MARK: - APIDeclaration

    internal func name() -> VariableDeclSyntax {
      return SyntaxFactory.makeVariableDecl(
        attributes: nil,
        modifiers: nil,
        letOrVarKeyword: SyntaxFactory.makeToken(.varKeyword, presence: .missing),
        bindings: bindings.forVariableName()
      )
    }

    internal func identifierList() -> Set<String> {
      let identifiers = bindings.lazy.map { binding in
        return binding.pattern.flattenedForAPI().lazy.map { flattened in
          return flattened.identifier.identifier.text
        }
      }
      return Set(identifiers.joined())
    }
  }
#endif
