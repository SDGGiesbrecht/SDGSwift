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
              "   visible • case visible",
              // The legacy implementation does not know about implicit synthesis.
              "   Equatable",
              "   Hashable",
            ],
            with: [
              "   visible • case visible"
            ]
          )
          summary.replaceMatches(
            for: [
              "  Superclass • class Superclass"
            ],
            with: [
              "   Superclass",
              "  Superclass • class Superclass",
            ]
          )
          summary.replaceMatches(
            for: [
              "   ExpressibleByUnicodeScalarLiteral"
            ],
            with: [
              "   ExpressibleByUnicodeScalarLiteral",
              "  (Bool)",
              "   extensionProperty • var extensionProperty: Bool { get }",
              "   propertyInASeparateExtension • var propertyInASeparateExtension: Bool { get }",
            ]
          )
          summary.replaceMatches(
            for: [
              "  executeFunction() • func executeFunction()"
            ],
            with: [
              "  executeFunction() • func executeFunction()",
              "  ≠ • infix operator ≠ : Precedence",
              "  Precedence • precedencegroup Precedence {}",
            ]
          )
          summary.removeAll(where: { line in
            return [
              // The legacy implementation does not know about implicit synthesis.
              "   Sendable",
              // The legacy implementation filtered out conformance members.
              "   encode(to:) • func encode(to encoder: Encoder) throws",
              "   endIndex • var endIndex: Int { get }",
              "   index(after:) • func index(after i: Int) \u{2D}> Int",
              "   inherited() • func inherited()",
              "   init(from:) • required init(from decoder: Decoder) throws",
              "   init(rawValue:) • init?(rawValue: Int)",
              "   init(stringInterpolation:) • init(stringInterpolation: DefaultStringInterpolation)",
              "   init(stringLiteral:) • init(stringLiteral: String)",
              "   methodOverride() • func methodOverride()",
              "   provision() • func provision()",
              "   rawValue • var rawValue: Int { get set }",
              "   requirement() • func requirement()",
              "   startIndex • var startIndex: Int { get }",
              "   [_:] • subscript(position: Int) -> Int { get }",
            ].contains(line)
          })
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
