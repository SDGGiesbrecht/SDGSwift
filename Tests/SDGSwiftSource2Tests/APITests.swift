/*
 APITests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGLogic
import SDGPersistence

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax
#endif
#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
  import SwiftSyntaxParser
#endif

import SDGSwiftSource2

import XCTest

import SDGSwiftTestUtilities

class APITests: SDGSwiftTestUtilities.TestCase {

  func testParsing() throws {
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
      for url in try FileManager.default.deepFileEnumeration(in: beforeDirectory)
      where url.lastPathComponent ≠ ".DS_Store" {
        let sourceFile = try SyntaxParser.parse(url)

        let originalSource = try String(from: url)
        var roundTripSource = ""
        sourceFile.write(to: &roundTripSource)
        XCTAssertEqual(roundTripSource, originalSource)

        struct RoundTripSyntaxScanner: SyntaxScanner {
          var result = ""
          mutating func visit(
            _ node: SwiftSyntax.Syntax,
            context: SDGSwiftSource2.SyntaxContext
          ) -> Bool {
            if let token = node.as(TokenSyntax.self) {
              token.write(to: &result)
            }
            return true
          }
        }
        var syntaxScanner = RoundTripSyntaxScanner()
        syntaxScanner.scan(sourceFile)
        XCTAssertEqual(syntaxScanner.result, originalSource)
      }
    #endif
  }
}
