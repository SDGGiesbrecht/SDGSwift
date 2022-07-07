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
          return ¬[
            "class UnknownSuperclass",
            "func allSatisfy((Self.Element) throws -> Bool) rethrows -> Bool",
            "func compactMap<ElementOfResult>((Self.Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult]",
            "func contains(Self.Element) -> Bool",
            "func contains(where: (Self.Element) throws -> Bool) rethrows -> Bool",
            "func distance(from: Self.Index, to: Self.Index) -> Int",
            "func drop(while: (Self.Element) throws -> Bool) rethrows -> Self.SubSequence",
            "func dropFirst(Int) -> Self.SubSequence",
            "func dropLast(Int) -> Self.SubSequence",
            "func elementsEqual<OtherSequence>(OtherSequence) -> Bool",
            "func elementsEqual<OtherSequence>(OtherSequence, by: (Self.Element, OtherSequence.Element) throws -> Bool) rethrows -> Bool",
            "func encode(to: Encoder) throws",
            "func encode(to: Encoder) throws",
            "func enumerated() -> EnumeratedSequence<Self>",
            "func filter((Self.Element) throws -> Bool) rethrows -> [Self.Element]",
            "func first(where: (Self.Element) throws -> Bool) rethrows -> Self.Element?",
            "func firstIndex(of: Self.Element) -> Self.Index?",
            "func firstIndex(where: (Self.Element) throws -> Bool) rethrows -> Self.Index?",
            "func flatMap<ElementOfResult>((Self.Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult]",
            "func flatMap<SegmentOfResult>((Self.Element) throws -> SegmentOfResult) rethrows -> [SegmentOfResult.Element]",
            "func forEach((Self.Element) throws -> Void) rethrows",
            "func formIndex(after: inout Self.Index)",
            "func formIndex(inout Self.Index, offsetBy: Int)",
            "func formIndex(inout Self.Index, offsetBy: Int, limitedBy: Self.Index) -> Bool",
            "func hidden()",
            "func index(Self.Index, offsetBy: Int) -> Self.Index",
            "func index(Self.Index, offsetBy: Int, limitedBy: Self.Index) -> Self.Index?",
            "func index(after: Int) -> Int",
            "func index(of: Self.Element) -> Self.Index?",
            "func inherited()",
            "func lexicographicallyPrecedes<OtherSequence>(OtherSequence) -> Bool",
            "func lexicographicallyPrecedes<OtherSequence>(OtherSequence, by: (Self.Element, Self.Element) throws -> Bool) rethrows -> Bool",
            "func makeIterator() -> IndexingIterator<Self>",
            "func map<T>((Self.Element) throws -> T) rethrows -> [T]",
            "func map<T>((Self.Element) throws -> T) rethrows -> [T]",
            "func max() -> Self.Element?",
            "func max(by: (Self.Element, Self.Element) throws -> Bool) rethrows -> Self.Element?",
            "func methodOverride()",
            "func methodOverride()",
            "func min() -> Self.Element?",
            "func min(by: (Self.Element, Self.Element) throws -> Bool) rethrows -> Self.Element?",
            "func prefix(Int) -> Self.SubSequence",
            "func prefix(through: Self.Index) -> Self.SubSequence",
            "func prefix(upTo: Self.Index) -> Self.SubSequence",
            "func prefix(while: (Self.Element) throws -> Bool) rethrows -> Self.SubSequence",
            "func provision()",
            "func randomElement() -> Self.Element?",
            "func randomElement<T>(using: inout T) -> Self.Element?",
            "func reduce<Result>(Result, (Result, Self.Element) throws -> Result) rethrows -> Result",
            "func reduce<Result>(into: Result, (inout Result, Self.Element) throws -> ()) rethrows -> Result",
            "func requirement()",
            "func reversed() -> [Self.Element]",
            "func shuffled() -> [Self.Element]",
            "func shuffled<T>(using: inout T) -> [Self.Element]",
            "func sorted() -> [Self.Element]",
            "func sorted(by: (Self.Element, Self.Element) throws -> Bool) rethrows -> [Self.Element]",
            "func split(maxSplits: Int, omittingEmptySubsequences: Bool, whereSeparator: (Self.Element) throws -> Bool) rethrows -> [Self.SubSequence]",
            "func split(separator: Self.Element, maxSplits: Int, omittingEmptySubsequences: Bool) -> [Self.SubSequence]",
            "func starts<PossiblePrefix>(with: PossiblePrefix) -> Bool",
            "func starts<PossiblePrefix>(with: PossiblePrefix, by: (Self.Element, PossiblePrefix.Element) throws -> Bool) rethrows -> Bool",
            "func suffix(Int) -> Self.SubSequence",
            "func suffix(from: Self.Index) -> Self.SubSequence",
            "func withContiguousStorageIfAvailable<R>((UnsafeBufferPointer<Self.Element>) throws -> R) rethrows -> R?",
            "init(extendedGraphemeClusterLiteral: Self.StringLiteralType)",
            "init(from: Decoder) throws",
            "init(stringInterpolation: DefaultStringInterpolation)",
            "init(stringLiteral: String)",
            "init(unicodeScalarLiteral: Self.ExtendedGraphemeClusterLiteralType)",
            "init?(rawValue: Int)",
            "let property: Bool",
            "static func != (Self, Self) -> Bool",
            "static func ... (Self) -> PartialRangeFrom<Self>",
            "static func ... (Self) -> PartialRangeThrough<Self>",
            "static func ... (Self, Self) -> ClosedRange<Self>",
            "static func ..< (Self) -> PartialRangeUpTo<Self>",
            "static func ..< (Self, Self) -> Range<Self>",
            "static func < (Inherited, Inherited) -> Bool",
            "static func <= (Self, Self) -> Bool",
            "static func == (Inherited, Inherited) -> Bool",
            "static func > (Self, Self) -> Bool",
            "static func >= (Self, Self) -> Bool",
            "static let staticProperty: Bool",
            "subscript(Int) -> Bool",
            "subscript(Int) -> Int",
            "subscript(Range<Self.Index>) -> Slice<Self>",
            "subscript<R>(R) -> Self.SubSequence",
            "typealias Index",
            "typealias Indices",
            "typealias RawValue",
            "var count: Int",
            "var endIndex: Int",
            "var extensionProperty: Bool",
            "var first: Self.Element?",
            "var globalVariable: Bool",
            "var indices: DefaultIndices<Self>",
          ].contains(declaration)
        })
        .appending(contentsOf: [
          // #workaround(Filling in symbols not detected yet.)
          ".library(name: \u{22}PrimaryProduct\u{22})",
          ".target(name: \u{22}PrimaryModule\u{22})",
          ".target(name: \u{22}PrimaryModule\u{22})",
          "Package(name: \u{22}PackageToDocument\u{22})",
          "case visible",
          "class AnotherSublass",
          "class Subclass",
          "class Superclass",
        ])
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
}
