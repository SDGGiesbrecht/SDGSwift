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
        let symbolGraphs = try package.symbolGraphs().get()

        let declarations = symbolGraphs.flatMap({ graph in
          return graph.symbols.values.compactMap { symbol in
            return symbol.declaration?.map({ fragment in
              return fragment.spelling
            }).joined()
          }
        })
        .filter({ declaration in
          // #workaround(Removing stuff that does not match.)
          if packageName == "PackageToDocument" {
            return ¬[
              "let property: Bool",
              "static let staticProperty: Bool",
              "subscript(Int) \u{2D}> Bool",
              "var extensionProperty: Bool",
              "var globalVariable: Bool",
              "var propertyInASeparateExtension: Bool",
            ].contains(declaration)
          } else {
            return ¬[
              "case visible",
              "class AnotherSublass",
              "class Subclass",
              "class Superclass",
              "var extensionProperty: Bool",
            ].contains(declaration)
          }
        })
        .appending(
          contentsOf: {
            // #workaround(Filling in symbols not detected yet.)
            if packageName == "PackageToDocument" {
              return [
                ".library(name: \u{22}PrimaryProduct\u{22})",
                ".target(name: \u{22}PrimaryModule\u{22})",
                ".target(name: \u{22}PrimaryModule\u{22})",
                "Package(name: \u{22}PackageToDocument\u{22})",
                "case visible",
                "class AnotherSublass",
                "class Subclass",
                "class Superclass",
                "enum Enumeration",
                "func executeFunction()",
                "func method()",
                "func required()",
                "infix operator ≠ : Precedence",
                "infix operator ≠ : Precedence",
                "init()",
                "precedencegroup Precedence {}",
                "precedencegroup Precedence {}",
                "protocol Protocol",
                "static func staticMethod()",
                "static var staticProperty: Bool { get }",
                "struct CollectionType",
                "struct Inherited",
                "struct InheritingAssociatedType",
                "struct Structure",
                "struct TypeExpressibleByStringInterpolation",
                "subscript(`subscript`: Int) \u{2D}> Bool { get }",
                "subscript(`subscript`: Int) \u{2D}> Bool { get }",
                "var extensionProperty: Bool { get }",
                "var extensionProperty: Bool { get }",
                "var globalVariable: Bool { get set }",
                "var globalVariable: Bool { get set }",
                "var property: Bool { get }",
                "var property: Bool { get }",
                "var propertyInASeparateExtension: Bool { get }",
                "var propertyInASeparateExtension: Bool { get }",
                "static var staticProperty: Bool { get }",
              ]
            } else {
              return [
                "Package(name: \u{22}PackageToDocument2\u{22})",
                ".library(name: \u{22}PrimaryProduct\u{22})",
                ".target(name: \u{22}PrimaryModule\u{22})",
                ".target(name: \u{22}PrimaryModule\u{22})",
                "var extensionProperty: Bool { get }",
                "var extensionProperty: Bool { get }",
              ]
            }
          }()
        )
        .sorted().joined(separator: "\n")
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
    _ = symbol.declaration
  }
}
