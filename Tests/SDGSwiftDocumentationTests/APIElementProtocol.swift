/*
 APIElementProtocol.swift

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
        defer { _children.sort() }
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
              api.assimilate(conformances: conformances(of: symbol, in: symbolGraph))
              _children.append(.type(api))
            }
          case .deinit:
            // #workaround(Not implemented yet.)
            print("deinit: \(symbol.names.prose ?? symbol.names.title)")
          case .enum:
            if let declaration = try declaration(
              of: symbol,
              as: EnumDeclSyntax.self,
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
              api.assimilate(conformances: conformances(of: symbol, in: symbolGraph))
              _children.append(.type(api))
            }
          case .case:
            if ¬(self is ModuleAPI) {  // Skip on global pass.
              if let declaration = try declaration(
                of: symbol,
                as: EnumCaseDeclSyntax.self,
                cache: &sourceCache
              ) {
                _children.append(
                  .case(
                    CaseAPI(
                      _documentation: declaration._documentation,
                      declaration: declaration
                    )
                  )
                )
              }
            }
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
            if ¬(self is ModuleAPI) {  // Skip on global pass.
              if let declaration = try declaration(
                of: symbol,
                as: InitializerDeclSyntax.self,
                cache: &sourceCache
              ) {
                _children.append(
                  .initializer(
                    InitializerAPI(
                      _documentation: declaration._documentation,
                      declaration: declaration
                    )
                  )
                )
              }
            }
          case .method:
            if ¬(self is ModuleAPI) {  // Skip on global pass.
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
            }
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
              api.assimilate(conformances: conformances(of: symbol, in: symbolGraph))
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
              api.assimilate(conformances: conformances(of: symbol, in: symbolGraph))
              _children.append(.type(api))
            }
          case .subscript:
            if ¬(self is ModuleAPI) {  // Skip on global pass.
              if let declaration = try declaration(
                of: symbol,
                as: SubscriptDeclSyntax.self,
                cache: &sourceCache
              ) {
                _children.append(
                  .subscript(
                    SubscriptAPI(
                      _documentation: declaration._documentation,
                      declaration: declaration
                    )
                  )
                )
              }
            }
          case .typeMethod:
            if ¬(self is ModuleAPI) {  // Skip on global pass.
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
            }
          case .typeProperty:
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
        }
        if self is ModuleAPI {
          var extendedTypes: [String: Set<String>] = [:]
          for relationship in symbolGraph.relationships {
            switch relationship.kind {
            case .memberOf:
              if let fallback = relationship.targetFallback {
                extendedTypes[relationship.target, default: []].insert(fallback)
              }
            default:
              break
            }
          }
          for (identifier, names) in extendedTypes {
            if let name = names.sorted().first {
              let syntax = SyntaxFactory.makeTypeIdentifier(name.dropping(through: "."))
              let api = ExtensionAPI(_type: syntax, constraints: nil, children: [])
              try api.assimilate(
                symbols: children(of: identifier, in: symbolGraph),
                from: symbolGraph,
                sourceCache: &sourceCache
              )
              _children.append(.extension(api))
            }
          }
        }
      }
    #endif

    func assimilate(conformances: [String]) {
      for conformance in conformances {
        _children.append(
          .conformance(ConformanceAPI(_type: SyntaxFactory.makeTypeIdentifier(conformance)))
        )
      }
      _children.sort()
    }

    func children(of symbol: SymbolGraph.Symbol, in graph: SymbolGraph) -> [SymbolGraph.Symbol] {
      return children(of: symbol.identifier.precise, in: graph)
    }
    func children(of symbolIdentifier: String, in graph: SymbolGraph) -> [SymbolGraph.Symbol] {
      return graph.relationships.filter({ relationship in
        switch relationship.kind {
        case .memberOf:
          return relationship.target == symbolIdentifier
        default:
          return false
        }
      }).compactMap({ relationship in
        return graph.symbols[relationship.source]
      })
    }

    func conformances(of symbol: SymbolGraph.Symbol, in graph: SymbolGraph) -> [String] {
      return graph.relationships.filter({ relationship in
        switch relationship.kind {
        case .conformsTo, .inheritsFrom:
          return relationship.source == symbol.identifier.precise
        default:
          return false
        }
      }).compactMap({ relationship in
        let names = graph.symbols[relationship.target]?.names
        return names?.prose ?? names?.title
          ?? relationship.targetFallback.map { $0.dropping(through: ".") }
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
