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

            XCTAssertEqual(SampleConfiguration().option, "Default")
            testCodableConformance(of: SampleConfiguration(), uniqueTestName: "Sample Configuration")

            let specifications = testSpecificationDirectory().appendingPathComponent("Configuration")

            let type = SampleConfiguration.self
            let name = UserFacing<StrictString, APILocalization>({ _ in return "SampleConfigurationFile"})
            let product = "SampleConfiguration"
            let package = Package(url: URL(string: "https://github.com/SDGGiesbrecht/SDGSwift")!)
            let version = Version(0, 1, 8)

            let configuredDirectory: URL = specifications.appendingPathComponent("Configured")
            let loadedConfiguration = try SampleConfiguration.load(configuration: type, named: name, from: configuredDirectory, linkingAgainst: product, in: package, at: version)
            XCTAssertEqual(loadedConfiguration.option, "Configured")

            let emptyDirectory = specifications.appendingPathComponent("Empty")
            XCTAssertNil(try? SampleConfiguration.load(configuration: type, named: name, from: emptyDirectory, linkingAgainst: product, in: package, at: version))

        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
