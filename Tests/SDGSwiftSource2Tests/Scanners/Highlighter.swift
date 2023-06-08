/*
 Highlighter.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic

import SDGSwiftSource2

import XCTest

import SDGPersistenceTestUtilities

import SDGSwiftTestUtilities

protocol Highlighter: SyntaxScanner {
  func shouldHighlight(_ token: Token, context: ScanContext) -> Bool
  var highlighted: String { get set }
}

extension Highlighter {

  mutating func assertHighlightsNothing(
    in source: SwiftSyntaxNode,
    _ message: String,
    file: StaticString = #filePath,
    line: UInt = #line
  ) throws {
    let result = try highlight(source)
    XCTAssert(¬result.scalars.contains("\u{332}"), "\(message):\n\(result)", file: file, line: line)
  }

  @discardableResult mutating func compare(
    syntax: SwiftSyntaxNode,
    parsedFrom url: URL,
    againstSpecification name: String,
    overwriteSpecificationInsteadOfFailing: Bool,
    file: StaticString = #filePath,
    line: UInt = #line
  ) throws -> String {
    var result = try highlight(syntax)
    let specification =
      afterDirectory
      .appendingPathComponent(name)
      .appendingPathComponent(url.deletingPathExtension().lastPathComponent)
      .appendingPathExtension("txt")

    #if os(Windows)
      result.unicodeScalars.replaceMatches(for: "\r\u{332}".scalars, with: "".scalars)
      result.unicodeScalars.replaceMatches(for: "\r".scalars, with: "".scalars)
    #endif

    // #workaround(For compatibility of specifications with legacy tests.)
    result.replaceMatches(for: "__s̲", with: "**s̲")
    result.replaceMatches(for: "__s", with: "**s")
    result.replaceMatches(for: "_̲_̲s", with: "*̲*̲s")
    result.replaceMatches(for: "g̲__", with: "g̲**")
    result.replaceMatches(for: "g__", with: "g**")
    result.replaceMatches(for: "g_̲_̲", with: "g*̲*̲")
    result.replaceMatches(for: "_e̲", with: "*e̲")
    result.replaceMatches(for: "_e", with: "*e")
    result.replaceMatches(for: "_̲e", with: "*̲e")
    result.replaceMatches(for: "d̲_", with: "d̲*")
    result.replaceMatches(for: "d_", with: "d*")
    result.replaceMatches(for: "d_̲", with: "d*̲")

    SDGPersistenceTestUtilities.compare(
      result,
      against: specification,
      overwriteSpecificationInsteadOfFailing: overwriteSpecificationInsteadOfFailing,
      file: file,
      line: line
    )
    return result
  }

  private mutating func highlight(_ source: SwiftSyntaxNode) throws -> String {
    highlighted = ""
    scan(source)
    return highlighted
  }

  private func highlight(_ source: String) -> String {
    return source.clusters.map({ "\($0)" + "\u{332}" }).joined()
  }

  // MARK: - SyntaxScanner

  mutating func visit(_ node: SyntaxNode, context: ScanContext) -> Bool {
    if let token = node as? Token {
      highlighted +=
        shouldHighlight(token, context: context) ? highlight(token.text()) : token.text()
    }
    return true
  }
}
