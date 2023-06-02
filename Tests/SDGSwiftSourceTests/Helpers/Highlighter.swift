/*
 Highlighter.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
  import Foundation

  import SDGLogic

  import SwiftSyntax

  import SDGSwiftSource

  import SDGPersistenceTestUtilities

  import SDGSwiftTestUtilities

  class Highlighter: SyntaxScanner {

    func shouldHighlight(_ token: TokenSyntax) -> Bool {
      return false
    }

    func shouldHighlight(_ trivia: ExtendedTokenSyntax) -> Bool {
      return false
    }

    @discardableResult func compare(
      syntax: SourceFileSyntax,
      parsedFrom url: URL,
      againstSpecification name: String,
      overwriteSpecificationInsteadOfFailing: Bool,
      file: StaticString = #filePath,
      line: UInt = #line
    ) throws -> String {
      var result = try highlight(syntax)

      let specification = afterDirectory.appendingPathComponent(name).appendingPathComponent(
        url.deletingPathExtension().lastPathComponent
      ).appendingPathExtension("txt")

      #if os(Windows)
        result.unicodeScalars.replaceMatches(for: "\r\n".scalars, with: "\n".scalars)
      #endif

      SDGPersistenceTestUtilities.compare(
        result,
        against: specification,
        overwriteSpecificationInsteadOfFailing: overwriteSpecificationInsteadOfFailing,
        file: file,
        line: line
      )
      return result
    }

    private var highlighted = ""
    private func highlight(_ source: SourceFileSyntax) throws -> String {
      highlighted = ""
      _ = try scan(source)
      return highlighted
    }

    func visit(_ node: Syntax, context: SyntaxContext) -> Bool {
      if let token = node.as(TokenSyntax.self) {
        highlighted += shouldHighlight(token) ? highlight(token.text) : token.text
      }
      return true
    }

    func visit(_ node: ExtendedSyntax, context: ExtendedSyntaxContext) -> Bool {
      if let token = node as? ExtendedTokenSyntax {
        highlighted += shouldHighlight(token) ? highlight(token.text) : token.text
      }
      return true
    }

    private func highlight(_ source: String) -> String {
      return source.clusters.map({ "\($0)" + "\u{332}" }).joined()
    }
  }
#endif
