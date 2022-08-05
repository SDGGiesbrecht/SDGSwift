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
    _ = module.names.subHeading
  }

  func testLibraryAPI() {
    let library = LibraryAPI(name: "MyLibrary", modules: ["MyModule"])
    _ = library.names.subHeading
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
        )
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
        )
      )
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
    _ = package.names.subHeading
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
        )
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
        )
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
        )
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
        )
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
        let declarationsSpecification = testSpecificationDirectory().appendingPathComponent(
          "API/SubHeadings/\(packageName).txt"
        )
        SDGPersistenceTestUtilities.compare(
          subHeadings,
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
    _ = symbol.name
  }
}
