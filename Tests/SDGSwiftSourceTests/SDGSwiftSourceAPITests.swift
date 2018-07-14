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


    func testParsingSwiftSyntax() {
        do {
            for url in try FileManager.default.deepFileEnumeration(in: beforeDirectory) {
                let sourceFile = try SourceFileSyntax.parse(url)

                // #warning(Remove unidentifed test specifications. They are meaningless.

                class ArbitraryText : Highlighter {
                    override func shouldHighlight(_ trivia: TriviaPiece) -> Bool {
                        return trivia.textFreedom == .arbitrary
                    }
                }
                ArbitraryText().compare(syntax: sourceFile, parsedFrom: url, againstSpecification: "Arbitrary Text", overwriteSpecificationInsteadOfFailing: false)

                class AliasableText : Highlighter {
                    override func shouldHighlight(_ trivia: TriviaPiece) -> Bool {
                        return trivia.textFreedom == .aliasable
                    }
                }
                AliasableText().compare(syntax: sourceFile, parsedFrom: url, againstSpecification: "Aliasable Text", overwriteSpecificationInsteadOfFailing: false)

                class InvariableText : Highlighter {
                    override func shouldHighlight(_ trivia: TriviaPiece) -> Bool {
                        return trivia.textFreedom == .invariable
                    }
                }
                InvariableText().compare(syntax: sourceFile, parsedFrom: url, againstSpecification: "Invariable Text", overwriteSpecificationInsteadOfFailing: false)
                /*
                 #warning(Not handled yet.)

                // API
                let api = sourceFile.api(source: source).sorted().map({ $0.summary.joined(separator: "\n") }).joined(separator: "\n")
                SDGPersistenceTestUtilities.compare(api, against: sourceDirectory.appendingPathComponent("After").appendingPathComponent("API").appendingPathComponent(url.deletingPathExtension().lastPathComponent).appendingPathExtension("txt"), overwriteSpecificationInsteadOfFailing: false)*/
            }
        } catch {
            XCTFail("\(error)")
        }
    }

    func testParsingSourceKit() {
        do {
            let sourceDirectory = testSpecificationDirectory().appendingPathComponent("Source")
            let beforeDirectory = sourceDirectory.appendingPathComponent("Before")
            for url in try FileManager.default.deepFileEnumeration(in: beforeDirectory) {
                let sourceFile = try File(from: url)
                let source = try String(from: url)

                let underline: Unicode.Scalar = "\u{332}"

                @discardableResult func compare(specification name: String, overwriteSpecificationInsteadOfFailing: Bool, file: StaticString = #file, line: UInt = #line, highlighting shouldHighlight: (SyntaxElement) -> Bool) -> String {
                    var highlighted = source
                    for element in sourceFile.makeDeepIterator().reversed() where shouldHighlight(element) {
                        var index = element.range.upperBound
                        while index ≠ element.range.lowerBound {
                            highlighted.scalars.insert(underline, at: index)
                            index = source.scalars.index(before: index)
                        }
                    }
                    let specification = sourceDirectory.appendingPathComponent("After").appendingPathComponent(name).appendingPathComponent(url.deletingPathExtension().lastPathComponent).appendingPathExtension("txt")
                    SDGPersistenceTestUtilities.compare(highlighted, against: specification, overwriteSpecificationInsteadOfFailing: overwriteSpecificationInsteadOfFailing, file: file, line: line)
                    return highlighted
                }

                // Unidentified
                let unidentified = compare(specification: "Unidentified", overwriteSpecificationInsteadOfFailing: false) { element in
                    return element is UnidentifiedSyntaxElement
                }
                XCTAssert(¬unidentified.scalars.contains(underline), "There are unidentified syntax elements in “\(url.lastPathComponent)”.")

                // Text Freedom
                compare(specification: "Arbitrary Text", overwriteSpecificationInsteadOfFailing: false) { element in
                    (element as? AtomicSyntaxElement)?.textFreedom == .arbitrary
                }
                compare(specification: "Aliasable Text", overwriteSpecificationInsteadOfFailing: false) { element in
                    (element as? AtomicSyntaxElement)?.textFreedom == .aliasable
                }
                compare(specification: "Invariable Text", overwriteSpecificationInsteadOfFailing: false) { element in
                    (element as? AtomicSyntaxElement)?.textFreedom == .invariable
                }

                // API
                let api = sourceFile.api(source: source).sorted().map({ $0.summary.joined(separator: "\n") }).joined(separator: "\n")
                SDGPersistenceTestUtilities.compare(api, against: sourceDirectory.appendingPathComponent("After").appendingPathComponent("API").appendingPathComponent(url.deletingPathExtension().lastPathComponent).appendingPathExtension("txt"), overwriteSpecificationInsteadOfFailing: false)
            }
        } catch {
            XCTFail("\(error)")
        }
    }

    func testSourceKitError() {
        testCustomStringConvertibleConformance(of: SourceKit.Error.dynamicLinkerError(description: "[linker’s description]"), localizations: InterfaceLocalization.self, uniqueTestName: "Dynamic Linker Error", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: SourceKit.Error.dynamicLinkerError(description: nil), localizations: InterfaceLocalization.self, uniqueTestName: "Dynamic Linker Error (Unknown)", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: SourceKit.Error.sourceKitError(description: "[SourceKit’s description]"), localizations: InterfaceLocalization.self, uniqueTestName: "SourceKit Error", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: SourceKit.Error.unknownTypeVariant(identifier: 100), localizations: InterfaceLocalization.self, uniqueTestName: "Unknown Type Variant", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: SourceKit.Error.unknownResponse(contents: "[response]"), localizations: InterfaceLocalization.self, uniqueTestName: "Unknown Response", overwriteSpecificationInsteadOfFailing: false)
    }

    func testUnidentifiedSyntaxElement() {
        XCTAssertEqual(UnidentifiedSyntaxElement(range: "".scalars.bounds).textFreedom, .invariable)
    }
}
