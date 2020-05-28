/*
 RegressionTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGPersistence
import SDGVersioning

import SDGSwift

import XCTest

import SDGXCTestUtilities

import SDGSwiftTestUtilities

class RegressionTests: SDGSwiftTestUtilities.TestCase {

  func testDependencyWarnings() throws {
    // Untracked.

    #if !os(Windows)  // #workaround(Swift 5.2.4, No package manager on Windows yet.)
      try withMock(named: "Warnings") { package in
        #if !os(Android)  // #workaround(workspace version 0.32.4, Emulator lacks Git.)
          let build = try package.build().get()
          XCTAssert(SwiftCompiler.warningsOccurred(during: build))
        #endif
      }
      try withMock(named: "DependentOnWarnings", dependentOn: ["Warnings"]) { package in
        #if !os(Android)  // #workaround(workspace version 0.32.4, Emulator lacks Git.)
          let build = try package.build().get()
          XCTAssertFalse(SwiftCompiler.warningsOccurred(during: build))
        #endif
      }
    #endif
  }

  func testDynamicLinking() throws {
    // Untracked.

    #if !os(Windows)  // #workaround(Swift 5.2.4, No package manager on Windows yet.)
      try FileManager.default.withTemporaryDirectory(appropriateFor: nil) { moved in
        try withMockDynamicLinkedExecutable { mock in

          #if !os(Android)  // #workaround(workspace version 0.32.4, Emulator has no Swift.)
            XCTAssertEqual(
              try Package(url: mock.location).execute(
                .development,
                of: ["tool"],
                with: [],
                cacheDirectory: moved
              ).get(),
              "Hello, world!"
            )
            XCTAssertEqual(
              try Package(url: mock.location).execute(
                .version(Version(1, 0, 0)),
                of: ["tool"],
                with: [],
                cacheDirectory: moved
              ).get(),
              "Hello, world!"
            )
          #endif

          switch Package(url: mock.location).execute(
            .version(Version(1, 0, 0)),
            of: ["tool"],
            with: ["fail"],
            cacheDirectory: moved
          ) {
          case .success:
            XCTFail("Should have failed.")
          case .failure:
            break
          }
        }
      }
    #endif
  }

  func testIgnoredFilesCheckIsStable() throws {
    // Untracked.
    #if !os(Android)  // #workaround(workspace version 0.32.4, Emulator lacks Git.)
      #if !os(Windows)  // #workaround(Swift 5.2.4, Windows won’t have built it as a package.)
        let ignored = try thisRepository.ignoredFiles().get()
        let expected = thisRepository.location.appendingPathComponent(".build").path
        XCTAssert(ignored.contains(where: { $0.path == expected }))
      #endif
    #endif
  }
}
