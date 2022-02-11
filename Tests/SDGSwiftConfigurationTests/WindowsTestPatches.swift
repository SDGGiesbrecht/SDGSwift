/*
 WindowsTestPatches.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2020–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if PLATFORM_SUFFERS_SEGMENTATION_FAULTS

  import SDGText

  func testCodableConformance<T>(
    of instance: T,
    uniqueTestName: StrictString,
    file: StaticString = #filePath,
    line: UInt = #line
  ) where T: Codable, T: Equatable {}
#endif
