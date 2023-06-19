/*
 APITests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGText
import SDGPersistence
import SDGLocalization

import SDGSwift
import SDGSwiftPackageManager

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
  import PackageModel
  import Workspace
#endif

import SDGSwiftLocalizations

import XCTest

import SDGLocalizationTestUtilities
import SDGPersistenceTestUtilities
import SDGXCTestUtilities

import SDGSwiftTestUtilities

class APITests: SDGSwiftTestUtilities.TestCase {

  func testChangeDetection() throws {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
      try withDefaultMockRepository { mock in
        try "...".save(to: mock.location.appendingPathComponent("File.md"))
        XCTAssertNotEqual(try mock.uncommittedChanges().get(), "", "Change unnoticed.")
      }
    #endif
  }

  func testErrors() {
    struct StandInError: PresentableError {
      func presentableDescription() -> StrictString {
        return "[...]"
      }
    }
    testCustomStringConvertibleConformance(
      of: PackageRepository.InitializationError.gitError(
        .locationError(.unavailable(versionConstraints: "..."))
      ),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Git Unavailable",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: PackageRepository.InitializationError.packageManagerError(StandInError()),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Package Manager",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: SwiftCompiler.CoverageReportingError.foundationError(StandInError()),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Foundation",
      overwriteSpecificationInsteadOfFailing: false
    )
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
      testCustomStringConvertibleConformance(
        of: SwiftCompiler.PackageLoadingError.packageManagerError(StandInError()),
        localizations: InterfaceLocalization.self,
        uniqueTestName: "Package Manager",
        overwriteSpecificationInsteadOfFailing: false
      )
    #endif
  }

  func testIgnoredFileDetection() {
    #if !PLATFORM_LACKS_GIT
      XCTAssert(
        try thisRepository.ignoredFiles().get()
          .contains(where: { $0.lastPathComponent == ".build" })
      )
    #endif
  }

  func testInitialization() throws {
    for localization in InterfaceLocalization.allCases {
      #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
        try LocalizationSetting(orderOfPrecedence: [localization.code]).do {
          try FileManager.default.withTemporaryDirectory(appropriateFor: nil) { location in
            let package = try PackageRepository.initializePackage(
              at: location,
              named: StrictString(location.lastPathComponent),
              type: .library
            ).get()
            _ = try package.checkout("master").get()
          }
        }
      #endif
    }
  }

  func testManifestLoading() {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
      XCTAssert(try thisRepository.manifest().get().displayName == "SDGSwift")
    #endif
  }

  func testPackageGraphLoading() {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
      XCTAssert(
        try thisRepository.packageGraph().get().packages
          .contains(where: { $0.manifest.displayName == "SDGCornerstone" })
      )
    #endif
  }

  func testPackageLoading() {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
      XCTAssert(try thisRepository.package().get().manifest.displayName == "SDGSwift")
    #endif
  }

  func testTestCoverage() throws {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
      try withDefaultMockRepository { mock in
        let coverageFiles = thisRepository.location.appendingPathComponent(
          "Tests/Test Specifications/Test Coverage"
        )
        let sourceURL = coverageFiles.appendingPathComponent("Source.swift")
        let sourceDestination = mock.location.appendingPathComponent("Sources/Mock/Mock.swift")
        let testDestination = mock.location.appendingPathComponent(
          "Tests/MockTests/MockTests.swift"
        )
        try? FileManager.default.removeItem(at: sourceDestination)
        try FileManager.default.copy(
          sourceURL,
          to: sourceDestination
        )
        try? FileManager.default.removeItem(at: testDestination)
        try FileManager.default.copy(
          coverageFiles.appendingPathComponent("Tests.swift"),
          to: testDestination
        )

        for localization in InterfaceLocalization.allCases {
          try LocalizationSetting(orderOfPrecedence: [localization.code]).do {
            _ = try mock.test().get()
            guard
              let coverageReport = try mock.testAndLoadCoverageReport(ignoreCoveredRegions: true).get()
            else {
              XCTFail("No test coverage report found.")
              return
            }
            guard
              let file = coverageReport.files.first(where: {
                $0.file.lastPathComponent == "Mock.swift"
              })
            else {
              XCTFail("File missing from coverage report.")
              return
            }
            var specification = try String(from: sourceURL)
            for range in file.regions.reversed() {
              specification.insert("!", at: specification.index(of: range.region.upperBound))
              specification.insert("¡", at: specification.index(of: range.region.lowerBound))
            }
            compare(
              specification,
              against: testSpecificationDirectory().appendingPathComponent("Coverage.txt"),
              overwriteSpecificationInsteadOfFailing: false
            )
          }
        }
      }
    #endif
  }

  func testWorkspaceLoading() {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
      XCTAssert(
        try thisRepository.packageWorkspace().get().pinsStore.load().pins
          .contains(where: { pin in
            return pin.packageRef.identity
              == PackageIdentity(
                url: URL(string: "https://github.com/SDGGiesbrecht/SDGCornerstone")!
              )
          })
      )
    #endif
  }
}
