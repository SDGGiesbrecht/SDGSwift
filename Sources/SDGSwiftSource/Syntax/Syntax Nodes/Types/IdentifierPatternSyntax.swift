/*
 IdentifierPatternSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SDGLogic

  import SwiftSyntax

  extension IdentifierPatternSyntax {

    internal var isHidden: Bool {
      let text = identifier.text
      return text.hasPrefix("_") == true
        ∧ text ≠ "_"  // @exempt(from: tests) Reachability unknown.
    }
  }
#endif
