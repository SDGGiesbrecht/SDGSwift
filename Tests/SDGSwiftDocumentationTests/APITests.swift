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
      symbolGraphs: [],
      sources: [
        URL(fileURLWithPath: #filePath),
        URL(fileURLWithPath: #filePath),
      ]
    )
    _ = module.declaration
  }

  func testLibraryAPI() {
    let library = LibraryAPI(name: "MyLibrary", modules: ["MyModule"])
    _ = library.possibleDeclaration
  }

  func testOperator() {
    _ =
      Operator(declaration: [
        SymbolGraph.Symbol.DeclarationFragments.Fragment(
          kind: .identifier,
          spelling: "==",
          preciseIdentifier: nil
        )
      ])
      < Operator(declaration: [
        SymbolGraph.Symbol.DeclarationFragments.Fragment(
          kind: .identifier,
          spelling: "≠",
          preciseIdentifier: nil
        )
      ])
  }

  func testPackageAPI() {
    let package = PackageAPI(
      name: "MyPackage",
      libraries: [LibraryAPI(name: "MyLibrary", modules: ["MyModule"])],
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
      moduleSources: [:]
    )
    _ = package.symbolGraphs()
    _ = package.declaration
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

        let declarations = [
          api.declaration
        ].appending(
          contentsOf: api.libraries.map({ $0.declaration })
        ).appending(
          contentsOf: api.modules.flatMap(
            { (module) -> [[SymbolGraph.Symbol.DeclarationFragments.Fragment]] in
              return [
                module.declaration
              ].appending(
                contentsOf: module.symbolGraphs.flatMap({ graph in
                  return graph.symbols.values.compactMap({ $0.possibleDeclaration })
                })
              ).appending(contentsOf: module.operators.compactMap({ $0.possibleDeclaration }))
                .appending(
                  contentsOf: module.precedenceGroups.compactMap({ $0.possibleDeclaration })
                )
            }
          )
        ).map({ declaration in
          return declaration.map({ fragment in
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
      #endif
    }
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
    _ = symbol.possibleDeclaration
  }
}
