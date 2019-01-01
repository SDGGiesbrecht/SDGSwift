/*
 SDGSwiftConfigurationAPITests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections
import SDGPersistenceTestUtilities
import SDGLocalizationTestUtilities
import SDGXCTestUtilities

import SDGSwiftLocalizations
import SDGSwiftConfigurationLoading
import SampleConfiguration

class SDGSwiftConfigurationAPITests : TestCase {

    func testConfiguration() {
        do {
            FileManager.default.delete(.cache)
            defer { FileManager.default.delete(.cache) }

            XCTAssertEqual(SampleConfiguration().option, "Default")
            testCodableConformance(of: SampleConfiguration(), uniqueTestName: "Sample Configuration")

            let specifications = testSpecificationDirectory().appendingPathComponent("Configuration")

            let wherever = specifications.appendingPathComponent("Configured")
            // @example(configurationLoading)
            // These refer to a real, working sample product.
            // See its source for more details:
            // https://github.com/SDGGiesbrecht/SDGSwift/tree/0.3.0/Sources/SampleConfiguration
            let product = "SampleConfiguration"
            let package = Package(url: URL(string: "https://github.com/SDGGiesbrecht/SDGSwift")!)
            let version = Version(0, 3, 0)
            let type = SampleConfiguration.self // Import it first if necessary.

            // Assuming the above file is called “SampleConfigurationFile.swift”...
            let name = UserFacing<StrictString, APILocalization>({ _ in return "SampleConfigurationFile"})

            // Change this to actually point at a directory containing the above file.
            let configuredDirectory: URL = wherever

            // Context information can be provided. (Optional.)
            let context = SampleContext(information: "Information")

            // A log to collect progress reports while loading. (Optional.)
            var log = String()

            let loadedConfiguration = try SampleConfiguration.load(configuration: type, named: name, from: configuredDirectory, linkingAgainst: product, in: package, at: version, context: context, reportProgress: { print($0, to: &log) })
            XCTAssertEqual(loadedConfiguration.option, "Configured")
            // @endExample

            print("", to: &log)
            print("Cached", to: &log)
            let cached = try SampleConfiguration.load(configuration: type, named: name, from: configuredDirectory, linkingAgainst: product, in: package, at: version, context: context, reportProgress: { print($0, to: &log) })
            XCTAssertEqual(cached.option, "Configured")

            print("", to: &log)
            print("None", to: &log)
            let none = specifications.appendingPathComponent("None")
            XCTAssertEqual(try SampleConfiguration.load(configuration: type, named: name, from: none, linkingAgainst: product, in: package, at: version, context: context, reportProgress: { print($0, to: &log) }).option, "Default")

            print("", to: &log)
            print("Empty", to: &log)
            let emptyDirectory = specifications.appendingPathComponent("Empty")
            XCTAssertNil(try? SampleConfiguration.load(configuration: type, named: name, from: emptyDirectory, linkingAgainst: product, in: package, at: version, context: context, reportProgress: { print($0, to: &log) }))

            print("", to: &log)
            print("Mock", to: &log)

            let mock = SampleConfiguration()
            mock.option = "Mock"
            Configuration.queue(mock: mock)
            let loadedMock = try SampleConfiguration.load(configuration: type, named: name, from: configuredDirectory, linkingAgainst: product, in: package, at: version, reportProgress: { print($0, to: &log) })
            XCTAssertEqual(loadedMock.option, "Mock")

            func abbreviate(logEntry: String) {
                log.scalars.replaceMatches(for: CompositePattern([
                    LiteralPattern((logEntry + " ").scalars),
                    RepetitionPattern(ConditionalPattern({ $0 ≠ "\n" })),
                    LiteralPattern("\n".scalars)
                    ]), with: (logEntry + " [...]\n").scalars)
            }
            func remove(logEntry: String) {
                log.scalars.replaceMatches(for: CompositePattern([
                    LiteralPattern((logEntry + " ").scalars),
                    RepetitionPattern(ConditionalPattern({ $0 ≠ "\n" })),
                    LiteralPattern("\n".scalars)
                    ]), with: "".scalars)
            }
            abbreviate(logEntry: "Fetching")
            abbreviate(logEntry: "Completed resolution in")
            abbreviate(logEntry: "Cloning")
            abbreviate(logEntry: "Resolving")
            remove(logEntry: "Compile Swift Module") // These may occur out of order.
            remove(logEntry: "Linking")
            compare(log, against: testSpecificationDirectory().appendingPathComponent("Configuration Loading.txt"), overwriteSpecificationInsteadOfFailing: false)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testConfigurationError() {
        testCustomStringConvertibleConformance(of: Configuration.Error.corruptConfiguration, localizations: InterfaceLocalization.self, uniqueTestName: "Corrupt", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: Configuration.Error.emptyConfiguration, localizations: InterfaceLocalization.self, uniqueTestName: "Empty", overwriteSpecificationInsteadOfFailing: false)
    }
}
