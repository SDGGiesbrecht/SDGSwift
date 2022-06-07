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
import SDGLogic

import SDGSwiftSource

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax
#endif
#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
  import SwiftSyntaxParser
#endif
import SymbolKit

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  extension APIElementProtocol {

    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
      func assimilate(symbolGraph: SymbolGraph) throws {
        var sourceCache: [URL: SourceFileSyntax] = [:]
        try assimilate(
          symbols: symbolGraph.symbols.values,
          from: symbolGraph,
          sourceCache: &sourceCache
        )
      }
      func assimilate<Symbols>(
        symbols: Symbols,
        from symbolGraph: SymbolGraph,
        sourceCache: inout [URL: SourceFileSyntax]
      ) throws where Symbols: Collection, Symbols.Element == SymbolGraph.Symbol {
        for symbol in symbols {

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
              let api = TypeAPI(
                _documentation: declaration._documentation,
                declaration: declaration,
                children: []
              )
              try api.assimilate(
                symbols: children(of: symbol, in: symbolGraph),
                from: symbolGraph,
                sourceCache: &sourceCache
              )
              _children.append(
                .type(api)
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
            if let declaration = try declaration(
              of: symbol,
              as: FunctionDeclSyntax.self,
              cache: &sourceCache
            ) {
              _children.append(
                .function(
                  FunctionAPI(
                    _documentation: declaration._documentation,
                    declaration: declaration
                  )
                )
              )
            }
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
            if ¬(self is ModuleAPI) {  // Skip on global pass.
              if let declaration = try declaration(
                of: symbol,
                as: VariableDeclSyntax.self,
                cache: &sourceCache
              ) {
                _children.append(
                  .variable(
                    VariableAPI(
                      _documentation: declaration._documentation,
                      declaration: declaration
                    )
                  )
                )
              }
            }
          case .protocol:
            if let declaration = try declaration(
              of: symbol,
              as: ProtocolDeclSyntax.self,
              cache: &sourceCache
            ) {
              let api = ProtocolAPI(
                _documentation: declaration._documentation,
                declaration: declaration,
                children: []
              )
              try api.assimilate(
                symbols: children(of: symbol, in: symbolGraph),
                from: symbolGraph,
                sourceCache: &sourceCache
              )
              _children.append(
                .protocol(api)
              )
            }
          case .struct:
            if let declaration = try declaration(
              of: symbol,
              as: StructDeclSyntax.self,
              cache: &sourceCache
            ) {
              let api = TypeAPI(
                _documentation: declaration._documentation,
                declaration: declaration,
                children: []
              )
              try api.assimilate(
                symbols: children(of: symbol, in: symbolGraph),
                from: symbolGraph,
                sourceCache: &sourceCache
              )
              _children.append(
                .type(api)
              )
            }
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
            if let declaration = try declaration(
              of: symbol,
              as: VariableDeclSyntax.self,
              cache: &sourceCache
            ) {
              _children.append(
                .variable(
                  VariableAPI(
                    _documentation: declaration._documentation,
                    declaration: declaration
                  )
                )
              )
            }
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
    #endif

    func children(of symbol: SymbolGraph.Symbol, in graph: SymbolGraph) -> [SymbolGraph.Symbol] {
      return graph.relationships.filter({ relationship in
        switch relationship.kind {
        case .memberOf:
          return relationship.target == symbol.identifier.precise
        default:
          return false
        }
      }).compactMap({ relationship in
        return graph.symbols[relationship.source]
      })
    }

    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
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
        let url = URL(fileURLWithPath: String(location.uri.dropFirst(7 /* file:// */)))
        let source = try cached(in: &cache[url]) {
          return try SyntaxParser.parseAndRetry(url)
        }
        let symbolTargetLocation = location.position
        let converter = SourceLocationConverter(file: url.path, tree: source)
        let ordinalLine = symbolTargetLocation.line + 1
        let ordinalColumn = symbolTargetLocation.character + 1
        let syntaxTargetLocation = SourceLocation(
          line: ordinalLine,
          column: ordinalColumn,
          offset: converter.position(
            ofLine: ordinalLine,
            column: ordinalColumn
          ).utf8Offset,
          file: url.path
        )
        return Syntax(source).smallest(expectedNode, at: syntaxTargetLocation, converter: converter)
      }
    #endif
  }
#endif
