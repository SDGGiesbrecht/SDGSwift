/*
 SyntaxProtocol.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

import SDGSwiftSource
#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax
#endif

extension SyntaxProtocol {

  internal func smallestSubnode<P>(containing searchTerm: P) -> Syntax?
  where P: SDGCollections.Pattern, P.Element == Unicode.Scalar {
    return _smallestSubnode(containing: searchTerm)
  }
}
