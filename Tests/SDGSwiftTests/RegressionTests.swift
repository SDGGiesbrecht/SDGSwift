/*
 RegressionTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

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

    #if !PLATFORM_LACKS_FOUNDATION_FILE_MANAGER
      #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
        try withMock(named: "Warnings") { package in
          #if !PLATFORM_LACKS_GIT
            let build = try package.build().get()
            XCTAssert(SwiftCompiler.warningsOccurred(during: build))
          #endif
        }
        try withMock(named: "DependentOnWarnings", dependentOn: ["Warnings"]) { package in
          #if !PLATFORM_LACKS_GIT
            let build = try package.build().get()
            XCTAssertFalse(SwiftCompiler.warningsOccurred(during: build))
          #endif
        }
      #endif
    #endif
  }

  func testDynamicLinking() throws {
    // Untracked.

    #if !PLATFORM_LACKS_FOUNDATION_FILE_MANAGER
      try FileManager.default.withTemporaryDirectory(appropriateFor: nil) { moved in
        try withMockDynamicLinkedExecutable { mock in
          #if !PLATFORM_LACKS_FOUNDATION_PROCESS

            #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
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
          #endif
        }
      }
    #endif
  }

  func testIgnoredFilesCheckIsStable() throws {
    // Untracked.

    #if !PLATFORM_LACKS_FOUNDATION_PROCESS
      #if !PLATFORM_LACKS_GIT
        let ignored = try thisRepository.ignoredFiles().get()
        let expected = thisRepository.location.appendingPathComponent(".build").path
        XCTAssert(ignored.contains(where: { $0.path == expected }))
      #endif
    #endif
  }
}
