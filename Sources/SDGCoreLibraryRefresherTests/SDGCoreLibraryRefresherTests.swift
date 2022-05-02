/*
 SDGCoreLibraryRefresherTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

final class SDGCoreLibraryRefresherTests: XCTestCase {
  
  // Fix the spelling of “test” and run the test to refresh the core library information.
  func testCoreLibraryRefresher() throws {
    try CoreLibraryRefresher.main()
  }
}
