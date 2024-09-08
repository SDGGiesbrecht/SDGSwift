/*
 String.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGText

extension String {

  /// Returns the index corresponding to a particular scalar offset.
  ///
  /// - Precondition: The offset is within the string’s bounds.
  ///
  /// - Parameters:
  ///   - offset: The scalar offset.
  public func index(of offset: ScalarOffset) -> String.ScalarView.Index {
    let scalars = self.scalars
    return scalars.index(scalars.startIndex, offsetBy: offset.offset)
  }
  /// Returns the indices corresponding to particular scalar offsets.
  ///
  /// - Precondition: The offsets are within the string’s bounds.
  ///
  /// - Parameters:
  ///   - offsets: The scalar offsets.
  public func indices(of offsets: Range<ScalarOffset>) -> Range<String.ScalarView.Index> {
    let lower = index(of: offsets.lowerBound)
    let length = offsets.upperBound − offsets.lowerBound
    let upper = scalars.index(lower, offsetBy: length)
    return lower..<upper
  }

  /// Returns the scalar offset corresponding to a particular index.
  ///
  /// - Precondition: The index represents a valid scalar boundary in the string.
  ///
  /// - Parameters:
  ///   - index: The index.
  public func offset(of index: String.ScalarView.Index) -> ScalarOffset {
    let scalars = self.scalars
    return ScalarOffset(offset: scalars.distance(from: scalars.startIndex, to: index))
  }
  /// Returns the scalar offsets corresponding to particular indices.
  ///
  /// - Precondition: The indices represent valid scalar boundaries in the string.
  ///
  /// - Parameters:
  ///   - indices: The indices.
  public func offsets(of indices: Range<String.ScalarView.Index>) -> Range<ScalarOffset> {
    let lower = offset(of: indices.lowerBound)
    let length = scalars.distance(from: indices.lowerBound, to: indices.upperBound)
    let upper = lower + length
    return lower..<upper
  }

  #if !PLATFORM_LACKS_FOUNDATION_PROCESS
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
  #endif

  internal func lastLine() -> String {
    if let last = self.lines.last {
      return String(String.UnicodeScalarView(last.line))
    } else {
      // @exempt(from: tests) Unreachable.
      return ""
    }
  }
}
