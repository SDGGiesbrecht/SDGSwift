/*
 RegressionTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

  import SwiftSyntax
#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
  import SwiftSyntaxParser
#endif

import SDGSwiftSource

import XCTest

import SDGPersistenceTestUtilities
import SDGXCTestUtilities

import SDGSwiftTestUtilities

class RegressionTests: SDGSwiftTestUtilities.TestCase {

  func testContinuedCallout() throws {
    // Untracked.

    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
      let source = [
        "/// ...",
        "///",
        "/// \u{2D} Note: ...",
        "/// ...",
        "public func function() {}",
      ].joined(separator: "\n")
      let _ = try SyntaxParser.parse(source: source)
    #endif
  }

  func testDocumentationParsingHandlesDoubleLineBrakeAtEnd() {
    // Untracked.

    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
      _ = DocumentationSyntax.parse(source: "...\n\n")
    #endif
  }

  func testMarkdownEntity() throws {
    // Untracked.

    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
      let source = [
        "/// ...&#x2D;...",
        "public func function() {}",
      ].joined(separator: "\n")
      let parsed = try SyntaxParser.parse(source: source)
      XCTAssertEqual(parsed.source(), source)
    #endif
  }

  func testMarkdownQuotation() throws {
    // Untracked.

    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
      let source = [
        "/// ...",
        "///",
        "/// > Line 1",
        "/// >",
        "/// > Line 2",
        "/// >",
        "/// > Line 3",
        "public func function() {}",
      ].joined(separator: "\n")
      XCTAssertEqual(try SyntaxParser.parse(source: source).source(), source)
    #endif
  }
}
