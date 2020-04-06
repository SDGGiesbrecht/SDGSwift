/*
 APITests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

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

// #workaround(workspace version 0.32.0, SwiftPM won’t compile.)
#if !(os(Windows) || os(Android))
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
    // #workaround(workspace version 0.32.0, SwiftPM won’t compile.)
    #if !(os(Windows) || os(Android))
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
    // #workaround(workspace version 0.32.0, SwiftPM won’t compile.)
    #if !(os(Windows) || os(Android))
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
      testCustomStringConvertibleConformance(
        of: SwiftCompiler.PackageLoadingError.packageManagerError(StandInError(), []),
        localizations: InterfaceLocalization.self,
        uniqueTestName: "Package Manager",
        overwriteSpecificationInsteadOfFailing: false
      )

      let invalidPackage = URL(fileURLWithPath: #file)
        .deletingLastPathComponent()
        .deletingLastPathComponent()
        .appendingPathComponent("Mock Projects")
        .appendingPathComponent("Invalid")
      switch PackageRepository(at: invalidPackage).packageGraph() {
      case .success(let graph):
        print(graph.allTargets.map({ $0.name }))
        XCTFail("Should not have succeeded.")
      case .failure(let error):
        testCustomStringConvertibleConformance(
          of: error,
          localizations: InterfaceLocalization.self,
          uniqueTestName: "Diagnostics",
          overwriteSpecificationInsteadOfFailing: false
        )
      }
    #endif
  }

  func testIgnoredFileDetection() {
    #if !os(Android)  // #workaround(workspace version 0.32.0, Emulator lacks Git.)
      #if !os(Windows)  // #workaround(workspace version 0.32.0, GitHub workflow host lacks Git.)
        XCTAssert(
          try thisRepository.ignoredFiles().get()
            .contains(where: { $0.lastPathComponent == ".build" })
        )
      #endif
    #endif
  }

  func testInitialization() throws {
    for localization in InterfaceLocalization.allCases {
      try LocalizationSetting(orderOfPrecedence: [localization.code]).do {
        try FileManager.default.withTemporaryDirectory(appropriateFor: nil) { location in
          // #workaround(workspace version 0.32.0, SwiftPM won’t compile.)
          #if !(os(Windows) || os(Android))
            let package = try PackageRepository.initializePackage(
              at: location,
              named: StrictString(location.lastPathComponent),
              type: .library
            ).get()
            _ = try package.checkout("master").get()
          #endif
        }
      }
    }
  }

  func testManifestLoading() {
    // #workaround(workspace version 0.32.0, SwiftPM won’t compile.)
    #if !(os(Windows) || os(Android))
      XCTAssert(try thisRepository.package().get().name == "SDGSwift")
    #endif
  }

  func testWorkspaceLoading() {
    // #workaround(workspace version 0.32.0, SwiftPM won’t compile.)
    #if !(os(Windows) || os(Android))
      XCTAssertEqual(
        try thisRepository.packageWorkspace().get().resolvedFile.basename,
        "Package.resolved"
      )
    #endif
  }

  func testPackageGraphLoading() {
    // #workaround(workspace version 0.32.0, SwiftPM won’t compile.)
    #if !(os(Windows) || os(Android))
      XCTAssert(
        try thisRepository.packageGraph().get().packages.contains(where: {
          $0.name == "SDGCornerstone"
        })
      )
    #endif
  }

  func testTestCoverage() throws {
    // #workaround(workspace version 0.32.0, SwiftPM won’t compile.)
    #if !(os(Windows) || os(Android))
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
            if localization == InterfaceLocalization.allCases.first {
              XCTAssertNil(try? mock.codeCoverageReport().get())  // Not generated yet.
            }
            _ = try mock.test().get()
            guard let coverageReport = try mock.codeCoverageReport(ignoreCoveredRegions: true).get()
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
              specification.insert("!", at: range.region.upperBound)
              specification.insert("¡", at: range.region.lowerBound)
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
}
