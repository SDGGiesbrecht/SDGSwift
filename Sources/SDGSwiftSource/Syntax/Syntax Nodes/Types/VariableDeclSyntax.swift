/*
 VariableDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

  import SDGControlFlow
  import SDGLogic

  import SwiftSyntax

  extension VariableDeclSyntax {

    // MARK: - APIDeclaration

    internal func identifierList() -> Set<String> {
      let identifiers = bindings.lazy.map { binding in
        return binding.pattern.flattenedForAPI().lazy.map { flattened in
          return flattened.identifier.identifier.text
        }
      }
      return Set(identifiers.joined())
    }
  }
