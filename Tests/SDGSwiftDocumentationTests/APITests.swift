/*
 APITests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

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
#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax
#endif

import SDGSwiftLocalizations

import XCTest

import SDGPersistenceTestUtilities
import SDGLocalizationTestUtilities
import SDGXCTestUtilities

import SDGSwiftTestUtilities
import SDGSwiftSource

class APITests: SDGSwiftTestUtilities.TestCase {

  func testModuleAPI() {
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
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
      XCTAssertNil(
        ModuleAPI(
          name: "MyModule",
          symbolGraphs: [],
          sources: [],
          manifestURL: "somewhere.swift",
          manifestSource: SyntaxFactory.makeBlankSourceFile()
        ).docComment
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
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
      _ = LibraryAPI(
        name: "MyLibrary",
        modules: ["MyModule"],
        manifestURL: "Package.swift",
        manifest: SyntaxFactory.makeBlankSourceFile()
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
    ).parseDocumentation(cache: &cache)
  }

  func testPackageAPI() {
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
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
      XCTAssertNil(
        PackageAPI(
          name: "MyPackage",
          manifestURL: "somewhere.swift",
          manifestSource: SyntaxFactory.makeBlankSourceFile(),
          libraries: [
            LibraryAPI(
              name: "MyLibrary",
              modules: ["MyModule"],
              manifestURL: "Package.swift",
              manifest: SyntaxFactory.makeBlankSourceFile()
            )
          ],
          symbolGraphs: [],
          moduleSources: [:]
        ).docComment
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
      let packageName = package.location.lastPathComponent
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

        let names = symbols.map({ symbol in
          return symbol.names.title
        }).sorted().joined(separator: "\n")
        let namesSpecification = testSpecificationDirectory().appendingPathComponent(
          "API/Names/\(packageName).txt"
        )
        SDGPersistenceTestUtilities.compare(
          names,
          against: namesSpecification,
          overwriteSpecificationInsteadOfFailing: false
        )

        let subHeadings = symbols.compactMap({ symbol in
          return symbol.names.subHeading?.map({ fragment in
            return fragment.spelling
          }).joined()
        }).sorted().joined(separator: "\n")
        let subHeadingsSpecification = testSpecificationDirectory().appendingPathComponent(
          "API/SubHeadings/\(packageName).txt"
        )
        SDGPersistenceTestUtilities.compare(
          subHeadings,
          against: subHeadingsSpecification,
          overwriteSpecificationInsteadOfFailing: false
        )

        let declarations = symbols.compactMap({ symbol in
          return symbol.declaration?.declarationFragments.map({ fragment in
            return fragment.spelling
          }).joined()
        }).sorted().joined(separator: "\n")
        let declarationsSpecification = testSpecificationDirectory().appendingPathComponent(
          "API/Declarations/\(packageName).txt"
        )
        SDGPersistenceTestUtilities.compare(
          declarations,
          against: declarationsSpecification,
          overwriteSpecificationInsteadOfFailing: false
        )

        let documentation = symbols.compactMap({ symbol in
          return symbol.docComment?.lines.map({ line in
            return line.text
          }).joined(separator: "\n")
        }).sorted().joined(separator: "\n\n")
        let documentationSpecification = testSpecificationDirectory().appendingPathComponent(
          "API/Documentation/\(packageName).txt"
        )
        SDGPersistenceTestUtilities.compare(
          documentation,
          against: documentationSpecification,
          overwriteSpecificationInsteadOfFailing: false
        )

        var cache: [URL: SymbolGraph.Symbol.CachedSource] = [:]
        for symbol in symbols {
          if let standard = symbol as? SymbolGraph.Symbol,
            standard.isDocCommentFromSameModule ≠ true {
            continue  // Parsing is not expected to work.
          }
          XCTAssertEqual(
            symbol.parseDocumentation(cache: &cache).last?.documentationComment,
            symbol.docComment
          )
        }
      #endif
    }
  }

  func testSymbolGraphLineList() {
    _ = SymbolGraph.LineList(lines: [
      SymbolGraph.LineList.Line(text: "...", range: nil)
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
  }
}
