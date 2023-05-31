/*
 SourceRange.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(This file is dead, remove it when refactoring is complete.)

import SDGLogic
import SDGMathematics
import SDGCollections

  import SwiftSyntax

  extension SourceRange: SetDefinition {

    public typealias Element = SourceLocation  // @exempt(from: accessControl)

    public static func ∋ (  // @exempt(from: accessControl)
      precedingValue: SourceRange,
      followingValue: SourceLocation
    ) -> Bool {
      return precedingValue.start.offset ≤ followingValue.offset ∧ precedingValue.end.offset
        > followingValue.offset
    }
  }
