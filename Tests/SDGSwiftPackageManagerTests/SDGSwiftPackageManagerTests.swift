/*
 SDGSwiftPackageManagerTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGPersistence
import SDGPersistenceTestUtilities
import SDGXCTestUtilities

import SDGSwiftLocalizations
import SDGSwiftPackageManager
import SDGSwiftTestUtilities

class SDGSwiftPackageManagerTests : TestCase {

    func testChangeDetection() throws {
        try withDefaultMockRepository { mock in
            try "...".save(to: mock.location.appendingPathComponent("File.md"))
            XCTAssertNotEqual(try mock.uncommittedChanges().get(), "", "Change unnoticed.")
            XCTAssertEqual(try mock.uncommittedChanges(excluding: ["*.md"]).get(), "", "No change should have been detected.")
        }
    }

    func testIgnoredFileDetection() {
        XCTAssert(try thisRepository.ignoredFiles().get().contains(where: { $0.lastPathComponent == ".build" }))
    }

    func testInitialization() {
        for localization in InterfaceLocalization.allCases {
            LocalizationSetting(orderOfPrecedence: [localization.code]).do {
                do {
                    try FileManager.default.withTemporaryDirectory(appropriateFor: nil) { location in
                        _ = try PackageRepository.initializePackage(at: location, named: StrictString(location.lastPathComponent), type: .library).get()
                    }
                } catch {
                    XCTFail("\(error)")
                }
            }
        }
    }

    func testManifestLoading() {
        XCTAssert(try thisRepository.package().get().name == "SDGSwift")
    }

    func testPackageGraphLoading() {
        XCTAssert(try thisRepository.packageGraph().get().packages.contains(where: { $0.name == "SDGCornerstone" }))
    }

    func testTestCoverage() throws {
        try withDefaultMockRepository { mock in
            let coverageFiles = thisRepository.location.appendingPathComponent("Tests/Test Specifications/Test Coverage")
            let sourceURL = coverageFiles.appendingPathComponent("Source.swift")
            let sourceDestination = mock.location.appendingPathComponent("Sources/Mock/Mock.swift")
            let testDestination = mock.location.appendingPathComponent("Tests/MockTests/MockTests.swift")
            try? FileManager.default.removeItem(at: sourceDestination)
            try FileManager.default.copy(
                sourceURL,
                to: sourceDestination)
            try? FileManager.default.removeItem(at: testDestination)
            try FileManager.default.copy(
                coverageFiles.appendingPathComponent("Tests.swift"),
                to: testDestination)

            XCTAssertNil(try? mock.codeCoverageReport()) // Not generated yet.
            try mock.test().get()
            guard let coverageReport = try mock.codeCoverageReport(ignoreCoveredRegions: true).get() else {
                XCTFail("No test coverage report found.")
                return
            }
            guard let file = coverageReport.files.first(where: { $0.file.lastPathComponent == "Mock.swift" }) else {
                XCTFail("File missing from coverage report.")
                return
            }
            var specification = try String(from: sourceURL)
            for range in file.regions.reversed() {
                specification.insert("!", at: range.region.upperBound)
                specification.insert("¡", at: range.region.lowerBound)
            }
            compare(specification, against: testSpecificationDirectory().appendingPathComponent("Coverage.txt"), overwriteSpecificationInsteadOfFailing: false)
        }
    }
}
