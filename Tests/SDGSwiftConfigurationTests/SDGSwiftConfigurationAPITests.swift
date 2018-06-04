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
        XCTAssertEqual(SampleConfiguration().option, "Default")
        let configuredDirectory = testSpecificationDirectory().appendingPathComponent("Configuration")
        XCTAssertEqual(try SampleConfiguration.loadConfiguration(named: UserFacing<StrictString, APILocalization>({ _ in return "SampleConfiguration"}), from: configuredDirectory, linkingAgainst: "SampleConfiguration", in: Package(url: URL(string: "https://github.com/SDGGiesbrecht/SDGSwift")!), at: Version(0, 1, 8)).option, "Configured")
    }
}
