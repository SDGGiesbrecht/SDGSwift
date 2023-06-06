/*
 APITests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGText
import SDGLocalization

import SDGSwift
import SDGSwiftDocumentation

import SymbolKit
  import SwiftSyntax

import SDGSwiftLocalizations

import XCTest

import SDGPersistenceTestUtilities
import SDGLocalizationTestUtilities
import SDGXCTestUtilities

import SDGSwiftTestUtilities
import SDGSwiftSource

class APITests: SDGSwiftTestUtilities.TestCase {
  // #warning(Debugging...)
  #if !os(Android)

  func testSymbolDocumentation() {
    _ = SDGSwiftDocumentation.SymbolDocumentation(
      developerComments: SymbolGraph.LineList([]),
      documentationComment: SymbolGraph.LineList([])
    )
  }

  func testModuleAPI() {
    // #workaround(Swift 5.8.0, Web compiler bug leads to out of bounds memory access.)
    #if !os(WASI)
    let module = ModuleAPI(
      name: "MyModule",
      documentation: [],
      location: nil,
      symbolGraphs: [],
      sources: [
        URL(fileURLWithPath: #filePath),
        URL(fileURLWithPath: #filePath),
      ]
    )
    _ = module.names.subHeading
    _ = module.docComment
      XCTAssertNil(
        ModuleAPI(
          name: "MyModule",
          symbolGraphs: [],
          sources: [],
          manifestURL: "somewhere.swift",
          manifestSource: SourceFileSyntax(
            statements: CodeBlockItemListSyntax([]),
            eofToken: TokenSyntax(.eof)
          )
        ).docComment
      )
    let moduleDirectory = mocksDirectory
      .appendingPathComponent("PackageToDocument")
      .appendingPathComponent("Sources")
      .appendingPathComponent("PrimaryModule")
    _ = ModuleAPI(
      name: "MyModule",
      documentation: [],
      location: nil,
      symbolGraphs: [],
      sources: [
        moduleDirectory.appendingPathComponent("Operator.swift"),
        moduleDirectory.appendingPathComponent("Precedence.swift")
      ]
    )
    #endif
  }

  func testLibraryAPI() {
    let library = LibraryAPI(
      name: "MyLibrary",
      documentation: [],
      location: nil,
      modules: ["MyModule"]
    )
    _ = library.names.subHeading
    // #workaround(Swift 5.8.0, Web compiler bug leads to out of bounds memory access.)
    #if !os(WASI)
      _ = LibraryAPI(
        name: "MyLibrary",
        modules: ["MyModule"],
        manifestURL: "Package.swift",
        manifest: SourceFileSyntax(
          statements: CodeBlockItemListSyntax([]),
          eofToken: TokenSyntax(.eof)
        )
      )
    #endif
  }

  func testOperator() {
    _ =
      Operator(
        names: SymbolGraph.Symbol.Names(
          title: "==",
          navigator: nil,
          subHeading: [
            SymbolGraph.Symbol.DeclarationFragments.Fragment(
              kind: .identifier,
              spelling: "==",
              preciseIdentifier: nil
            )
          ],
          prose: nil
        ),
        declaration: SymbolGraph.Symbol.DeclarationFragments(declarationFragments: []),
        documentation: [],
        location: nil
      )
      < Operator(
        names: SymbolGraph.Symbol.Names(
          title: "≠",
          navigator: nil,
          subHeading: [
            SymbolGraph.Symbol.DeclarationFragments.Fragment(
              kind: .identifier,
              spelling: "≠",
              preciseIdentifier: nil
            )
          ],
          prose: nil
        ),
        declaration: SymbolGraph.Symbol.DeclarationFragments(declarationFragments: []),
        documentation: [],
        location: nil
      )
    _ =
      Operator(
        names: SymbolGraph.Symbol.Names(
          title: "==",
          navigator: nil,
          subHeading: [
            SymbolGraph.Symbol.DeclarationFragments.Fragment(
              kind: .identifier,
              spelling: "==",
              preciseIdentifier: nil
            )
          ],
          prose: nil
        ),
        declaration: SymbolGraph.Symbol.DeclarationFragments(declarationFragments: []),
        documentation: [],
        location: nil
      )
      == Operator(
        names: SymbolGraph.Symbol.Names(
          title: "≠",
          navigator: nil,
          subHeading: [
            SymbolGraph.Symbol.DeclarationFragments.Fragment(
              kind: .identifier,
              spelling: "≠",
              preciseIdentifier: nil
            )
          ],
          prose: nil
        ),
        declaration: SymbolGraph.Symbol.DeclarationFragments(declarationFragments: []),
        documentation: [],
        location: nil
      )
    var cache: [URL: SymbolGraph.Symbol.CachedSource] = [:]
    _ = Operator(
      names: SymbolGraph.Symbol.Names(
        title: "==",
        navigator: nil,
        subHeading: [],
        prose: nil
      ),
      declaration: SymbolGraph.Symbol.DeclarationFragments(declarationFragments: []),
      documentation: [],
      location: nil
    ).parseDocumentation(cache: &cache, module: nil)
  }

  func testPackageRepository() {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
      XCTAssert(thisRepository.documentation(packageName: "SDGSwift").count ≠ 0)
    #endif
  }

  func testPackageAPI() {
    // #workaround(Swift 5.8.0, Web compiler bug leads to out of bounds memory access.)
    #if !os(WASI)
    let package = PackageAPI(
      name: "MyPackage",
      documentation: [],
      location: nil,
      libraries: [
        LibraryAPI(
          name: "MyLibrary",
          documentation: [],
          location: nil,
          modules: ["MyModule"]
        )
      ],
      symbolGraphs: [
        SymbolGraph(
          metadata: SymbolGraph.Metadata(
            formatVersion: SymbolGraph.SemanticVersion(major: 1, minor: 0, patch: 0),
            generator: "My Generator"
          ),
          module: SymbolGraph.Module(
            name: "MyModule",
            platform: SymbolGraph.Platform(
              architecture: nil,
              vendor: nil,
              operatingSystem: nil,
              environment: nil
            )
          ),
          symbols: [],
          relationships: []
        )
      ],
      moduleSources: [:],
      moduleDocumentationCommentLookup: { _ in return [] },
      moduleDeclarationLocationLookup: { _ in return nil }
    )
    _ = package.symbolGraphs()
    _ = package.names.subHeading
      XCTAssertNil(
        PackageAPI(
          name: "MyPackage",
          manifestURL: "somewhere.swift",
          manifestSource: SourceFileSyntax(
            statements: CodeBlockItemListSyntax([]),
            eofToken: TokenSyntax(.eof)
          ),
          libraries: [
            LibraryAPI(
              name: "MyLibrary",
              modules: ["MyModule"],
              manifestURL: "Package.swift",
              manifest: SourceFileSyntax(
                statements: CodeBlockItemListSyntax([]),
                eofToken: TokenSyntax(.eof)
              )
            )
          ],
          symbolGraphs: [],
          moduleSources: [:]
        ).docComment
      )
      _ = PackageAPI(
        name: "MyPackage",
        manifestURL: "somewhere.swift",
        manifestSource: SourceFileSyntax(
          statements: CodeBlockItemListSyntax([
            CodeBlockItemSyntax(
              item: .decl(DeclSyntax(VariableDeclSyntax(
                attributes: nil,
                modifiers: nil,
                letOrVarKeyword: .letKeyword(trailingTrivia: .space),
                bindings: PatternBindingListSyntax([
                  PatternBindingSyntax(
                    pattern: PatternSyntax(IdentifierPatternSyntax(
                      identifier: .identifier("package")
                    )),
                    typeAnnotation: nil,
                    initializer: InitializerClauseSyntax(
                      equal: .equalToken(leadingTrivia: .space, trailingTrivia: .space),
                      value: FunctionCallExprSyntax(
                        calledExpression: IdentifierExprSyntax(
                          identifier: .identifier("Package"),
                          declNameArguments: nil
                        ),
                        leftParen: .leftParenToken(),
                        argumentList: TupleExprElementListSyntax([
                          TupleExprElementSyntax(
                            label: .identifier("name"),
                            colon: .colonToken(trailingTrivia: .space),
                            expression: StringLiteralExprSyntax(
                              openQuote: .stringQuoteToken(),
                              segments: StringLiteralSegmentsSyntax([
                                .stringSegment(StringSegmentSyntax(
                                  content: .stringSegment("MyPackage")
                                ))
                              ]),
                              closeQuote: .stringQuoteToken()
                            ),
                            trailingComma: nil)
                        ]),
                        rightParen: .rightParenToken(),
                        trailingClosure: nil,
                        additionalTrailingClosures: nil
                      )
                    ),
                    accessor: nil,
                    trailingComma: nil
                  )
                ])
              ))),
              semicolon: nil,
              errorTokens: nil
            )
          ]),
          eofToken: TokenSyntax(.eof)
        ),
        libraries: [],
        symbolGraphs: [],
        moduleSources: [:]
      )
    #endif
  }

  func testPrecedenceGroup() {
    _ =
      PrecedenceGroup(
        names: SymbolGraph.Symbol.Names(
          title: "A",
          navigator: nil,
          subHeading: [
            SymbolGraph.Symbol.DeclarationFragments.Fragment(
              kind: .identifier,
              spelling: "A",
              preciseIdentifier: nil
            )
          ],
          prose: nil
        ),
        declaration: SymbolGraph.Symbol.DeclarationFragments(declarationFragments: []),
        documentation: [],
        location: nil
      )
      < PrecedenceGroup(
        names: SymbolGraph.Symbol.Names(
          title: "B",
          navigator: nil,
          subHeading: [
            SymbolGraph.Symbol.DeclarationFragments.Fragment(
              kind: .identifier,
              spelling: "B",
              preciseIdentifier: nil
            )
          ],
          prose: nil
        ),
        declaration: SymbolGraph.Symbol.DeclarationFragments(declarationFragments: []),
        documentation: [],
        location: nil
      )
    _ =
      PrecedenceGroup(
        names: SymbolGraph.Symbol.Names(
          title: "A",
          navigator: [
            SymbolGraph.Symbol.DeclarationFragments.Fragment(
              kind: .identifier,
              spelling: "A",
              preciseIdentifier: nil
            )
          ],
          subHeading: [
            SymbolGraph.Symbol.DeclarationFragments.Fragment(
              kind: .identifier,
              spelling: "A",
              preciseIdentifier: nil
            )
          ],
          prose: "A"
        ),
        declaration: SymbolGraph.Symbol.DeclarationFragments(declarationFragments: []),
        documentation: [],
        location: nil
      )
      < PrecedenceGroup(
        names: SymbolGraph.Symbol.Names(
          title: "A",
          navigator: [
            SymbolGraph.Symbol.DeclarationFragments.Fragment(
              kind: .identifier,
              spelling: "A",
              preciseIdentifier: nil
            )
          ],
          subHeading: [
            SymbolGraph.Symbol.DeclarationFragments.Fragment(
              kind: .identifier,
              spelling: "A",
              preciseIdentifier: nil
            )
          ],
          prose: "A"
        ),
        declaration: SymbolGraph.Symbol.DeclarationFragments(declarationFragments: []),
        documentation: [],
        location: nil
      )
    _ =
      PrecedenceGroup(
        names: SymbolGraph.Symbol.Names(
          title: "A",
          navigator: nil,
          subHeading: nil,
          prose: nil
        ),
        declaration: SymbolGraph.Symbol.DeclarationFragments(declarationFragments: []),
        documentation: [],
        location: nil
      )
      < PrecedenceGroup(
        names: SymbolGraph.Symbol.Names(
          title: "A",
          navigator: nil,
          subHeading: nil,
          prose: nil
        ),
        declaration: SymbolGraph.Symbol.DeclarationFragments(declarationFragments: []),
        documentation: [],
        location: nil
      )
    _ =
      PrecedenceGroup(
        names: SymbolGraph.Symbol.Names(
          title: "A",
          navigator: nil,
          subHeading: nil,
          prose: nil
        ),
        declaration: SymbolGraph.Symbol.DeclarationFragments(declarationFragments: []),
        documentation: [],
        location: nil
      )
      == PrecedenceGroup(
        names: SymbolGraph.Symbol.Names(
          title: "A",
          navigator: nil,
          subHeading: nil,
          prose: nil
        ),
        declaration: SymbolGraph.Symbol.DeclarationFragments(declarationFragments: []),
        documentation: [],
        location: nil
      )
  }

  func testSymbolGraphError() {
    struct Elipsis: PresentableError {
      func presentableDescription() -> StrictString { "..." }
    }
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
      testCustomStringConvertibleConformance(
        of: SymbolGraph.LoadingError.exportError(.executionError(.foundationError(Elipsis()))),
        localizations: InterfaceLocalization.self,
        uniqueTestName: "Export",
        overwriteSpecificationInsteadOfFailing: false
      )
      testCustomStringConvertibleConformance(
        of: SymbolGraph.LoadingError.packageLoadingError(.packageManagerError(Elipsis())),
        localizations: InterfaceLocalization.self,
        uniqueTestName: "Manifest Load",
        overwriteSpecificationInsteadOfFailing: false
      )
      testCustomStringConvertibleConformance(
        of: SymbolGraph.LoadingError.loadingError(Elipsis()),
        localizations: InterfaceLocalization.self,
        uniqueTestName: "Load",
        overwriteSpecificationInsteadOfFailing: false
      )
    #endif
  }

  func testSymbolGraph() throws {
    for packageURL in documentationTestPackages {
      let package = PackageRepository(at: packageURL)
      #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
        _ = package.symbolGraphs(filteringUnreachable: false)
        let api = try package.api().get()

        let symbols: [SymbolLike] = [api]
          .appending(contentsOf: api.libraries)
          .appending(
            contentsOf: api.modules.flatMap(
              { (module) -> [SymbolLike] in
                return [module]
                  .appending(
                    contentsOf: module.symbolGraphs.flatMap({ graph in
                      return graph.symbols.values
                    })
                  )
                  .appending(contentsOf: module.operators)
                  .appending(contentsOf: module.precedenceGroups)
              }
            )
          )

        _ = symbols.map({ symbol in
          return symbol.names.title
        }).sorted().joined(separator: "\n")

        _ = symbols.compactMap({ symbol in
          return symbol.names.subHeading?.map({ fragment in
            return fragment.spelling
          }).joined()
        }).sorted().joined(separator: "\n")

        _ = symbols.compactMap({ symbol in
          return symbol.declaration?.declarationFragments.map({ fragment in
            return fragment.spelling
          }).joined()
        }).sorted().joined(separator: "\n")

        _ = symbols.compactMap({ symbol in
          return symbol.docComment?.lines.map({ line in
            return line.text
          }).joined(separator: "\n")
        }).sorted().joined(separator: "\n\n")

        var cache: [URL: SymbolGraph.Symbol.CachedSource] = [:]
        for symbol in symbols {
          if let standard = symbol as? SymbolGraph.Symbol,
            standard.docComment?.moduleName == "Swift"
          {
            continue  // Parsing is not expected to work.
          }
          XCTAssertEqual(
            symbol.parseDocumentation(cache: &cache, module: "PrimaryModule").last?
              .documentationComment,
            symbol.docComment
          )
        }
      #endif
    }
  }

  func testSymbolGraphLineList() {
    _ = SymbolGraph.LineList([
      SymbolGraph.LineList.Line(text: "...", range: nil),
      SymbolGraph.LineList.Line(
        text: "...",
        range: SymbolGraph.LineList.SourceRange(
          start: SymbolGraph.LineList.SourceRange.Position(line: 2, character: 4),
          end: SymbolGraph.LineList.SourceRange.Position(line: 2, character: 7)
        )
      ),
    ])
  }

  func testSymbolGraphSymbol() {
    let symbol = SymbolGraph.Symbol(
      identifier: SymbolGraph.Symbol.Identifier(precise: "symbol", interfaceLanguage: "Swift"),
      names: SymbolGraph.Symbol.Names(
        title: "symbol",
        navigator: nil,
        subHeading: nil,
        prose: nil
      ),
      pathComponents: ["path", "components"],
      docComment: nil,
      accessLevel: SymbolGraph.Symbol.AccessControl(rawValue: "public"),
      kind: SymbolGraph.Symbol.Kind(parsedIdentifier: .func, displayName: "function"),
      mixins: [:]
    )
    _ = symbol.declaration
    _ = symbol.location
    var cache: [URL: SymbolGraph.Symbol.CachedSource] = [:]
    _ = symbol.parseDocumentation(cache: &cache, module: nil)

    var modified = symbol
    modified.docComment = SymbolGraph.LineList.init([])
    _ = modified.parseDocumentation(cache: &cache, module: nil)
    #if !os(Windows) // #workaround(SymbolKit 0.50800.0, Crashes checking URI.)
    modified.location = SymbolGraph.Symbol.Location(
      uri: "some file.swift",
      position: SymbolGraph.LineList.SourceRange.Position(line: 0, character: 0)
    )
    #if !os(Linux)  // #workaround(Swift 5.7, Foundation crashes instead of throwing.)
      _ = modified.parseDocumentation(cache: &cache, module: nil)
    #endif
    for kind in [
      .associatedtype,
      .class,
      .deinit,
      .enum,
      .case,
      .func,
      .`init`,
      .ivar,
      .property,
      .protocol,
      .property,
      .struct,
      .subscript,
      .typealias
    ] as [SymbolGraph.Symbol.KindIdentifier] {
      _ = SymbolGraph.Symbol(
        identifier: SymbolGraph.Symbol.Identifier(precise: "identifier", interfaceLanguage: "swift"),
        names: SymbolGraph.Symbol.Names(title: "title", navigator: nil, subHeading: nil, prose: nil),
        pathComponents: [],
        docComment: SymbolGraph.LineList(
          [
            SymbolGraph.LineList.Line(
              text: "...",
              range: SymbolGraph.LineList.SourceRange(
                start: SymbolGraph.LineList.SourceRange.Position(line: 1, character: 1),
                end: SymbolGraph.LineList.SourceRange.Position(line: 1, character: 1)
              )
            )
          ],
          uri: URL(fileURLWithPath: #filePath).absoluteString
        ),
        accessLevel: SymbolGraph.Symbol.AccessControl(rawValue: "internal"),
        kind: SymbolGraph.Symbol.Kind(parsedIdentifier: kind, displayName: "class"),
        mixins: [:]
      ).parseDocumentation(cache: &cache, module: nil)
    }
    #endif
  }

  func testSymbolGraphSymbolLocation() {
    _ = SymbolGraph.Symbol.Location(
      uri: "somewhere.swift",
      position: SymbolGraph.LineList.SourceRange.Position(line: 0, character: 0)
    )
  }
  #endif
}
