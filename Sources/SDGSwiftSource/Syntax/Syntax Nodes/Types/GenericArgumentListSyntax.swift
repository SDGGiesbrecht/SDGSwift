/*
 GenericArgumentListSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3.2, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
  import SDGLogic

  import SwiftSyntax

  extension GenericArgumentListSyntax {

    internal func normalized() -> GenericArgumentListSyntax {
      return SyntaxFactory.makeGenericArgumentList(map({ $0.normalized() }))
    }
  }
#endif
