/*
 SDGSwiftPackageManagerTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGPersistence
import SDGXCTestUtilities

import SDGSwiftLocalizations
import SDGSwiftPackageManager
import SDGSwiftTestUtilities

class SDGSwiftPackageManagerTests : TestCase {

    func testChangeDetection() {
        withDefaultMockRepository { mock in
            try "...".save(to: mock.location.appendingPathComponent("File.md"))
            XCTAssertNotEqual(try mock.uncommittedChanges(), "", "Change unnoticed.")
            XCTAssertEqual(try mock.uncommittedChanges(excluding: ["*.md"]), "", "No change should have been detected.")
        }
    }

    func testIgnoredFileDetection() {
        XCTAssert(try thisRepository.ignoredFiles().contains(where: { $0.lastPathComponent == ".build" }))
    }

    func testInitialization() {
        for localization in InterfaceLocalization.cases {
            LocalizationSetting(orderOfPrecedence: [localization.code]).do {
                do {
                    let location = FileManager.default.url(in: .temporary, at: "Initialized")
                    try? FileManager.default.removeItem(at: location)
                    defer { try? FileManager.default.removeItem(at: location) }

                    _ = try PackageRepository(initializingAt: location, type: .library)
                } catch {
                    XCTFail("\(error)")
                }
            }
        }
    }

    func testManifestLoading() {
        XCTAssert(try thisRepository.package().name == "SDGSwift")
    }

    func testPackageGraphLoading() {
        XCTAssert(try thisRepository.packageGraph().packages.contains(where: { $0.name == "SDGCornerstone" }))
    }
}
