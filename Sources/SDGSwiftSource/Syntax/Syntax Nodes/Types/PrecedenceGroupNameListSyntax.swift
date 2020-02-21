/*
 PrecedenceGroupNameListSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
  import SDGLogic

  import SwiftSyntax

  extension PrecedenceGroupNameListSyntax {

    internal func normalizedForAPIDeclaration() -> PrecedenceGroupNameListSyntax {
      let normalized = map({ $0.normalizedForAPIDeclaration(comma: true) })
      var sorted = normalized.sorted(by: PrecedenceGroupNameElementSyntax.arrange)
      if ¬sorted.isEmpty {
        let last = sorted.removeLast()
        sorted.append(last.normalizedForAPIDeclaration(comma: false))
      }
      return SyntaxFactory.makePrecedenceGroupNameList(sorted)
    }
  }
#endif
