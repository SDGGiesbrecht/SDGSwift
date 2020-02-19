/*
 UniquelyDeclaredOverloadableAPIElement.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
  import SwiftSyntax

  internal protocol UniquelyDeclaredOverloadableAPIElement: _OverloadableAPIElement,
    _UniquelyDeclaredSyntaxAPIElement
  where Declaration: OverloadableAPIDeclaration {}

  extension UniquelyDeclaredOverloadableAPIElement {

    // MARK: - OverloadableAPIElement

    internal func genericOverloadPattern() -> Syntax {
      return declaration.overloadPattern()
    }
  }
#endif
