/*
 SDGSwiftConfigurationAPITests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGPersistenceTestUtilities
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
            // [_Define Example: Configuration Loading_]
            // These refer to a real, working sample product.
            // See its source for more details:
            // https://github.com/SDGGiesbrecht/SDGSwift/tree/0.1.8/Sources/SampleConfiguration
            let product = "SampleConfiguration"
            let package = Package(url: URL(string: "https://github.com/SDGGiesbrecht/SDGSwift")!)
            let version = Version(0, 1, 8)
            let type = SampleConfiguration.self // Import it first if necessary.

            // Assuming the above file is called “SampleConfigurationFile.swift”...
            let name = UserFacing<StrictString, APILocalization>({ _ in return "SampleConfigurationFile"})

            // Change this to actually point at a directory containing the above file.
            let configuredDirectory: URL = wherever

            let loadedConfiguration = try SampleConfiguration.load(configuration: type, named: name, from: configuredDirectory, linkingAgainst: product, in: package, at: version)
            XCTAssertEqual(loadedConfiguration.option, "Configured")
            // [_End_]

            // Cached:
            let cached = try SampleConfiguration.load(configuration: type, named: name, from: configuredDirectory, linkingAgainst: product, in: package, at: version)
            XCTAssertEqual(cached.option, "Configured")

            let none = specifications.appendingPathComponent("None")
            XCTAssertEqual(try SampleConfiguration.load(configuration: type, named: name, from: none, linkingAgainst: product, in: package, at: version).option, "Default")

            let emptyDirectory = specifications.appendingPathComponent("Empty")
            XCTAssertNil(try? SampleConfiguration.load(configuration: type, named: name, from: emptyDirectory, linkingAgainst: product, in: package, at: version))

        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
