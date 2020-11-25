/*
 String.ScalarOffset.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension String {

  /// An offset into a String’s scalar view.
  ///
  /// An offset produced by one string is valid in any string that contains the same scalars, which is not true of a raw string index.
  public struct ScalarOffset: Comparable {

    // MARK: - Properties

    internal let offset: Int

    // MARK: - Comparable

    public static func < (lhs: String.ScalarOffset, rhs: String.ScalarOffset) -> Bool {
      return lhs.offset < rhs.offset
    }
  }
}
