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

    func testAPIParsing() throws {
        for packageName in ["PackageToDocument", "PackageToDocument2"] {
            let package = PackageRepository(at: mocksDirectory.appendingPathComponent(packageName))
            let parsed = try PackageAPI(package: package.package())
            XCTAssertNotNil(parsed.documentation)
            let summary = parsed.summary().joined(separator: "\n")
            let specification = testSpecificationDirectory().appendingPathComponent("API/\(parsed.name).txt")
            SDGPersistenceTestUtilities.compare(summary, against: specification, overwriteSpecificationInsteadOfFailing: false)

            if packageName == "PackageToDocument" {
                XCTAssert("Structure" ∈ parsed.identifierList())
            }

            let rootElement = APIElement.package(parsed)
            for element in rootElement.flattenedTree() {
                element.userInformation = true
            }
            for element in rootElement.flattenedTree() {
                XCTAssertEqual(element.userInformation as? Bool, true)
                _ = element.libraries
                _ = element.modules
                _ = element.types
                _ = element.extensions
                _ = element.protocols
                _ = element.cases
                _ = element.typeProperties
                _ = element.typeMethods
                _ = element.initializers
                _ = element.properties
                _ = element.subscripts
                _ = element.methods
                _ = element.conformances
            }
            XCTAssertFalse(rootElement < rootElement)
            XCTAssertTrue(parsed == parsed)
        }
    }

    func testCallout() {
        for localization in InterfaceLocalization.allCases {
            let specification = Callout.allCases.map({ $0.localizedText(localization.code) }).joined(separator: "\n")
            compare(String(specification), against: testSpecificationDirectory().appendingPathComponent("Localization/Callouts/\(localization.icon!).txt"), overwriteSpecificationInsteadOfFailing: false)
        }
    }

    func testCodeFragmentSyntax() throws {
        let source = "\u{2F}\u{2F}/ `selector(style:notation:)`\nfunc function() {}"
        let syntax = try SyntaxTreeParser.parse(source)
        let highlighted = syntax.syntaxHighlightedHTML(inline: true, internalIdentifiers: ["selector(style:notation:)"], symbolLinks: ["selector(style:notation:)": "domain.tld"])
        XCTAssert(highlighted.contains("internal identifier"))
        XCTAssert(highlighted.contains("domain.tld"))
    }

    func testCSS() {
        XCTAssert(¬SyntaxHighlighter.css.contains("Apache"))
    }

    func testExtension() {
        XCTAssert(ExtensionAPI(type: "String").extendsSameType(as: ExtensionAPI(type: "String")))
        XCTAssertFalse(ExtensionAPI(type: "String").extendsSameType(as: ExtensionAPI(type: "Int")))
    }

    func testLineDeveloperCommentSyntax() throws {
        let syntax = try SyntaxTreeParser.parse("/\u{2F} Comment.")
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
        let syntax = try SyntaxTreeParser.parse("//\u{2F} Documentation.")
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
            let sourceFile = try SyntaxTreeParser.parse(url)

            let originalSource = try String(from: url)
            var roundTripSource = ""
            sourceFile.write(to: &roundTripSource)
            XCTAssertEqual(roundTripSource, originalSource)

            TextFreedomHighlighter.targetTestFreedom = .arbitrary
            try TextFreedomHighlighter().compare(syntax: sourceFile, parsedFrom: url, againstSpecification: "Arbitrary Text", overwriteSpecificationInsteadOfFailing: false)

            TextFreedomHighlighter.targetTestFreedom = .aliasable
            try TextFreedomHighlighter().compare(syntax: sourceFile, parsedFrom: url, againstSpecification: "Aliasable Text", overwriteSpecificationInsteadOfFailing: false)

            TextFreedomHighlighter.targetTestFreedom = .invariable
            try TextFreedomHighlighter().compare(syntax: sourceFile, parsedFrom: url, againstSpecification: "Invariable Text", overwriteSpecificationInsteadOfFailing: false)

            let highlighted = sourceFile.syntaxHighlightedHTML(inline: false, internalIdentifiers: [], symbolLinks: ["doSomething": "domain.tld"])
            SDGPersistenceTestUtilities.compare(HTMLPage(content: highlighted, cssPath: "../../../../../Resources/SDGSwiftSource/Syntax%20Highlighting.css"), against: sourceDirectory.appendingPathComponent("After").appendingPathComponent("Syntax Highlighting").appendingPathComponent(url.deletingPathExtension().lastPathComponent).appendingPathExtension("html"), overwriteSpecificationInsteadOfFailing: false)

            // API
            let api = sourceFile.api().sorted()
            let summary = api.map({ $0.summary().joined(separator: "\n") }).joined(separator: "\n")
            SDGPersistenceTestUtilities.compare(summary, against: sourceDirectory.appendingPathComponent("After").appendingPathComponent("API").appendingPathComponent(url.deletingPathExtension().lastPathComponent).appendingPathExtension("txt"), overwriteSpecificationInsteadOfFailing: false)

            let identifiers = api.reduce(into: Set<String>()) { $0 ∪= $1.identifierList() }
            let syntaxHighlighting = api.map({ $0.flattenedTree() }).joined().map({ element in
                if var declaration = element.declaration?.syntaxHighlightedHTML(inline: false, internalIdentifiers: identifiers) {

                    if let constraints = element.constraints?.syntaxHighlightedHTML(inline: false, internalIdentifiers: identifiers) {
                        declaration += "\n" + constraints
                    }

                    if let conditions = element.compilationConditions?.syntaxHighlightedHTML(inline: false, internalIdentifiers: identifiers) {
                        declaration = conditions + "\n" + declaration
                    }

                    return declaration
                } else {
                    return nil
                }
            }).compactMap({ $0 }).joined(separator: "\n\n")
            SDGPersistenceTestUtilities.compare(HTMLPage(content: syntaxHighlighting, cssPath: "../../../../../Resources/SDGSwiftSource/Syntax%20Highlighting.css"), against: sourceDirectory.appendingPathComponent("After").appendingPathComponent("API Syntax Highlighting").appendingPathComponent(url.deletingPathExtension().lastPathComponent).appendingPathExtension("html"), overwriteSpecificationInsteadOfFailing: false)

            if url.deletingPathExtension().lastPathComponent == "Documentation" {
                search: for element in api {
                    `switch`: switch element {
                    case .extension(let `extension`):
                        let method = `extension`.methods.first(where: { $0.name.source().hasPrefix("performAction") })!
                        let methods = [method, `extension`.methods.first(where: { $0.name.source().hasPrefix("withSeparateParameters") })!]
                        _ = method.documentation!.renderedHTML(localization: "zxx")

                        for localization in InterfaceLocalization.allCases {
                            let rendered = methods.map({ $0.documentation!.renderedSpecification(localization: localization.code) }).joined(separator: "\n")

                            let specification = testSpecificationDirectory().appendingPathComponent("Source/After/Rendered Documentation/\(localization.icon!).html")
                            SDGPersistenceTestUtilities.compare(HTMLPage(content: rendered, cssPath: "../../../../Resources/SDGSwiftSource/Syntax%20Highlighting.css"), against: specification, overwriteSpecificationInsteadOfFailing: false)
                        }

                        break search
                    default:
                        break `switch`
                    }
                }
            }
        }
    }
}
