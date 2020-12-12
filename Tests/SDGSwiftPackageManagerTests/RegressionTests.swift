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

    // #workaround(Swift 5.3.1, SwiftPM won’t compile.)
    #if !(os(Windows) || os(WASI) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
      for (file, escaped) in [
        ("Validate (macOS).command", "Validate\u{5C} (macOS).command"),
        ("Prüfen (Linux).sh".decomposedStringWithCanonicalMapping, "Pr*fen\u{5C} (Linux).sh"),
        ("Prüfen (Linux).sh".precomposedStringWithCanonicalMapping, "Pr*fen\u{5C} (Linux).sh"),
      ] {
        #if !(os(tvOS) || os(iOS) || os(watchOS))
          try withDefaultMockRepository { repository in
            try escaped.save(to: repository.location.appendingPathComponent(".gitignore"))
            try "".save(to: repository.location.appendingPathComponent(file))
            #if !os(Android)  // #workaround(workspace version 0.35.2, Emulator lacks Git.)
              let ignored = try repository.ignoredFiles().get()
              XCTAssert(
                ignored.contains(where: { $0.lastPathComponent == file }),
                "“\(file)” missing: \(ignored.map({ $0.path }))"
              )
            #endif
          }
        #endif
      }
    #endif
  }
}
