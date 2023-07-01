/*
 RoundTripTestable.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwiftSource

import XCTest

protocol RoundTripTestable: SyntaxNode {
  init?(source: String) throws
}

extension RoundTripTestable {

  static func roundTripTest(_ source: String, file: StaticString = #filePath, line: UInt = #line) {
    guard let parsed = try? Self(source: source) else {
      XCTFail("“\(Self.self)” failed to parse “\(source)”", file: file, line: line)
      return
    }
    XCTAssertEqual(
      parsed.text(),
      source,
      "Syntax tree source differs from parsed source.",
      file: file,
      line: line
    )

    var syntaxScanner = RoundTripSyntaxScanner()
    syntaxScanner.scan(parsed)
    XCTAssertEqual(
      syntaxScanner.result,
      source,
      "Syntax scan produced source that differs from the original.",
      file: file,
      line: line
    )
  }
}
