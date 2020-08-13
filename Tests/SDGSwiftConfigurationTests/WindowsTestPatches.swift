/*
 WindowsTestPatches.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if os(Windows)

  import SDGText

  // #workaround(SDGCornerstone 5.4.1, Encounters segmentation fault.)
  func testCodableConformance<T>(
    of instance: T,
    uniqueTestName: StrictString,
    file: StaticString = #file,
    line: UInt = #line
  ) where T: Codable, T: Equatable {}
#endif
