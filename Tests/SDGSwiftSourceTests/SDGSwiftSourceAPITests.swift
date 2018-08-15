/*
 SDGSwiftSourceAPITests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

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
import SDGSwiftPackageManager
import SDGSwiftSource

import SDGSwiftTestUtilities

class SDGSwiftSourceAPITests : TestCase {

    func testRealSource() throws { // #workaroun(Until API parsing is complete.)

        let libraries = thisRepository.location.deletingLastPathComponent()
        let cornerstone = PackageRepository(at: libraries.appendingPathComponent("SDGCornerstone"))
        for target in try cornerstone.package().targets where target.name == "SDGCalendar" {
            print(try ModuleAPI(module: target).summary)
        }

    }

    func testAPIParsing() throws {
        let package = PackageRepository(at: mocksDirectory.appendingPathComponent("PackageToDocument"))
        for target in try package.package().targets {
            let specification = testSpecificationDirectory().appendingPathComponent("API/Modules/\(target.name).txt")
            let parsed = try ModuleAPI(module: target).summary
            SDGPersistenceTestUtilities.compare(parsed, against: specification, overwriteSpecificationInsteadOfFailing: false)
        }
    }

    func testLineDeveloperCommentSyntax() throws {
        let syntax = try Syntax.parse("/\u{2F} Comment.")
        try SyntaxScanner().scan(syntax)
        XCTAssertNil(syntax.ancestors().makeIterator().next())

        class CommentScanner : SyntaxScanner {
            override func visit(_ node: ExtendedSyntax) -> Bool {
                if let comment = node as? LineDeveloperCommentSyntax {
                    XCTAssertNotNil(comment.content)
                }
                return true
            }
        }
        try CommentScanner().scan(syntax)
    }

    func testLineDocumentationCommentSyntax() throws {
        let syntax = try Syntax.parse("//\u{2F} Documentation.")
        class DocumentationScanner : SyntaxScanner {
            override func visit(_ node: ExtendedSyntax) -> Bool {
                if let comment = node as? LineDocumentationSyntax {
                    XCTAssertNotNil(comment.content)
                }
                return true
            }
        }
        try DocumentationScanner().scan(syntax)
    }

    func testParsing() throws {
        for url in try FileManager.default.deepFileEnumeration(in: beforeDirectory) where url.lastPathComponent ≠ ".DS_Store" {
            let sourceFile = try SourceFileSyntax.parse(url)

            let originalSource = try String(from: url)
            var roundTripSource = ""
            sourceFile.write(to: &roundTripSource)
            if ¬roundTripSource.contains("unknown {")
                ∧ ¬roundTripSource.contains("interpolated")
                ∧ ¬roundTripSource.contains("{ unknown") { // #workaround(Swift 4.1.2, SwiftSyntax does not recognize getters and setters properly yet.)
                XCTAssertEqual(roundTripSource, originalSource)
            }

            TextFreedomHighlighter.targetTestFreedom = .arbitrary
            try TextFreedomHighlighter().compare(syntax: sourceFile, parsedFrom: url, againstSpecification: "Arbitrary Text", overwriteSpecificationInsteadOfFailing: false)

            TextFreedomHighlighter.targetTestFreedom = .aliasable
            try TextFreedomHighlighter().compare(syntax: sourceFile, parsedFrom: url, againstSpecification: "Aliasable Text", overwriteSpecificationInsteadOfFailing: false)

            TextFreedomHighlighter.targetTestFreedom = .invariable
            try TextFreedomHighlighter().compare(syntax: sourceFile, parsedFrom: url, againstSpecification: "Invariable Text", overwriteSpecificationInsteadOfFailing: false)

            // API
            let api = sourceFile.api().sorted().map({ $0.summary.joined(separator: "\n") }).joined(separator: "\n")
            SDGPersistenceTestUtilities.compare(api, against: sourceDirectory.appendingPathComponent("After").appendingPathComponent("API").appendingPathComponent(url.deletingPathExtension().lastPathComponent).appendingPathExtension("txt"), overwriteSpecificationInsteadOfFailing: false)
        }
    }
}
