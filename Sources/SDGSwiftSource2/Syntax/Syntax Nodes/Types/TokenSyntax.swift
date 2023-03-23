/*
 TokenSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax

  extension TokenSyntax {

    /// The extended syntax of the token.
    public var extended: ExtendedSyntax? {
      if case .stringLiteral(let source) = tokenKind {
        let result = StringLiteralSyntax(source: source)
        // #workaround(Skipping position determination.)
        return result
      } else {
        return nil
      }
    }
  }
#endif
