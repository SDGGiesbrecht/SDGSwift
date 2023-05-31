/*
 SymbolGraph.Symbol.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGCollections

import SymbolKit

  import SwiftSyntax
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

    // @documenation(SymbolLike.CachedSource)
    /// A parsed file.
    public typealias CachedSource = SourceFileSyntax
  public func parseDocumentation(
    cache: inout [URL: CachedSource],
    module: String?
  ) -> [SymbolDocumentation] {
    func fallback() -> [SymbolDocumentation] {
      if let stored = docComment {
        return [
          SymbolDocumentation(
            developerComments: SymbolGraph.LineList(
              [],
              uri: stored.uri,
              moduleName: stored.moduleName
            ),
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
      let inheritedLocation: SymbolGraph.Symbol.Location?
      if let documentation = docComment,
        let uri = documentation.uri,
        let firstLine = documentation.lines.first?.range
      {
        inheritedLocation = SymbolGraph.Symbol.Location(uri: uri, position: firstLine.start)
      } else {
        inheritedLocation = nil
      }
      guard let location = inheritedLocation ?? self.location,
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
      func scan<Node>(for type: Node.Type) -> [SymbolDocumentation]?
      where Node: SyntaxProtocol {
        return source.smallest(type, at: position)?
          .documentation(url: location.uri, source: source, module: module)
      }
      switch kind.identifier {
      case .associatedtype:
        return scan(for: AssociatedtypeDeclSyntax.self)
          ?? []  // @exempt(from: tests) Theoretically unreachable.
      case .class:
        return scan(for: ClassDeclSyntax.self)
          ?? []  // @exempt(from: tests) Theoretically unreachable.
      case .deinit:  // @exempt(from: tests) Do not seem to actually be in graph.
        return scan(for: DeinitializerDeclSyntax.self) ?? []
      case .enum:
        return scan(for: EnumDeclSyntax.self)
          ?? []  // @exempt(from: tests) Theoretically unreachable.
      case .`case`:
        return scan(for: EnumCaseDeclSyntax.self)
          ?? []  // @exempt(from: tests) Theoretically unreachable.
      case .func, .operator, .method, .typeMethod:
        return scan(for: FunctionDeclSyntax.self)
          ?? []  // @exempt(from: tests) Theoretically unreachable.
      case .`init`:
        return scan(for: InitializerDeclSyntax.self)
          ?? []  // @exempt(from: tests) Theoretically unreachable.
      case .ivar, .macro, .module, .snippet, .snippetGroup:
        return []  // @exempt(from: tests) Theoretically unreachable.
      case .property, .typeProperty, .var:
        return scan(for: VariableDeclSyntax.self)
          ?? []  // @exempt(from: tests) Theoretically unreachable.
      case .protocol:
        return scan(for: ProtocolDeclSyntax.self)
          ?? []  // @exempt(from: tests) Theoretically unreachable.
      case .struct:
        return scan(for: StructDeclSyntax.self)
          ?? []  // @exempt(from: tests) Theoretically unreachable.
      case .subscript, .typeSubscript:
        return scan(for: SubscriptDeclSyntax.self)
          ?? []  // @exempt(from: tests) Theoretically unreachable.
      case .typealias:
        return scan(for: TypealiasDeclSyntax.self)
          ?? scan(for: AssociatedtypeDeclSyntax.self)
          ?? []  // @exempt(from: tests) Theoretically unreachable.
      default:  // @exempt(from: tests)
        #if DEBUG
          print("Unidentified symbol graph node: \(kind.identifier) (\(#fileID), \(#function))")
        #endif
        return []
      }
    #endif
  }
}
