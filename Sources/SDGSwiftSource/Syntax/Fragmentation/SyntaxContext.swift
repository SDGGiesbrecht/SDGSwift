/*
 SyntaxContext.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

  /// The context of a syntax node.
  public struct SyntaxContext {

    // MARK: - Initialization

    internal init(
      fragmentContext: String,
      fragmentOffset: String.ScalarOffset,
      parentContext: (code: CodeFragmentSyntax, context: ExtendedSyntaxContext)?
    ) {
      self.fragmentContext = fragmentContext
      self.fragmentOffset = fragmentOffset
      self.parentContext = parentContext
    }

    // MARK: - Properties

    internal let fragmentContext: String
    internal let fragmentOffset: String.ScalarOffset
    internal let parentContext: (code: CodeFragmentSyntax, context: ExtendedSyntaxContext)?

    /// Returns whether or not the context is fragmented.
    public func isFragmented() -> Bool {
      return parentContext ≠ nil
    }
  }
