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

class APITests: SDGSwiftTestUtilities.TestCase {

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
    #if !os(Windows)  // #workaround(SDGCornerstone 5.4.1, Git cannot be located.)
      #if !os(Android)  // #workaround(workspace version 0.34.0, Emulator lacks Git.)
        XCTAssertNotNil(
          try? Git.location(versionConstraints: Version(Int.min)...Version(Int.max)).get()
        )
      #endif
    #endif
    FileManager.default.withTemporaryDirectory(appropriateFor: nil) { directory in
      let url = URL(fileURLWithPath: "/no/such/URL")
      _ = try? Git.clone(Package(url: url), to: url).get()
    }
  }

  func testGitError() {
    testCustomStringConvertibleConformance(
      of: VersionedExternalProcessExecutionError<Git>.locationError(
        .unavailable(versionConstraints: "...")
      ),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Git Unavailable",
      overwriteSpecificationInsteadOfFailing: false
    )
    switch Git.runCustomSubcommand(
      ["fail"],
      versionConstraints: Version(Int.min)...Version(Int.max)
    ) {
    case .success:
      XCTFail()
    case .failure(let error):
      #if !os(Windows)  // #workaround(SDGCornerstone 5.4.1, Git cannot be located.)
        #if !os(Android)  // #workaround(workspace version 0.34.0, Emulator lacks Git.)
          testCustomStringConvertibleConformance(
            of: error,
            localizations: InterfaceLocalization.self,
            uniqueTestName: "Git Execution",
            overwriteSpecificationInsteadOfFailing: false
          )
        #endif
      #endif
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
    #if !os(Windows)  // #workaround(SDGCornerstone 5.4.1, Git cannot be located.)
      #if !os(Android)  // #workaround(workspace version 0.34.0, Emulator lacks Git.)
        XCTAssert(
          try Package(url: URL(string: "https://github.com/SDGGiesbrecht/SDGCornerstone")!)
            .versions()
            .get() ∋ Version(0, 1, 0),
          "Failed to detect available versions."
        )
      #endif
    #endif
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
    #if os(Windows)  // Paths differ.
      _ = String(
        describing: PackageRepository(
          at: URL(fileURLWithPath: "D:\u{5C}path\u{5C}to\u{5C}Mock Package")
        )
      )
    #else
      testCustomStringConvertibleConformance(
        of: PackageRepository(at: URL(fileURLWithPath: "/path/to/Mock Package")),
        localizations: InterfaceLocalization.self,
        uniqueTestName: "Mock",
        overwriteSpecificationInsteadOfFailing: false
      )
    #endif

    // #workaround(Swift 5.2.4, SwiftPM won’t compile.)
    #if !(os(Windows) || os(Android))
      try withDefaultMockRepository { mock in
        _ = try mock.tag(version: Version(10, 0, 0)).get()
      }
    #endif
  }

  func testSwiftCompiler() throws {
    #if !os(Windows)  // #workaround(Swift 5.2.4, SwiftPM is unavailable.)
      #if !os(Android)  // #workaround(workspace version 0.34.0, Emulator lacks Swift.)
        _ = try SwiftCompiler.runCustomSubcommand(
          ["\u{2D}\u{2D}version"],
          versionConstraints: Version(Int.min)...Version(Int.max)
        ).get()
      #endif

      // #workaround(Swift 5.2.4, SwiftPM won’t compile.)
      #if !(os(Windows) || os(Android))
        try withDefaultMockRepository { mock in
          _ = try mock.resolve().get()
          _ = try mock.build(releaseConfiguration: true).get()
          _ = try mock.test().get()
        }
      #endif
      XCTAssertFalse(SwiftCompiler.warningsOccurred(during: ""))

      try withMock(named: "Tool") { mock in
        #if !os(Windows)  // #workaround(Swift 5.2.4, SwiftPM is unavailable.)
          #if !os(Android)  // #workaround(workspace version 0.34.0, Emulator lacks Swift.)
            _ = try mock.build(releaseConfiguration: true).get()
            XCTAssertEqual(try mock.run("Tool", releaseConfiguration: true).get(), "Hello, world!")
          #endif
        #endif
      }
    #endif
  }

  func testSwiftCompilerError() {
    struct StandInError: PresentableError {
      func presentableDescription() -> StrictString {
        return "[...]"
      }
    }
    // #workaround(Swift 5.2.4, SwiftPM won’t compile.)
    #if !(os(Windows) || os(Android))
      testCustomStringConvertibleConformance(
        of: SwiftCompiler.CoverageReportingError.swiftError(
          .locationError(.unavailable(versionConstraints: "..."))
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
    testCustomStringConvertibleConformance(
      of: Package.BuildError.gitError(.locationError(.unavailable(versionConstraints: "..."))),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Git Unavailable",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: Package.BuildError.swiftError(
        .locationError(.unavailable(versionConstraints: "..."))
      ),
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
