/*
 ModuleAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwiftSource

import SwiftSyntax
import SymbolKit

extension ModuleAPI {

  func assimilate(symbolGraph: SymbolGraph) {
    for (_, symbol) in symbolGraph.symbols {

      // #workaround(Not implemented yet.)
      let documentation: [SymbolDocumentation] = []
      let children: [APIElement] = []

      switch symbol.kind.identifier {
      case .associatedtype:
        // #workaround(Not implemented yet.)
        print("associatedtype: \(symbol.names.prose ?? symbol.names.title)")
      case .class:
        let declaration = SyntaxFactory.makeClassDecl(
          attributes: nil,
          modifiers: nil,
          classOrActorKeyword: SyntaxFactory.makeToken(.classKeyword),
          identifier: SyntaxFactory.makeToken(
            .identifier(symbol.names.subHeading!.dropFirst(2).map({ $0.spelling }).joined())
          ),
          genericParameterClause: nil,
          inheritanceClause: nil,
          genericWhereClause: nil,
          members: SyntaxFactory.makeBlankMemberDeclBlock()
        )
        _children.append(
          .type(
            TypeAPI(_documentation: documentation, declaration: declaration, children: children)
          )
        )
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
}
