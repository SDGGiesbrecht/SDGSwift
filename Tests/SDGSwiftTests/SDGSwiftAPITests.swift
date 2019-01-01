/*
 SDGSwiftAPITests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections
import SDGLocalization
import SDGLogicTestUtilities
import SDGLocalizationTestUtilities
import SDGXCTestUtilities

import SDGSwiftLocalizations
import SDGSwift

import SDGSwiftTestUtilities

class SDGSwiftAPITests : TestCase {

    func testBuild() {
        testEquatableConformance(differingInstances: (Build.development, Build.version(Version(1, 0, 0))))
        testEquatableConformance(differingInstances: (Build.version(Version(1, 0, 0)), Build.version(Version(2, 0, 0))))
        testEquatableConformance(differingInstances: (Build.version(Version(1, 0, 0)), Build.development))
        testCustomStringConvertibleConformance(of: Build.version(Version(1, 0, 0)), localizations: InterfaceLocalization.self, uniqueTestName: "1.0.0", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: Build.development, localizations: InterfaceLocalization.self, uniqueTestName: "Development", overwriteSpecificationInsteadOfFailing: false)
    }

    func testGit() {
        XCTAssertNotNil(try? Git.location())
    }

    func testGitError() {
        testCustomStringConvertibleConformance(of: Git.Error.unavailable, localizations: InterfaceLocalization.self, uniqueTestName: "Git Unavailable", overwriteSpecificationInsteadOfFailing: false)
    }

    func testLocalizations() {
        XCTAssert(_InterfaceLocalization.codeSet() ⊆ InterfaceLocalization.codeSet())
    }

    func testPackage() {
        testCustomStringConvertibleConformance(of: Package(url: URL(string: "https://domain.tld/Package")!), localizations: InterfaceLocalization.self, uniqueTestName: "Mock Package", overwriteSpecificationInsteadOfFailing: false)
        XCTAssert(try Package(url: URL(string: "https://github.com/SDGGiesbrecht/SDGCornerstone")!).versions() ∋ Version(0, 1, 0), "Failed to detect available versions.")
    }

    func testPackageError() {
        testCustomStringConvertibleConformance(of: Package.Error.noSuchExecutable(requested: ["tool"]), localizations: InterfaceLocalization.self, uniqueTestName: "No Such Executable", overwriteSpecificationInsteadOfFailing: false)
    }

    func testPackageRepository() {
        testCustomStringConvertibleConformance(of: PackageRepository(at: URL(fileURLWithPath: "/path/to/Mock Package")), localizations: InterfaceLocalization.self, uniqueTestName: "Mock", overwriteSpecificationInsteadOfFailing: false)

        withDefaultMockRepository { mock in
            try mock.tag(version: Version(10, 0, 0))
        }
    }

    func testSwiftCompiler() {
        do {
            try SwiftCompiler.runCustomSubcommand(["\u{2D}\u{2D}version"])
        } catch {
            XCTFail("\(error)")
        }

        withDefaultMockRepository { mock in
            try mock.resolve()
            try mock.build(releaseConfiguration: true, staticallyLinkStandardLibrary: true)
            #if canImport(ObjectiveC)
            try mock.regenerateTestLists()
            #endif
            if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil {
                // When run from within Xcode, Xcode interferes with the child test process.
                try mock.test()
            }
        }
        XCTAssertFalse(SwiftCompiler.warningsOccurred(during: ""))
    }

    func testSwiftCompilerError() {
        testCustomStringConvertibleConformance(of: SwiftCompiler.Error.unavailable, localizations: InterfaceLocalization.self, uniqueTestName: "Unavailable", overwriteSpecificationInsteadOfFailing: false)
    }

    func testVersion() {
        testCustomStringConvertibleConformance(of: Version(1, 2, 3), localizations: InterfaceLocalization.self, uniqueTestName: "1.2.3", overwriteSpecificationInsteadOfFailing: false)

        XCTAssertEqual(Version(firstIn: "1.0.0"), Version(1, 0, 0))
        XCTAssertEqual(Version(firstIn: "1.0"), Version(1, 0, 0))
        XCTAssertEqual(Version(firstIn: "1"), Version(1, 0, 0))
        XCTAssertNil(Version("Blah blah blah..."))
        XCTAssertNil(Version(firstIn: "Blah blah blah..."))
        XCTAssertNil(Version("1.0.0.0"))
        XCTAssertNil(Version("1.0.A"))
        XCTAssertNil(Version("1.A"))
        XCTAssertNil(Version("A"))
        XCTAssertEqual(Version(0, 1, 0).compatibleVersions.upperBound, Version(0, 2, 0))
        XCTAssertEqual(Version(1, 0, 0), "1.0.0")
    }
}
