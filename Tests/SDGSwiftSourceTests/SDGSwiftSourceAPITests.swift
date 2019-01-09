/*
 SDGSwiftSourceAPITests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

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
                _ = element.instanceProperties
                _ = element.subscripts
                _ = element.instanceMethods
                _ = element.operators
                _ = element.precedenceGroups
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

        var foundColon = false
        try FunctionalSyntaxScanner(checkSyntax: { syntax, context in
            if let token = syntax as? TokenSyntax,
                token.tokenKind == .colon {
                foundColon = true
                XCTAssertEqual(source[token.syntaxRange(in: context)], ":")
            }
            return true
        }).scan(syntax)
        XCTAssertTrue(foundColon)
    }

    func testCSS() {
        XCTAssert(¬SyntaxHighlighter.css.contains("Apache"))
    }

    func testExtension() {
        XCTAssert(ExtensionAPI(type: "String").extendsSameType(as: ExtensionAPI(type: "String")))
        XCTAssertFalse(ExtensionAPI(type: "String").extendsSameType(as: ExtensionAPI(type: "Int")))
    }

    func testFunctionalSyntaxScanner() throws {
        let source = """
            /// ```swift
            /// print("Hello, world!")
            /// ```
            func helloWorld() {
                print("Hello, world!")
            }
            """
        let syntax = try SyntaxTreeParser.parse(source)

        var scanned: Set<String> = []
        let scanner = FunctionalSyntaxScanner(
            checkSyntax: { syntax, context in
                scanned.insert(syntax.source())
                return true
        },
            checkExtendedSyntax: { syntax in
                scanned.insert(syntax.text)
                return true
        },
            checkTrivia: { trivia in
                scanned.insert(trivia.source())
                return true
        },
            checkTriviaPiece: { trivia in
                scanned.insert(trivia.text)
                return true
        },
            shouldExtendToken: { _ in return true },
            shouldExtendFragment: { _ in return true })
        try scanner.scan(syntax)
        XCTAssert(scanned.contains("print(\u{22}Hello, world!\u{22})"))
        XCTAssert(scanned.contains("```swift"))
        XCTAssert(scanned.contains(" "))
        XCTAssert(scanned.contains("/\u{2F}\u{2F} ```swift"))

        try FunctionalSyntaxScanner().scan(syntax)
    }

    func testLineDeveloperCommentSyntax() throws {
        let syntax = try SyntaxTreeParser.parse("/\u{2F} Comment.")
        try SyntaxScanner().scan(syntax)
        XCTAssertNil(syntax.ancestors().makeIterator().next())

        class CommentScanner : SyntaxScanner {
            override func visit(_ node: ExtendedSyntax, context: ExtendedSyntaxContext) -> Bool {
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
            override func visit(_ node: ExtendedSyntax, context: ExtendedSyntaxContext) -> Bool {
                if let comment = node as? LineDocumentationSyntax {
                    XCTAssertNotNil(comment.content)
                }
                return true
            }
        }
        try DocumentationScanner().scan(syntax)
    }

    func testLocations() throws {
        let source = "/\u{2F} ...\nlet x = 0 \n"
        let syntax = try SyntaxTreeParser.parse(source)
        var statementsFound = false
        let scanner = FunctionalSyntaxScanner(checkSyntax: { syntax, context in
            if syntax is CodeBlockItemListSyntax {
                statementsFound = true
                XCTAssertEqual(syntax.triviaRange(in: context), source.startIndex ..< source.index(source.endIndex, offsetBy: −1))
                XCTAssertEqual(syntax.syntaxRange(in: context), source.index(source.startIndex, offsetBy: 7) ..< source.index(source.endIndex, offsetBy: −2))
                return false
            }
            return true
        })
        try scanner.scan(syntax)
        XCTAssertTrue(statementsFound)
    }

    func testParsing() throws {
        for url in try FileManager.default.deepFileEnumeration(in: beforeDirectory) where url.lastPathComponent ≠ ".DS_Store" {
            let sourceFile = try SyntaxTreeParser.parseAndRetry(url)

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
                var found = false
                search: for element in api {
                    `switch`: switch element {
                    case .extension(let `extension`):
                        found = true
                        let method = `extension`.instanceMethods.first(where: { $0.name.source().hasPrefix("performAction") })!
                        let methods = [method, `extension`.instanceMethods.first(where: { $0.name.source().hasPrefix("withSeparateParameters") })!]
                        _ = method.documentation!.renderedHTML(localization: "zxx")

                        for localization in InterfaceLocalization.allCases {
                            let rendered = methods.map({ $0.documentation!.renderedSpecification(localization: localization.code) }).joined(separator: "\n")

                            let specification = testSpecificationDirectory().appendingPathComponent("Source/After/Rendered Documentation/\(localization.icon!).html")
                            SDGPersistenceTestUtilities.compare(HTMLPage(content: rendered, cssPath: "../../../../Resources/SDGSwiftSource/Syntax%20Highlighting.css"), against: specification, overwriteSpecificationInsteadOfFailing: false)
                        }

                        let blockDocumentation = `extension`.instanceMethods.first(where: { $0.name.source().hasPrefix("documentedWithBlockStyle") })!
                        XCTAssertNotNil(blockDocumentation.documentation)

                        break search
                    default:
                        break `switch`
                    }
                }
                XCTAssert(found, "Failed to find test documentation.")
            }
            if url.deletingPathExtension().lastPathComponent == "Attributes" {
                var found = false
                search: for element in api {
                    `switch`: switch element {
                    case .function(let function):
                        if function.name.identifier.text == "withHiddenAttribute" {
                            XCTAssertNotNil(element.documentation)
                            found = true
                            break search
                        }
                    default:
                        break `switch`
                    }
                }
                XCTAssert(found, "Failed to find hidden attribute test.")
            }
        }
    }

    func testTree() throws {
        let source = "/\u{2F} ...\nlet x = 0 \n"
        let syntax = try SyntaxTreeParser.parse(source)
        XCTAssertNil(syntax.ancestors().first(where: { _ in true }))
        XCTAssertNil(SyntaxFactory.makeToken(.identifier("a")).previousToken())
        XCTAssertNil(SyntaxFactory.makeToken(.identifier("a")).nextToken())
        XCTAssertNil(syntax.firstToken()!.previousToken())
        XCTAssertNil(syntax.lastToken()!.nextToken())
        XCTAssertEqual(syntax.firstToken()!.tokenKind, .letKeyword)
        XCTAssertEqual(syntax.lastToken()!.tokenKind, .eof)
        let `let` = syntax.firstToken()!
        XCTAssertEqual(`let`.firstPrecedingTrivia()?.text, TriviaPiece.newlines(1).text)
        XCTAssertEqual(`let`.firstFollowingTrivia()?.text, TriviaPiece.spaces(1).text)
        let x = `let`.nextToken()
        XCTAssertEqual(x?.firstPrecedingTrivia()?.text, TriviaPiece.spaces(1).text)
        XCTAssertEqual(x?.firstFollowingTrivia()?.text, TriviaPiece.spaces(1).text)
        let eof = syntax.lastToken()!
        XCTAssertEqual(eof.firstPrecedingTrivia()?.text, TriviaPiece.newlines(1).text)
        XCTAssertNil(eof.firstFollowingTrivia()?.text)
    }
}
