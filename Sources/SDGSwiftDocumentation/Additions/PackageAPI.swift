/*
 PackageAPI.swift

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

import SDGSwiftSource
#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax
#endif
#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
  import SwiftSyntaxParser
#endif

/// The API of a package.
public struct PackageAPI: SymbolLike {

  // MARK: - Static Methods

  private static func declaration(
    for name: String
  ) -> [SymbolGraph.Symbol.DeclarationFragments.Fragment] {
    return [
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .typeIdentifier,
        spelling: "Package",
        preciseIdentifier: nil
      ),
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .text,
        spelling: "(",
        preciseIdentifier: nil
      ),
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .externalParameter,
        spelling: "name",
        preciseIdentifier: nil
      ),
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .text,
        spelling: ":",
        preciseIdentifier: nil
      ),
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .text,
        spelling: " ",
        preciseIdentifier: nil
      ),
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .stringLiteral,
        spelling: "\u{22}\(name)\u{22}",
        preciseIdentifier: nil
      ),
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .text,
        spelling: ")",
        preciseIdentifier: nil
      ),
    ]
  }

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
    internal static func find<Node>(
      _ declaration: [SymbolGraph.Symbol.DeclarationFragments.Fragment],
      in manifest: SourceFileSyntax,
      as nodeType: Node.Type
    ) -> Node? where Node: SyntaxProtocol {
      let declarationSource: String = declaration.dropLast().lazy.map({ $0.spelling }).joined()
      let name = declarationSource.scalars.truncated(after: "(".scalars)
      let parameters = declarationSource.scalars.dropping(through: "(".scalars)
      let partialSearch =
        name
        + RepetitionPattern(ConditionalPattern({ $0 ∈ CharacterSet.whitespacesAndNewlines }))
      let search = partialSearch + parameters
      guard let foundNode = manifest.smallestSubnode(containing: search) else {
        return nil
      }
      return foundNode.as(Node.self)
        ?? foundNode.ancestors().lazy.compactMap({ node in
          return node.as(Node.self)
        }).first
    }
  #endif

  // MARK: - Initialization

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
    /// Creates a package API.
    ///
    /// - Parameters:
    ///   - name: The name of the package.
    ///   - manifestURL: The URL of the manifest.
    ///   - manifestSource: The source of the manifest.
    ///   - libraries: The libraries.
    ///   - symbolGraphs: The symbol graphs.
    ///   - moduleSources: A list of module sources in the form of a dictionary whose keys are module names and whose values are arrays of file URLs.
    public init(
      name: String,
      manifestURL: String,
      manifestSource: SourceFileSyntax,
      libraries: [LibraryAPI],
      symbolGraphs: [SymbolGraph],
      moduleSources: [String: [URL]]
    ) {
      let declaration = PackageAPI.find(
        PackageAPI.declaration(for: name),
        in: manifestSource,
        as: VariableDeclSyntax.self
      )
      self.init(
        name: name,
        documentationComment: declaration?.documentation,
        location: declaration?.location(url: manifestURL, source: manifestSource),
        libraries: libraries,
        symbolGraphs: symbolGraphs,
        moduleSources: moduleSources,
        moduleDocumentationCommentLookup: { name in
          return ModuleAPI.lookUpDeclaration(for: name, in: manifestSource)?.documentation
        },
        moduleDeclarationLocationLookup: { name in
          return ModuleAPI.lookUpDeclaration(for: name, in: manifestSource)?.location(
            url: manifestURL,
            source: manifestSource
          )
        }
      )
    }
  #endif

  /// Creates a package API.
  ///
  /// - Parameters:
  ///   - name: The name of the package.
  ///   - documentationComment: The documentation comment.
  ///   - location: The location of the declaration in the source code.
  ///   - libraries: The libraries.
  ///   - symbolGraphs: The symbol graphs.
  ///   - moduleSources: A list of module sources in the form of a dictionary whose keys are module names and whose values are arrays of file URLs.
  ///   - moduleDocumentationCommentLookup: A closure which looks up a module’s documentation comment.
  ///   - moduleDeclarationLocationLookup: A closure which looks up the location of a module’s declaration.
  public init(
    name: String,
    documentationComment: SymbolGraph.LineList?,
    location: SymbolGraph.Symbol.Location?,
    libraries: [LibraryAPI],
    symbolGraphs: [SymbolGraph],
    moduleSources: [String: [URL]],
    moduleDocumentationCommentLookup: (String) -> SymbolGraph.LineList?,
    moduleDeclarationLocationLookup: (String) -> SymbolGraph.Symbol.Location?
  ) {
    let declaration = PackageAPI.declaration(for: name)
    self.names = SymbolGraph.Symbol.Names(
      title: name,
      navigator: nil,
      subHeading: declaration,
      prose: nil
    )
    self.declaration = SymbolGraph.Symbol.DeclarationFragments(declarationFragments: declaration)
    self.docComment = documentationComment
    self.location = location
    self.libraries = libraries
    var existing: Set<String> = []
    self.modules =
      libraries
      .flatMap({ $0.modules })
      .filter({ existing.insert($0).inserted })
      .map({ name in
        return ModuleAPI(
          name: name,
          documentationComment: moduleDocumentationCommentLookup(name),
          location: moduleDeclarationLocationLookup(name),
          symbolGraphs: symbolGraphs.filter({ $0.module.name == name }),
          sources: moduleSources[name] ?? []
        )
      })
  }

  // MARK: - Properties

  /// The library products vended by the package.
  public var libraries: [LibraryAPI]

  /// The modules vended in one or more library products.
  public var modules: [ModuleAPI]

  /// The package’s symbol graphs.
  public func symbolGraphs() -> [SymbolGraph] {
    return modules.flatMap { $0.symbolGraphs }
  }

  // MARK: - SymbolLike

  public var names: SymbolGraph.Symbol.Names
  public var declaration: SymbolGraph.Symbol.DeclarationFragments?
  public var docComment: SymbolGraph.LineList?
  public var location: SymbolGraph.Symbol.Location?
}
