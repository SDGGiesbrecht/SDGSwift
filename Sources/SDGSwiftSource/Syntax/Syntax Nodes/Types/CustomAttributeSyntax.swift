/*
 CustomAttributeSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax

  extension CustomAttributeSyntax {

    internal func normalizedForAPIDeclaration() -> CustomAttributeSyntax {
      return SyntaxFactory.makeCustomAttribute(
        atSignToken: atSignToken.generallyNormalizedAndMissingInsteadOfNil(),
        attributeName: attributeName.normalized(),
        leftParen: nil,
        argumentList: nil,
        rightParen: nil
      ).withTrailingTrivia(.spaces(1))
    }
  }
#endif
