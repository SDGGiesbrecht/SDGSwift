/*
 PatternBindingSyntax.swift

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

  extension PatternBindingSyntax {

    internal func flattenedForAPI() -> [PatternBindingSyntax] {
      return pattern.flattenedForAPI().map { (pattern, indexPath) in
        return SyntaxFactory.makePatternBinding(
          pattern: PatternSyntax(pattern),
          typeAnnotation: typeAnnotation?.normalizedForVariableBindingForAPIDeclaration(
            extractingFromIndexPath: indexPath
          ),
          initializer: nil,
          accessor: accessor,
          trailingComma: nil
        )
      }
    }

    internal func normalizedForVariableAPIDeclaration(
      accessor: AccessorBlockSyntax
    ) -> PatternBindingSyntax {
      return SyntaxFactory.makePatternBinding(
        pattern: pattern.normalizedVariableBindingForAPIDeclaration(),
        typeAnnotation: typeAnnotation?.normalizedForVariableBindingForAPIDeclaration(),
        initializer: nil,
        accessor: Syntax(accessor),
        trailingComma: nil
      )
    }

    internal func forOverloadPattern() -> PatternBindingSyntax {
      return SyntaxFactory.makePatternBinding(
        pattern: pattern.variableBindingForOverloadPattern(),
        typeAnnotation: nil,
        initializer: nil,
        accessor: nil,
        trailingComma: nil
      )
    }

    internal func forVariableName() -> PatternBindingSyntax {
      return SyntaxFactory.makePatternBinding(
        pattern: pattern.variableBindingForName(),
        typeAnnotation: nil,
        initializer: nil,
        accessor: nil,
        trailingComma: nil
      )
    }
  }
#endif
