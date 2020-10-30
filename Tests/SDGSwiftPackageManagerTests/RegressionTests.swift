/*
 RegressionTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGPersistence

import XCTest

import SDGSwiftTestUtilities

class RegressionTests: SDGSwiftTestUtilities.TestCase {

  func testIgnoredFilesPreserveSpecialCharacters() throws {
    // Untracked.

    try withDefaultMockRepository { repository in
      let file = "Validate (macOS).command"
      let escaped = "Validate\u{5C} (macOS).command"
      try escaped.save(to: repository.location.appendingPathComponent(".gitignore"))
      try "".save(to: repository.location.appendingPathComponent(file))
      #if !os(Android)  // #workaround(workspace version 0.35.2, Emulator lacks Git.)
        XCTAssert(
          try thisRepository.ignoredFiles().get()
            .contains(where: { $0.lastPathComponent == file })
        )
      #endif
    }
  }
}
