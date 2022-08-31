/*
 SymbolGraph.Symbol.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGCollections

import SymbolKit

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax
#endif
#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
  import SwiftSyntaxParser
#endif

extension SymbolGraph.Symbol: SymbolLike {

  // MARK: - SymbolLike

  public var declaration: DeclarationFragments? {
    return mixins[DeclarationFragments.mixinKey] as? DeclarationFragments
  }

  public var location: Location? {
    get {
      return mixins[Location.mixinKey] as? Location
    }
    set {
      mixins[Location.mixinKey] = newValue
    }
  }

  #if PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
    // #documenation(SymbolLike.CachedSource)
    /// A parsed file.
    public typealias CachedSource = Any
  #else
    // @documenation(SymbolLike.CachedSource)
    /// A parsed file.
    public typealias CachedSource = SourceFileSyntax
  #endif
  public func parseDocumentation(cache: inout [URL: CachedSource]) -> [SymbolDocumentation] {
    func fallback() -> [SymbolDocumentation] {
      if let stored = docComment {
        return [
          SymbolDocumentation(
            developerComments: SymbolGraph.LineList(lines: []),
            documentationComment: stored
          )
        ]
      } else {
        return []
      }
    }
    #if PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
      return fallback()
    #else
      guard let location = self.location,
        let encoded = location.uri.addingPercentEncoding(
          withAllowedCharacters: CharacterSet(
            charactersIn: (0x00..<0x80).map({ Unicode.Scalar($0)! })
          ) ∖ CharacterSet(charactersIn: " ")
        ),
        let url = URL(string: encoded),
        let source = try? SyntaxParser.parse(url)
      else {
        return fallback()
      }
      let converter = SourceLocationConverter(file: location.uri, tree: source)
      let position = converter.position(
        ofLine: SourceLocation.convertLine(fromSymbolGraph: location.position.line),
        column: SourceLocation.convertColumn(fromSymbolGraphCharacter: location.position.character)
      )
      func scan<Node>(for type: Node.Type) -> [SymbolDocumentation]
      where Node: SyntaxProtocol {
        return source.smallest(type, at: position)?
          .documentation(url: location.uri, source: source)
          ?? []
      }
      switch kind.identifier {
      case .associatedtype:
        return scan(for: AssociatedtypeDeclSyntax.self)
      case .class:
        return scan(for: ClassDeclSyntax.self)
      case .deinit:
        return scan(for: DeinitializerDeclSyntax.self)
      case .enum:
        return scan(for: EnumDeclSyntax.self)
      case .`case`:
        return scan(for: EnumCaseDeclSyntax.self)
      case .func, .operator, .method, .typeMethod:
        return scan(for: FunctionDeclSyntax.self)
      case .`init`:
        return scan(for: InitializerDeclSyntax.self)
      case .property, .typeProperty, .var:
        return scan(for: VariableDeclSyntax.self)
      case .protocol:
        return scan(for: ProtocolDeclSyntax.self)
      case .struct:
        return scan(for: StructDeclSyntax.self)
      case .subscript, .typeSubscript:
        return scan(for: SubscriptDeclSyntax.self)
      case .typealias:
        return scan(for: TypealiasDeclSyntax.self)
      case .module, .unknown:
        return []
      }
    #endif
  }
}
