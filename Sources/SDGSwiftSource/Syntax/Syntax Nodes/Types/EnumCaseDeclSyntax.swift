/*
 EnumCaseDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

  import SDGLogic

  import SwiftSyntax

  extension EnumCaseDeclSyntax {

    internal func identifierList() -> Set<String> {
      return Set(elements.lazy.map({ $0.identifier.text }))
    }
  }
