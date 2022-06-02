/*
 ModuleAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow

import SDGSwiftSource

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax
#endif
#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
  import SwiftSyntaxParser
#endif
import SymbolKit

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  extension ModuleAPI {

    func assimilate(symbolGraph: SymbolGraph) throws {
      var sourceCache: [URL: SourceFileSyntax] = [:]
      for (_, symbol) in symbolGraph.symbols {

        // #workaround(Not implemented yet.)
        let children: [APIElement] = []

        switch symbol.kind.identifier {
        case .associatedtype:
          // #workaround(Not implemented yet.)
          print("associatedtype: \(symbol.names.prose ?? symbol.names.title)")
        case .class:
          if let declaration = try declaration(
            of: symbol,
            as: ClassDeclSyntax.self,
            cache: &sourceCache
          ) {
            _children.append(
              .type(
                TypeAPI(_documentation: declaration._documentation, declaration: declaration, children: children)
              )
            )
          }
        case .deinit:
          // #workaround(Not implemented yet.)
          print("deinit: \(symbol.names.prose ?? symbol.names.title)")
        case .enum:
          // #workaround(Not implemented yet.)
          print("enum: \(symbol.names.prose ?? symbol.names.title)")
        case .case:
          // #workaround(Not implemented yet.)
          print("case: \(symbol.names.prose ?? symbol.names.title)")
        case .func:
          // #workaround(Not implemented yet.)
          print("func: \(symbol.names.prose ?? symbol.names.title)")
        case .operator:
          // #workaround(Not implemented yet.)
          print("operator: \(symbol.names.prose ?? symbol.names.title)")
        case .`init`:
          // #workaround(Not implemented yet.)
          print("init: \(symbol.names.prose ?? symbol.names.title)")
        case .method:
          // #workaround(Not implemented yet.)
          print("method: \(symbol.names.prose ?? symbol.names.title)")
        case .property:
          // #workaround(Not implemented yet.)
          print("property: \(symbol.names.prose ?? symbol.names.title)")
        case .protocol:
          // #workaround(Not implemented yet.)
          print("protocol: \(symbol.names.prose ?? symbol.names.title)")
        case .struct:
          // #workaround(Not implemented yet.)
          print("struct: \(symbol.names.prose ?? symbol.names.title)")
        case .subscript:
          // #workaround(Not implemented yet.)
          print("subscript: \(symbol.names.prose ?? symbol.names.title)")
        case .typeMethod:
          // #workaround(Not implemented yet.)
          print("typeMethod: \(symbol.names.prose ?? symbol.names.title)")
        case .typeProperty:
          // #workaround(Not implemented yet.)
          print("typeProperty: \(symbol.names.prose ?? symbol.names.title)")
        case .typeSubscript:
          // #workaround(Not implemented yet.)
          print("typeSubscript: \(symbol.names.prose ?? symbol.names.title)")
        case .typealias:
          // #workaround(Not implemented yet.)
          print("typealias: \(symbol.names.prose ?? symbol.names.title)")
        case .var:
          // #workaround(Not implemented yet.)
          print("var: \(symbol.names.prose ?? symbol.names.title)")
        case .module:
          // #workaround(Not implemented yet.)
          print("module: \(symbol.names.prose ?? symbol.names.title)")
        case .unknown:
          // #workaround(Not implemented yet.)
          print("unknown: \(symbol.names.prose ?? symbol.names.title)")
        }
        _children.sort()
      }
    }

    func declaration<SyntaxNode>(
      of symbol: SymbolGraph.Symbol,
      as expectedNode: SyntaxNode.Type,
      cache: inout [URL: SourceFileSyntax]
    ) throws -> SyntaxNode? where SyntaxNode: SyntaxProtocol {
      guard let locationMixin = symbol.mixins[SymbolGraph.Symbol.Location.mixinKey],
        let location = locationMixin as? SymbolGraph.Symbol.Location
      else {
        return nil
      }
      let url = URL(fileURLWithPath: String(location.uri.dropFirst(7/* file:// */)))
      let source = try cached(in: &cache[url]) {
        return try SyntaxParser.parseAndRetry(url)
      }
      let symbolTargetLocation = location.position
      let converter = SourceLocationConverter(file: url.path, tree: source)
      let syntaxTargetLocation = SourceLocation(
        line: symbolTargetLocation.line,
        column: symbolTargetLocation.character,
        offset: converter.position(
          ofLine: symbolTargetLocation.line,
          column: symbolTargetLocation.character
        ).utf8Offset,
        file: url.path
      )
      return Syntax(source).smallest(expectedNode, at: syntaxTargetLocation, converter: converter)
    }
  }
#endif
