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
import SDGSwiftSource

class SDGSwiftSourceAPITests : TestCase {

    func testContainerSyntaxElement() {
        XCTAssert(¬ContainerSyntaxElement(range: "".bounds, children: []).children.isEmpty)
    }

    func testIdentifier() {
        XCTAssert(Identifier.identifierCharacters ∋ "α")
        XCTAssert(Identifier.operatorCharactersIncludingDot ∋ "∧")
    }

    func testParsing() {
        do {
            for url in try FileManager.default.deepFileEnumeration(in: beforeDirectory) where url.lastPathComponent ≠ ".DS_Store" {
                let sourceFile = try SourceFileSyntax.parse(url)

                let originalSource = try String(from: url)
                var roundTripSource = ""
                sourceFile.write(to: &roundTripSource)
                if ¬roundTripSource.contains("unknown {") ∧ ¬roundTripSource.contains("interpolated") { // #workaround(Swift 4.1.2, SwiftSyntax does not recognize getters and setters properly yet.)
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
        } catch {
            XCTFail("\(error)")
        }
    }

    func testUnidentifiedSyntaxElement() {
        XCTAssertEqual(UnidentifiedSyntaxElement(range: "".scalars.bounds).textFreedom, .invariable)
    }
}
