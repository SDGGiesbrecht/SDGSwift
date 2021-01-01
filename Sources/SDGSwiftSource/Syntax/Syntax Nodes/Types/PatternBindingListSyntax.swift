/*
 PatternBindingListSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3.1, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
  import SwiftSyntax

  extension PatternBindingListSyntax {

    internal func flattenedForAPI() -> [PatternBindingListSyntax] {
      var result: [PatternBindingListSyntax] = []
      for binding in self {
        for flattened in binding.flattenedForAPI() {
          result.append(SyntaxFactory.makePatternBindingList([flattened]))
        }
      }
      return result
    }

    internal func normalizedForVariableAPIDeclaration(accessor: AccessorBlockSyntax)
      -> PatternBindingListSyntax
    {
      return SyntaxFactory.makePatternBindingList(
        map({ $0.normalizedForVariableAPIDeclaration(accessor: accessor) })
      )
    }

    internal func forVariableOverloadPattern() -> PatternBindingListSyntax {
      return SyntaxFactory.makePatternBindingList(map({ $0.forOverloadPattern() }))
    }

    internal func forVariableName() -> PatternBindingListSyntax {
      return SyntaxFactory.makePatternBindingList(map({ $0.forVariableName() }))
    }
  }
#endif
