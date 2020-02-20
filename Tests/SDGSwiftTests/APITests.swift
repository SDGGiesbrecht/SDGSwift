/*
 APITests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

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

// #workaround(workspace version 0.30.1, Test case names only need to disambiguate for WindowsMain.swift.)
class SDGSwiftAPITests: SDGSwiftTestUtilities.TestCase {

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
    #if !os(Android)  // #workaorund(workspace version 0.30.1, Emulator lacks permissions.)
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
    #endif
  }

  func testGit() {
    #if !os(Android)  // #workaorund(workspace version 0.30.1, Emulator lacks Git.)
      XCTAssertNotNil(
        try? Git.location(versionConstraints: Version(Int.min)...Version(Int.max)).get()
      )
    #endif
  }

  func testGitError() {
    #if !os(Android)  // #workaorund(workspace version 0.30.1, Emulator lacks permissions.)
      testCustomStringConvertibleConformance(
        of: VersionedExternalProcessExecutionError<Git>.locationError(
          .unavailable(versionConstraints: "...")
        ),
        localizations: InterfaceLocalization.self,
        uniqueTestName: "Git Unavailable",
        overwriteSpecificationInsteadOfFailing: false
      )
    #endif
    switch Git.runCustomSubcommand(
      ["fail"],
      versionConstraints: Version(Int.min)...Version(Int.max)
    ) {
    case .success:
      XCTFail()
    case .failure(let error):
      #if !os(Android)  // #workaorund(workspace version 0.30.1, Emulator lacks permissions.)
        testCustomStringConvertibleConformance(
          of: error,
          localizations: InterfaceLocalization.self,
          uniqueTestName: "Git Execution",
          overwriteSpecificationInsteadOfFailing: false
        )
      #endif
    }
  }

  func testLocalizations() {
    XCTAssert(_InterfaceLocalization.codeSet() ⊆ InterfaceLocalization.codeSet())
  }

  func testPackage() {
    #if !os(Android)  // #workaorund(workspace version 0.30.1, Emulator lacks permissions.)
      testCustomStringConvertibleConformance(
        of: Package(url: URL(string: "https://domain.tld/Package")!),
        localizations: InterfaceLocalization.self,
        uniqueTestName: "Mock Package",
        overwriteSpecificationInsteadOfFailing: false
      )
    #endif
    #if !os(Android)  // #workaorund(workspace version 0.30.1, Emulator lacks Git.)
      XCTAssert(
        try Package(url: URL(string: "https://github.com/SDGGiesbrecht/SDGCornerstone")!).versions()
          .get() ∋ Version(0, 1, 0),
        "Failed to detect available versions."
      )
    #endif
  }

  func testPackageError() {
    #if !os(Android)  // #workaorund(workspace version 0.30.1, Emulator lacks permissions.)
      testCustomStringConvertibleConformance(
        of: Package.ExecutionError.noSuchExecutable(requested: ["tool"]),
        localizations: InterfaceLocalization.self,
        uniqueTestName: "No Such Executable",
        overwriteSpecificationInsteadOfFailing: false
      )
    #endif
  }

  func testPackageRepository() throws {
    #if !os(Android)  // #workaorund(workspace version 0.30.1, Emulator lacks permissions.)
      testCustomStringConvertibleConformance(
        of: PackageRepository(at: URL(fileURLWithPath: "/path/to/Mock Package")),
        localizations: InterfaceLocalization.self,
        uniqueTestName: "Mock",
        overwriteSpecificationInsteadOfFailing: false
      )
    #endif

    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftPM won’t compile.)
      try withDefaultMockRepository { mock in
        _ = try mock.tag(version: Version(10, 0, 0)).get()
      }
    #endif
  }

  func testSwiftCompiler() throws {
    _ = try SwiftCompiler.runCustomSubcommand(
      ["\u{2D}\u{2D}version"],
      versionConstraints: Version(Int.min)...Version(Int.max)
    ).get()

    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftPM won’t compile.)
      try withDefaultMockRepository { mock in
        _ = try mock.resolve().get()
        _ = try mock.build(releaseConfiguration: true).get()
        _ = try mock.test().get()
      }
    #endif
    XCTAssertFalse(SwiftCompiler.warningsOccurred(during: ""))

    try withMock(named: "Tool") { mock in
      _ = try mock.build(releaseConfiguration: true).get()
      XCTAssertEqual(try mock.run("Tool", releaseConfiguration: true).get(), "Hello, world!")
    }
  }

  func testSwiftCompilerError() {
    struct StandInError: PresentableError {
      func presentableDescription() -> StrictString {
        return "[...]"
      }
    }
    #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftPM won’t compile.)
      testCustomStringConvertibleConformance(
        of: SwiftCompiler.CoverageReportingError.packageManagerError(
          .swiftLocationError(.unavailable(versionConstraints: "..."))
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
    #endif
    #if !os(Android)  // #workaorund(workspace version 0.30.1, Emulator lacks permissions.)
      testCustomStringConvertibleConformance(
        of: Package.BuildError.gitError(.locationError(.unavailable(versionConstraints: "..."))),
        localizations: InterfaceLocalization.self,
        uniqueTestName: "Git Unavailable",
        overwriteSpecificationInsteadOfFailing: false
      )
      testCustomStringConvertibleConformance(
        of: Package.BuildError.swiftError(.locationError(.unavailable(versionConstraints: "..."))),
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
        of: Package.ExecutionError.gitError(
          .locationError(.unavailable(versionConstraints: "..."))
        ),
        localizations: InterfaceLocalization.self,
        uniqueTestName: "Git Unavailable",
        overwriteSpecificationInsteadOfFailing: false
      )
      testCustomStringConvertibleConformance(
        of: Package.ExecutionError.buildError(
          .gitError(.locationError(.unavailable(versionConstraints: "...")))
        ),
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
        of: VersionedExternalProcessExecutionError<SwiftCompiler>.locationError(
          .unavailable(versionConstraints: "...")
        ),
        localizations: InterfaceLocalization.self,
        uniqueTestName: "Swift Unavailable",
        overwriteSpecificationInsteadOfFailing: false
      )
      testCustomStringConvertibleConformance(
        of: VersionedExternalProcessExecutionError<SwiftCompiler>.executionError(
          .processError(code: 1, output: "[...]")
        ),
        localizations: InterfaceLocalization.self,
        uniqueTestName: "Swift Execution",
        overwriteSpecificationInsteadOfFailing: false
      )
    #endif
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

  func testVersionedExternalProcess() {
    do {
      // Fresh
      _ = try SwiftCompiler.location(versionConstraints: Version(0).compatibleVersions).get()
      XCTFail("Failed to throw.")
    } catch {}
    do {
      // Cached
      _ = try SwiftCompiler.location(versionConstraints: Version(0).compatibleVersions).get()
      XCTFail("Failed to throw.")
    } catch {}
  }
}
