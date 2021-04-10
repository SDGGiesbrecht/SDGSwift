/*
 AvailabilityVersionRestrictionSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax

  extension AvailabilityVersionRestrictionSyntax {

    internal func normalized() -> AvailabilityVersionRestrictionSyntax {
      return SyntaxFactory.makeAvailabilityVersionRestriction(
        platform: platform.generallyNormalizedAndMissingInsteadOfNil(trailingTrivia: .spaces(1)),
        version: version.normalized()
      )
    }
  }
#endif
