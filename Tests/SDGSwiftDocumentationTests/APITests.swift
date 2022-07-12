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

  func testSymbolGraph() throws {
    for packageURL in documentationTestPackages {
      let package = PackageRepository(at: packageURL)
      let packageName = package.location.lastPathComponent
      #if PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
        #if !PLATFORM_LACKS_FOUNDATION_PROCESS
          _ = try? package.symbolGraphs().get()
        #endif
      #else
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
              "class UnknownSuperclass",
              "func allSatisfy((Self.Element) throws \u{2D}> Bool) rethrows \u{2D}> Bool",
              "func compactMap<ElementOfResult>((Self.Element) throws \u{2D}> ElementOfResult?) rethrows \u{2D}> [ElementOfResult]",
              "func contains(Self.Element) \u{2D}> Bool",
              "func contains(where: (Self.Element) throws \u{2D}> Bool) rethrows \u{2D}> Bool",
              "func distance(from: Self.Index, to: Self.Index) \u{2D}> Int",
              "func drop(while: (Self.Element) throws \u{2D}> Bool) rethrows \u{2D}> Self.SubSequence",
              "func dropFirst(Int) \u{2D}> Self.SubSequence",
              "func dropLast(Int) \u{2D}> Self.SubSequence",
              "func elementsEqual<OtherSequence>(OtherSequence) \u{2D}> Bool",
              "func elementsEqual<OtherSequence>(OtherSequence, by: (Self.Element, OtherSequence.Element) throws \u{2D}> Bool) rethrows \u{2D}> Bool",
              "func encode(to: Encoder) throws",
              "func encode(to: Encoder) throws",
              "func enumerated() \u{2D}> EnumeratedSequence<Self>",
              "func filter((Self.Element) throws \u{2D}> Bool) rethrows \u{2D}> [Self.Element]",
              "func first(where: (Self.Element) throws \u{2D}> Bool) rethrows \u{2D}> Self.Element?",
              "func firstIndex(of: Self.Element) \u{2D}> Self.Index?",
              "func firstIndex(where: (Self.Element) throws \u{2D}> Bool) rethrows \u{2D}> Self.Index?",
              "func flatMap<ElementOfResult>((Self.Element) throws \u{2D}> ElementOfResult?) rethrows \u{2D}> [ElementOfResult]",
              "func flatMap<SegmentOfResult>((Self.Element) throws \u{2D}> SegmentOfResult) rethrows \u{2D}> [SegmentOfResult.Element]",
              "func forEach((Self.Element) throws \u{2D}> Void) rethrows",
              "func formIndex(after: inout Self.Index)",
              "func formIndex(inout Self.Index, offsetBy: Int)",
              "func formIndex(inout Self.Index, offsetBy: Int, limitedBy: Self.Index) \u{2D}> Bool",
              "func hidden()",
              "func index(Self.Index, offsetBy: Int) \u{2D}> Self.Index",
              "func index(Self.Index, offsetBy: Int, limitedBy: Self.Index) \u{2D}> Self.Index?",
              "func index(after: Int) \u{2D}> Int",
              "func index(of: Self.Element) \u{2D}> Self.Index?",
              "func inherited()",
              "func lexicographicallyPrecedes<OtherSequence>(OtherSequence) \u{2D}> Bool",
              "func lexicographicallyPrecedes<OtherSequence>(OtherSequence, by: (Self.Element, Self.Element) throws \u{2D}> Bool) rethrows \u{2D}> Bool",
              "func makeIterator() \u{2D}> IndexingIterator<Self>",
              "func map<T>((Self.Element) throws \u{2D}> T) rethrows \u{2D}> [T]",
              "func map<T>((Self.Element) throws \u{2D}> T) rethrows \u{2D}> [T]",
              "func max() \u{2D}> Self.Element?",
              "func max(by: (Self.Element, Self.Element) throws \u{2D}> Bool) rethrows \u{2D}> Self.Element?",
              "func methodOverride()",
              "func methodOverride()",
              "func min() \u{2D}> Self.Element?",
              "func min(by: (Self.Element, Self.Element) throws \u{2D}> Bool) rethrows \u{2D}> Self.Element?",
              "func prefix(Int) \u{2D}> Self.SubSequence",
              "func prefix(through: Self.Index) \u{2D}> Self.SubSequence",
              "func prefix(upTo: Self.Index) \u{2D}> Self.SubSequence",
              "func prefix(while: (Self.Element) throws \u{2D}> Bool) rethrows \u{2D}> Self.SubSequence",
              "func provision()",
              "func randomElement() \u{2D}> Self.Element?",
              "func randomElement<T>(using: inout T) \u{2D}> Self.Element?",
              "func reduce<Result>(Result, (Result, Self.Element) throws \u{2D}> Result) rethrows \u{2D}> Result",
              "func reduce<Result>(into: Result, (inout Result, Self.Element) throws \u{2D}> ()) rethrows \u{2D}> Result",
              "func requirement()",
              "func reversed() \u{2D}> [Self.Element]",
              "func shuffled() \u{2D}> [Self.Element]",
              "func shuffled<T>(using: inout T) \u{2D}> [Self.Element]",
              "func sorted() \u{2D}> [Self.Element]",
              "func sorted(by: (Self.Element, Self.Element) throws \u{2D}> Bool) rethrows \u{2D}> [Self.Element]",
              "func split(maxSplits: Int, omittingEmptySubsequences: Bool, whereSeparator: (Self.Element) throws \u{2D}> Bool) rethrows \u{2D}> [Self.SubSequence]",
              "func split(separator: Self.Element, maxSplits: Int, omittingEmptySubsequences: Bool) \u{2D}> [Self.SubSequence]",
              "func starts<PossiblePrefix>(with: PossiblePrefix) \u{2D}> Bool",
              "func starts<PossiblePrefix>(with: PossiblePrefix, by: (Self.Element, PossiblePrefix.Element) throws \u{2D}> Bool) rethrows \u{2D}> Bool",
              "func suffix(Int) \u{2D}> Self.SubSequence",
              "func suffix(from: Self.Index) \u{2D}> Self.SubSequence",
              "func withContiguousStorageIfAvailable<R>((UnsafeBufferPointer<Self.Element>) throws \u{2D}> R) rethrows \u{2D}> R?",
              "init(extendedGraphemeClusterLiteral: Self.StringLiteralType)",
              "init(from: Decoder) throws",
              "init(stringInterpolation: DefaultStringInterpolation)",
              "init(stringLiteral: String)",
              "init(unicodeScalarLiteral: Self.ExtendedGraphemeClusterLiteralType)",
              "init?(rawValue: Int)",
              "let property: Bool",
              "static func \u{21}= (Self, Self) \u{2D}> Bool",
              "static func ... (Self) \u{2D}> PartialRangeFrom<Self>",
              "static func ... (Self) \u{2D}> PartialRangeThrough<Self>",
              "static func ... (Self, Self) \u{2D}> ClosedRange<Self>",
              "static func ..< (Self) \u{2D}> PartialRangeUpTo<Self>",
              "static func ..< (Self, Self) \u{2D}> Range<Self>",
              "static func < (Inherited, Inherited) \u{2D}> Bool",
              "static func \u{3C}= (Self, Self) \u{2D}> Bool",
              "static func == (Inherited, Inherited) \u{2D}> Bool",
              "static func > (Self, Self) \u{2D}> Bool",
              "static func \u{3E}= (Self, Self) \u{2D}> Bool",
              "static let staticProperty: Bool",
              "subscript((UnboundedRange_) \u{2D}> ()) \u{2D}> Self.SubSequence",
              "subscript(Int) \u{2D}> Bool",
              "subscript(Int) \u{2D}> Int",
              "subscript(Range<Self.Index>) \u{2D}> Slice<Self>",
              "subscript<R>(R) \u{2D}> Self.SubSequence",
              "typealias Index",
              "typealias Indices",
              "typealias RawValue",
              "var count: Int",
              "var endIndex: Int",
              "var extensionProperty: Bool",
              "var first: Self.Element?",
              "var globalVariable: Bool",
              "var indices: DefaultIndices<Self>",
              "var isEmpty: Bool",
              "var lazy: LazySequence<Self>",
              "var propertyInASeparateExtension: Bool",
              "var rawValue: Int",
              "var startIndex: Int",
              "var underestimatedCount: Int",
              "var underestimatedCount: Int",
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
