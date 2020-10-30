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

    // #workaround(Swift 5.3, SwiftPM won’t compile.)
    #if !(os(Windows) || os(Android))
      try withDefaultMockRepository { repository in
        let file = "Validate (macOS).command"
        let escaped = "Validate\u{5C} (macOS).command"
        try escaped.save(to: repository.location.appendingPathComponent(".gitignore"))
        try "".save(to: repository.location.appendingPathComponent(file))
        #if !os(Android)  // #workaround(workspace version 0.35.2, Emulator lacks Git.)
          let ignored = try thisRepository.ignoredFiles().get()
          XCTAssert(
            ignored.contains(where: { $0.lastPathComponent == file }),
            "\(ignored.map({ $0.path }))"
          )
        #endif
      }
    #endif
  }
}
