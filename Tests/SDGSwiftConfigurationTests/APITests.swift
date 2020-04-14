/*
 APITests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections
import SDGText
import SDGLocalization
import SDGVersioning

import SDGSwift
import SDGSwiftConfiguration
import SDGSwiftConfigurationLoading
import SampleConfiguration

import SDGSwiftLocalizations

import XCTest

import SDGPersistenceTestUtilities
import SDGLocalizationTestUtilities
import SDGXCTestUtilities

import SDGSwiftTestUtilities

class APITests: SDGSwiftTestUtilities.TestCase {

  func testConfiguration() throws {
      try LocalizationSetting(orderOfPrecedence: ["en\u{2D}CA"]).do {
        FileManager.default.delete(.cache)
        defer { FileManager.default.delete(.cache) }

        XCTAssertEqual(SampleConfiguration().option, "Default")
        testCodableConformance(of: SampleConfiguration(), uniqueTestName: "Sample Configuration")

        let specifications = testSpecificationDirectory().appendingPathComponent("Configuration")

        let wherever = specifications.appendingPathComponent("Configured")
        #if !os(Android)  // #workaround(workspace version 0.32.1, Emulator lacks Git.)
          // @example(configurationLoading)
          // These refer to a real, working sample product.
          // See its source for more details:
          // https://github.com/SDGGiesbrecht/SDGSwift/tree/0.20.0/Sources/SampleConfiguration
          let product = "SampleConfiguration"
          let package = Package(url: URL(string: "https://github.com/SDGGiesbrecht/SDGSwift")!)
          let minimumMacOSVersion = Version(10, 13)
          let version = Version(0, 20, 0)
          let type = SampleConfiguration.self  // Import it first if necessary.

          // Assuming the above file is called “SampleConfigurationFile.swift”...
          let name = UserFacing<StrictString, APILocalization>({ _ in "SampleConfigurationFile" })

          // Change this to actually point at a directory containing the above file.
          let configuredDirectory: URL = wherever

          // Context information can be provided. (Optional.)
          let context = SampleContext(information: "Information")

          // A log to collect progress reports while loading. (Optional.)
          var log = String()

          let loadedConfiguration = try SampleConfiguration.load(
            configuration: type,
            named: name,
            from: configuredDirectory,
            linkingAgainst: product,
            in: package,
            at: version,
            minimumMacOSVersion: minimumMacOSVersion,
            context: context,
            reportProgress: { print($0, to: &log) }
          ).get()
          XCTAssertEqual(loadedConfiguration.option, "Configured")
          // @endExample

          print("", to: &log)
          print("Cached", to: &log)
          let cached = try SampleConfiguration.load(
            configuration: type,
            named: name,
            from: configuredDirectory,
            linkingAgainst: product,
            in: package,
            at: version,
            minimumMacOSVersion: minimumMacOSVersion,
            context: context,
            reportProgress: { print($0, to: &log) }
          ).get()
          XCTAssertEqual(cached.option, "Configured")

          print("", to: &log)
          print("None", to: &log)
          let none = specifications.appendingPathComponent("None")
          XCTAssertEqual(
            try SampleConfiguration.load(
              configuration: type,
              named: name,
              from: none,
              linkingAgainst: product,
              in: package,
              at: version,
              minimumMacOSVersion: minimumMacOSVersion,
              context: context,
              reportProgress: { print($0, to: &log) }
            ).get().option,
            "Default"
          )

          print("", to: &log)
          print("Empty", to: &log)
          let emptyDirectory = specifications.appendingPathComponent("Empty")
          XCTAssertNil(
            try? SampleConfiguration.load(
              configuration: type,
              named: name,
              from: emptyDirectory,
              linkingAgainst: product,
              in: package,
              at: version,
              minimumMacOSVersion: minimumMacOSVersion,
              context: context,
              reportProgress: { print($0, to: &log) }
            ).get()
          )

          print("", to: &log)
          print("Mock", to: &log)

          let mock = SampleConfiguration()
          mock.option = "Mock"
          Configuration.queue(mock: mock)
          let loadedMock = try SampleConfiguration.load(
            configuration: type,
            named: name,
            from: configuredDirectory,
            linkingAgainst: product,
            in: package,
            at: version,
            minimumMacOSVersion: minimumMacOSVersion,
            reportProgress: { print($0, to: &log) }
          ).get()
          XCTAssertEqual(loadedMock.option, "Mock")

          func abbreviate(logEntry: String) {
            let pattern =
              (logEntry + " ").scalars
              + RepetitionPattern(ConditionalPattern({ $0 ≠ "\n" }))
              + "\n".scalars
            log.scalars.replaceMatches(
              for: pattern,
              with: (logEntry + " [...]\n").scalars
            )
          }
          func remove(logEntry: String) {
            let pattern =
              logEntry.scalars
              + RepetitionPattern(ConditionalPattern({ $0 ≠ "\n" }))
              + "\n".scalars
            log.scalars.replaceMatches(for: pattern, with: "".scalars)
          }
          abbreviate(logEntry: "Fetching")
          abbreviate(logEntry: "Completed resolution in")
          abbreviate(logEntry: "Cloning")
          abbreviate(logEntry: "Resolving")
          log.lines.removeAll(where: { line in
            return line.line.contains("Starting resolution using".scalars)
          })

          // These may occur out of order.
          remove(logEntry: "Compile Swift Module")
          let patternStart =
            "[".scalars
            + RepetitionPattern(ConditionalPattern({ $0 ≠ "\n" }))
          let pattern =
            patternStart
            + "] Compiling ".scalars
            + RepetitionPattern(ConditionalPattern({ $0 ≠ "\n" }))
            + "\n".scalars
          log.scalars.replaceMatches(for: pattern, with: "[[...]] Compiling [...]\n".scalars)
          remove(logEntry: "Linking")
          remove(logEntry: "warning: invalid duplicate target dependency declaration")
          remove(logEntry: "\u{27}llbuild\u{27}")

          let fractionPatternStart =
            "[".scalars
            + RepetitionPattern(ConditionalPattern({ $0.properties.isASCIIHexDigit }))
            + "/".scalars
          let fractionPattern =
            fractionPatternStart
            + RepetitionPattern(ConditionalPattern({ $0.properties.isASCIIHexDigit }))
            + "]".scalars
          log.scalars.replaceMatches(for: fractionPattern, with: "[[...]/[...]]".scalars)
          let astPattern =
            "[[...]/[...]] Wrapping AST for ".scalars
            + RepetitionPattern(ConditionalPattern({ $0 ≠ "\n" }))
            + " for debugging\n".scalars
          log.scalars.replaceMatches(for: astPattern, with: "".scalars)

          compare(
            log,
            against: testSpecificationDirectory().appendingPathComponent(
              "Configuration Loading.txt"
            ),
            overwriteSpecificationInsteadOfFailing: false
          )
        #endif
      }
  }

  func testConfigurationError() {
    struct StandInError: PresentableError {
      func presentableDescription() -> StrictString {
        return "[...]"
      }
    }
    testCustomStringConvertibleConformance(
      of: Configuration.Error.corruptConfiguration,
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Corrupt",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: Configuration.Error.emptyConfiguration,
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Empty",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: Configuration.Error.foundationError(StandInError()),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Foundation",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: Configuration.Error.swiftError(.locationError(.unavailable(versionConstraints: "..."))),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Swift Unavailable",
      overwriteSpecificationInsteadOfFailing: false
    )
  }
}
