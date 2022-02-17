/*
 Int.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2021–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

// #workaround(Swift 5.5.2, This overload is redundant, but dodges a segmentation fault caused by the compiler.)
extension Int {
  static prefix func − (operand: Int) -> Int {
    return -operand  // @exempt(from: unicode)
  }
}
