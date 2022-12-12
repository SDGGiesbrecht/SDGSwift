/*
 TypeSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SDGControlFlow
  import SDGLogic

  import SwiftSyntax

  extension TypeSyntax {

    // MARK: - Hidable

    internal var hidabilityIdentifier: TokenSyntax? {
      // Only used by extensions. Non‐extendable types are ignored.
      if let simple = self.as(SimpleTypeIdentifierSyntax.self) {
        return simple.name
      } else if let member = self.as(MemberTypeIdentifierSyntax.self) {
        return member.baseType.hidabilityIdentifier
      } else {  // @exempt(from: tests)
        warnUnidentified()
        return nil
      }
    }
  }
#endif
