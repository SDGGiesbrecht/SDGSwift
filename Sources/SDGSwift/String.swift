/*
 String.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

extension String {

  public func _toIndex(line: Int, column: Int = 1) -> String.ScalarView.Index {
    let lines = self.lines
    let scalars = self.scalars
    let utf8 = self.utf8

    let lineInUTF8: String.UTF8View.Index = lines.index(lines.startIndex, offsetBy: line − 1)
      .samePosition(in: scalars).samePosition(in: utf8)!
    var utf8Index: String.UTF8View.Index = utf8.index(lineInUTF8, offsetBy: column − 1)
    var result: String.ScalarView.Index? = nil
    while result == nil {
      result = utf8Index.samePosition(in: scalars)
      if result == nil {
        // @exempt(from: tests)
        // Xcode sometimes erratically reports invalid offsets.
        // Rounding is better than trapping.
        utf8Index = utf8.index(before: utf8Index)
      }
    }
    return result!
  }
}
