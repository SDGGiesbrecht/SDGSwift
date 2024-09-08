/*
 SyntaxProtocol.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

  extension SyntaxProtocol {

    // MARK: - Source

    // #documentation(SyntaxNode.text())
    /// Returns the node’s source text.
    public func text() -> String {
      var result = ""
      write(to: &result)
      return result
    }

    // MARK: - Ancestry

    /// All the node’s ancestors in order from its immediate parent to the root node.
    public var ancestors: AnySequence<Syntax> {
      if let parent = self.parent {
        return AnySequence(sequence(first: parent, next: { $0.parent }))
      } else {
        return AnySequence([])
      }
    }

    internal func isInIfConfigurationCondition() -> Bool {
      var previousAncestor: Syntax = Syntax(self)
      for ancestor in ancestors {
        defer { previousAncestor = ancestor }
        if let ifConfigurationClause = ancestor.as(IfConfigClauseSyntax.self),
          let condition = Syntax(ifConfigurationClause.condition),
          condition == previousAncestor
        {
          return true
        }
      }
      return false
    }

    // MARK: - Tokens

    // @documentation(SDGSwiftSource.Syntax.firstToken())
    /// Return the first token of the node.
    public func firstToken() -> TokenSyntax? {
      if let token = Syntax(self).as(TokenSyntax.self),
        token.presence == .present
      {
        return token
      }
      return children(viewMode: .sourceAccurate).lazy.compactMap({ $0.firstToken() }).first
    }

    // @documentation(SDGSwiftSource.Syntax.lastToken())
    /// Returns the last token of the node.
    public func lastToken() -> TokenSyntax? {
      if let token = Syntax(self).as(TokenSyntax.self),
        token.presence == .present
      {
        return token
      }
      return children(viewMode: .sourceAccurate).reversed()
        .lazy.compactMap({ $0.lastToken() }).first
    }
  }
