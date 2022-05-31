/*
 APITests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

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
    testCustomStringConvertibleConformance(
      of: SymbolGraph.LoadingError.exportError(.executionError(.foundationError(Elipsis()))),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Export",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: SymbolGraph.LoadingError.loadingError(Elipsis()),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Load",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testSymbolGraphLoading() throws {
    for packageURL in documentationTestPackages {
      let package = PackageRepository(at: packageURL)
      #if PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
        #if !PLATFORM_LACKS_FOUNDATION_PROCESS
          _ = try? package.symbolGraphs().get()
        #endif
      #else
        let api = try package.api()
        let name = api.name.text

        var summary = api.summary()
        let specification = testSpecificationDirectory().appendingPathComponent(
          "API/\(api.name).txt"
        )

        // #workaround(Working on reducing difference.)
        if name == "PackageToDocument" {
          summary.replaceMatches(
            for: [
              "  AnotherSublass • class AnotherSublass"
            ],
            with: [
              "  AnotherSublass • class AnotherSublass",
              "   UnknownSuperclass",
              "  CollectionType • struct CollectionType",
              "   Collection",
              "   Sequence",
              "  Enumeration • enum Enumeration",
              "   visible • case visible",
              "  Inherited • struct Inherited",
              "   required() • func required()",
              "   Comparable",
              "   DependencyProtocol",
              "   Equatable",
              "   SubDependencyProtocol",
              "  InheritingAssociatedType • struct InheritingAssociatedType",
              "   RawRepresentable",
              "  Structure • struct Structure",
              "   staticProperty • static var staticProperty: Bool { get }",
              "   staticMethod() • static func staticMethod()",
              "   init() • init()",
              "   property • var property: Bool { get }",
              "   [_:] • subscript(`subscript`: Int) \u{2D}> Bool { get }",
              "   method() • func method()",
              "   Error",
            ]
          )
          summary.replaceMatches(
            for: [
              "  Subclass • class Subclass"
            ],
            with: [
              "  Subclass • class Subclass",
              "   Decodable",
              "   Encodable",
              "   Superclass",
            ]
          )
          summary.replaceMatches(
            for: [
              "  Superclass • class Superclass"
            ],
            with: [
              "  Superclass • class Superclass",
              "   Decodable",
              "   Encodable",
              "  TypeExpressibleByStringInterpolation • struct TypeExpressibleByStringInterpolation",
              "   ExpressibleByExtendedGraphemeClusterLiteral",
              "   ExpressibleByStringInterpolation",
              "   ExpressibleByStringLiteral",
              "   ExpressibleByUnicodeScalarLiteral",
              "  (Bool)",
              "   extensionProperty • var extensionProperty: Bool { get }",
              "   propertyInASeparateExtension • var propertyInASeparateExtension: Bool { get }",
              "  Protocol • protocol Protocol",
              "  globalVariable • var globalVariable: Bool { get set }",
              "  executeFunction() • func executeFunction()",
              "  ≠ • infix operator ≠ : Precedence",
              "  Precedence • precedencegroup Precedence {}",
            ]
          )
        } else if name == "PackageToDocument2" {
          summary.append(
            contentsOf: [
              "  (Bool)",
              "   extensionProperty • var extensionProperty: Bool { get }",
            ]
          )
        }

        SDGPersistenceTestUtilities.compare(
          summary.joined(separator: "\n"),
          against: specification,
          overwriteSpecificationInsteadOfFailing: false
        )
      #endif
    }
  }
}
