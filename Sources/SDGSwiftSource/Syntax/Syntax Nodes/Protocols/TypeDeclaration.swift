/*
 TypeDeclaration.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SDGLogic
  import SDGCollections

  import SwiftSyntax

  internal protocol TypeDeclaration: Generic, Inheritor {
    var identifier: TokenSyntax { get }

    func name() -> Self
  }

  extension TypeDeclaration {

    internal func identifierList() -> Set<String> {
      var result: Set<String> = [identifier.text]
      if let genericParameters = genericParameterClause {
        result ∪= genericParameters.identifierList()
      }
      return result
    }
  }
#endif
