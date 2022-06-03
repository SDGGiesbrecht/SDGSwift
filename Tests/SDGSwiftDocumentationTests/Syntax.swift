/*
 Syntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax
#endif

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  extension Syntax {

    func smallest<SyntaxNode>(
      _ type: SyntaxNode.Type,
      at location: SourceLocation,
      converter: SourceLocationConverter
    ) -> SyntaxNode? where SyntaxNode: SyntaxProtocol {
      if location ∉ sourceRange(converter: converter) {
        return nil
      }
      for child in children {
        if let valid = child.smallest(type, at: location, converter: converter) {
          return valid
        }
      }
      if let converted = self.as(type) {
        return converted
      }
      return nil
    }
  }
#endif
