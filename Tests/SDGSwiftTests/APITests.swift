/*
 APITests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics
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

  func testCoverageRegion() {
    let string = "string"
    let region = CoverageRegion(region: string.bounds, count: 0)
    _ = region.convert(using: { $0 })
    var regions = [region]
    CoverageRegion._normalize(regions: &regions, source: string, ignoreCoveredRegions: false)
    let convertedRegions = regions.map { $0.convert(using: { string.offset(of: $0) }) }
    _ = FileTestCoverage(file: URL(fileURLWithPath: "/some/path"), regions: convertedRegions)

    var uncovered = [CoverageRegion(region: string.bounds, count: 1)]
    CoverageRegion._normalize(regions: &uncovered, source: string, ignoreCoveredRegions: true)

    let ifElse = [
      "if true {",  // 10
      "  exit(0)",  // 10
      "} else {",  // 9
      "  exit(1)",  // 10
      "}",  // 1
    ].joined(separator: "\n")
    var ifElseRegions = [
      CoverageRegion(
        region: ifElse.scalars.index(
          ifElse.scalars.startIndex,
          offsetBy: 22
        )..<ifElse.scalars.index(ifElse.scalars.startIndex, offsetBy: 39),
        count: 0
      )
    ]
    CoverageRegion._normalize(regions: &ifElseRegions, source: ifElse, ignoreCoveredRegions: true)
    ifElseRegions = [
      CoverageRegion(
        region: ifElse.scalars.index(
          ifElse.scalars.startIndex,
          offsetBy: 39
        )..<ifElse.scalars.index(ifElse.scalars.startIndex, offsetBy: 40),
        count: 0
      )
    ]
    CoverageRegion._normalize(regions: &ifElseRegions, source: ifElse, ignoreCoveredRegions: true)
    ifElseRegions = [
      CoverageRegion(
        region: ifElse.scalars.index(
          ifElse.scalars.startIndex,
          offsetBy: 28
        )..<ifElse.scalars.index(ifElse.scalars.startIndex, offsetBy: 40),
        count: 0
      )
    ]
    CoverageRegion._normalize(regions: &ifElseRegions, source: ifElse, ignoreCoveredRegions: true)
    ifElseRegions = [
      CoverageRegion(
        region: ifElse.scalars.index(
          ifElse.scalars.startIndex,
          offsetBy: 21
        )..<ifElse.scalars.index(ifElse.scalars.startIndex, offsetBy: 40),
        count: 0
      )
    ]
    CoverageRegion._normalize(regions: &ifElseRegions, source: ifElse, ignoreCoveredRegions: true)
  }

  func testTestCoverageReport() {
    _ = TestCoverageReport(files: [])
  }

  func testFileTestCoverage() {
    _ = FileTestCoverage(file: URL(fileURLWithPath: #filePath), regions: [])
  }

  func testGit() {
    // #workaround(Swift 5.3.2, Segmentation fault.)
    #if !os(Windows)
      #if PLATFORM_LACKS_GIT
        _ = try? Git.location(versionConstraints: Version(Int.min)...Version(Int.max)).get()
      #else
        XCTAssertNotNil(
          try? Git.location(versionConstraints: Version(Int.min)...Version(Int.max)).get()
        )
        FileManager.default.withTemporaryDirectory(appropriateFor: nil) { directory in
          let url = directory.appendingPathComponent("no such URL")
          _ = try? Git.clone(Package(url: url), to: url).get()
        }
      #endif
    #endif
  }

  func testGitError() {
    // #workaround(Swift 5.3.2, Segmentation fault.)
    #if !os(Windows)
      testCustomStringConvertibleConformance(
        of: VersionedExternalProcessExecutionError<Git>.locationError(
          .unavailable(versionConstraints: "...")
        ),
        localizations: InterfaceLocalization.self,
        uniqueTestName: "Git Unavailable",
        overwriteSpecificationInsteadOfFailing: false
      )
      #if !PLATFORM_LACKS_GIT
        switch Git.runCustomSubcommand(
          ["fail"],
          versionConstraints: Version(Int.min)...Version(Int.max)
        ) {
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
      #endif
    #endif
  }

  func testLocalizations() {
    XCTAssert(_InterfaceLocalization.codeSet() ⊆ InterfaceLocalization.codeSet())
  }

  func testPackage() {
    // #workaround(Swift 5.3.2, Segmentation fault.)
    #if !os(Windows)
      testCustomStringConvertibleConformance(
        of: Package(url: URL(string: "https://domain.tld/Package")!),
        localizations: InterfaceLocalization.self,
        uniqueTestName: "Mock Package",
        overwriteSpecificationInsteadOfFailing: false
      )
      #if !PLATFORM_LACKS_GIT
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
    // #workaround(Swift 5.3.2, Segmentation fault.)
    #if !os(Windows)
      #if os(Windows)  // Paths differ.
        _ = String(
          describing: PackageRepository(
            at: URL(fileURLWithPath: "D:\u{5C}path\u{5C}to\u{5C}Mock Package")
          )
        )
      #else
        #if !os(WASI)  // #workaround(Swift 5.3.2, Web lacks URL(fileURLWithPath:).)
          testCustomStringConvertibleConformance(
            of: PackageRepository(at: URL(fileURLWithPath: "/path/to/Mock Package")),
            localizations: InterfaceLocalization.self,
            uniqueTestName: "Mock",
            overwriteSpecificationInsteadOfFailing: false
          )
        #endif
      #endif

      // #workaround(Swift 5.3.2, SwiftPM won’t compile.)
      #if !(os(Windows) || os(WASI) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
        try withDefaultMockRepository { mock in
          _ = try mock.tag(version: Version(10, 0, 0)).get()
        }
      #endif

      #if !os(WASI)  // #workaround(Swift 5.3.2, Web lacks FileManager.)
        FileManager.default.withTemporaryDirectory(appropriateFor: nil) { directory in
          let url = directory.appendingPathComponent("no such URL")
          #if !(os(tvOS) || os(iOS) || os(watchOS))
            _ = try? PackageRepository.clone(Package(url: url), to: url).get()
          #endif
        }
      #endif
    #endif
  }

  func testStringScalarOffset() {
    let string = "string"
    let offsets = string.offsets(of: string.scalars.bounds)
    let bounds = string.indices(of: offsets)
    XCTAssertEqual(bounds, string.scalars.bounds)
    let start = offsets.lowerBound
    XCTAssertEqual(start + 1 − 1, start)
    XCTAssertEqual(offsets.upperBound − offsets.lowerBound, 6)
  }

  func testSwiftCompiler() throws {
    #if !os(WASI)  // #workaround(Swift 5.3.2, Web lacks Process.)
      #if !os(Windows)  // #workaround(Swift 5.3.2, SwiftPM is unavailable.)
        #if !PLATFORM_LACKS_GIT
          _ = try SwiftCompiler.runCustomSubcommand(
            ["\u{2D}\u{2D}version"],
            versionConstraints: Version(Int.min)...Version(Int.max)
          ).get()

          // #workaround(Swift 5.3.2, SwiftPM won’t compile.)
          #if !(os(Windows) || os(Android))
            try withDefaultMockRepository { mock in
              _ = try mock.resolve().get()
              _ = try mock.build(releaseConfiguration: true).get()
              _ = try mock.test().get()
            }
          #endif
        #endif
        XCTAssertFalse(SwiftCompiler.warningsOccurred(during: ""))
        XCTAssertTrue(
          SwiftCompiler.warningsOccurred(
            during: ".../File.swift:1:1: warning: Something went wrong."
          )
        )
        XCTAssertTrue(
          ¬SwiftCompiler.warningsOccurred(
            during: ".../.build/.../File.swift:1:1: warning: Something went wrong."
          )
        )

        try withMock(named: "Tool") { mock in
          _ = try mock.build(releaseConfiguration: true).get()
          XCTAssertEqual(
            try mock.run("Tool", releaseConfiguration: true).get(),
            "Hello, world!"
          )
        }
      #endif

      // #workaround(Swift 5.3.2, SwiftPM won’t compile.)
      #if !(os(Windows) || os(WASI) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
        try withDefaultMockRepository { package in
          _ = try? SwiftCompiler.build(package).get()
          _ = try? SwiftCompiler.run("no such target", from: package).get()
          _ = try SwiftCompiler.test(package).get()
          _ = try SwiftCompiler.codeCoverageReport(for: package).get()
          _ = try? SwiftCompiler.resolve(package).get()
        }
      #endif
    #endif
  }

  func testSwiftCompilerError() {
    struct StandInError: PresentableError {
      func presentableDescription() -> StrictString {
        return "[...]"
      }
    }
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
    // #workaround(Swift 5.3.2, Segmentation fault.)
    #if !os(Windows)
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
    #endif
  }

  func testVersionedExternalProcess() {
    // #workaround(Swift 5.3.2, Segmentation fault.)
    #if !os(Windows)
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
    #endif
  }
}
