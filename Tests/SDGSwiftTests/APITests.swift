/*
 APITests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections
import SDGText
import SDGLocalization
import SDGExternalProcess
import SDGVersioning

import SDGSwiftLocalizations
import SDGSwift

import XCTest

import SDGLogicTestUtilities
import SDGLocalizationTestUtilities
import SDGXCTestUtilities

import SDGSwiftTestUtilities

class APITests: TestCase {

  func testBuild() {
    testEquatableConformance(
      differingInstances: (Build.development, Build.version(Version(1, 0, 0)))
    )
    testEquatableConformance(
      differingInstances: (Build.version(Version(1, 0, 0)), Build.version(Version(2, 0, 0)))
    )
    testEquatableConformance(
      differingInstances: (Build.version(Version(1, 0, 0)), Build.development)
    )
    testCustomStringConvertibleConformance(
      of: Build.version(Version(1, 0, 0)),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "1.0.0",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: Build.development,
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Development",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testGit() {
    XCTAssertNotNil(try? Git.location().get())
  }

  func testGitError() {
    testCustomStringConvertibleConformance(
      of: Git.Error.locationError(.unavailable),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Git Unavailable",
      overwriteSpecificationInsteadOfFailing: false
    )
    switch Git.runCustomSubcommand(["fail"]) {
    case .success:
      XCTFail()
    case .failure(let error):
      testCustomStringConvertibleConformance(
        of: error,
        localizations: InterfaceLocalization.self,
        uniqueTestName: "Git Execution",
        overwriteSpecificationInsteadOfFailing: false
      )
    }
  }

  func testLocalizations() {
    XCTAssert(_InterfaceLocalization.codeSet() ⊆ InterfaceLocalization.codeSet())
  }

  func testPackage() {
    testCustomStringConvertibleConformance(
      of: Package(url: URL(string: "https://domain.tld/Package")!),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Mock Package",
      overwriteSpecificationInsteadOfFailing: false
    )
    XCTAssert(
      try Package(url: URL(string: "https://github.com/SDGGiesbrecht/SDGCornerstone")!).versions()
        .get() ∋ Version(0, 1, 0),
      "Failed to detect available versions."
    )
  }

  func testPackageError() {
    testCustomStringConvertibleConformance(
      of: Package.ExecutionError.noSuchExecutable(requested: ["tool"]),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "No Such Executable",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testPackageRepository() throws {
    testCustomStringConvertibleConformance(
      of: PackageRepository(at: URL(fileURLWithPath: "/path/to/Mock Package")),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Mock",
      overwriteSpecificationInsteadOfFailing: false
    )

    try withDefaultMockRepository { mock in
      _ = try mock.tag(version: Version(10, 0, 0)).get()
    }
  }

  func testSwiftCompiler() throws {
    _ = try SwiftCompiler.runCustomSubcommand(["\u{2D}\u{2D}version"]).get()

    try withDefaultMockRepository { mock in
      _ = try mock.resolve().get()
      _ = try mock.build(releaseConfiguration: true, staticallyLinkStandardLibrary: true).get()
      #if canImport(ObjectiveC)
        _ = try mock.regenerateTestLists().get()
      #else
        _ = try? mock.regenerateTestLists().get()
      #endif
      _ = try mock.test().get()
    }
    XCTAssertFalse(SwiftCompiler.warningsOccurred(during: ""))
  }

  func testSwiftCompilerError() {
    struct StandInError: PresentableError {
      func presentableDescription() -> StrictString {
        return "[...]"
      }
    }
    testCustomStringConvertibleConformance(
      of: SwiftCompiler.CoverageReportingError.packageManagerError(
        .swiftLocationError(.unavailable)
      ),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Unavailable",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: SwiftCompiler.CoverageReportingError.corruptTestCoverageReport,
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Corrupt Test Coverage Report",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: Package.BuildError.gitError(.locationError(.unavailable)),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Git Unavailable",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: Package.BuildError.swiftError(.locationError(.unavailable)),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Swift Unavailable",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: Package.BuildError.foundationError(StandInError()),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Foundation",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: Package.ExecutionError.gitError(.locationError(.unavailable)),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Git Unavailable",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: Package.ExecutionError.buildError(.gitError(.locationError(.unavailable))),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Git Unavailable",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: Package.ExecutionError.foundationError(StandInError()),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Foundation",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: Package.ExecutionError.executionError(.processError(code: 1, output: "[...]")),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Foundation",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: SwiftCompiler.Error.locationError(.unavailable),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Swift Unavailable",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: SwiftCompiler.Error.executionError(.processError(code: 1, output: "[...]")),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Swift Execution",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testVersion() {
    testCustomStringConvertibleConformance(
      of: Version(1, 2, 3),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "1.2.3",
      overwriteSpecificationInsteadOfFailing: false
    )

    XCTAssertEqual(Version(firstIn: "1.0.0"), Version(1, 0, 0))
    XCTAssertEqual(Version(firstIn: "1.0"), Version(1, 0, 0))
    XCTAssertEqual(Version(firstIn: "1"), Version(1, 0, 0))
    XCTAssertNil(Version(String("Blah blah blah...")))
    XCTAssertNil(Version(firstIn: "Blah blah blah..."))
    XCTAssertNil(Version(String("1.0.0.0")))
    XCTAssertNil(Version(String("1.0.A")))
    XCTAssertNil(Version(String("1.A")))
    XCTAssertNil(Version(String("A")))
    XCTAssertEqual(Version(0, 1, 0).compatibleVersions.upperBound, Version(0, 2, 0))
    XCTAssertEqual(Version(1, 0, 0), "1.0.0")
  }
}
