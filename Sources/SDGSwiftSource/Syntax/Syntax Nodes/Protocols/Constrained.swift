/*
 Constrained.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

/// A declaration syntax node which includes constraints.
public protocol Constrained: Syntax {
  /// The constraint clause.
  var genericWhereClause: GenericWhereClauseSyntax? { get }
  /// Creates a new node by replacing the constraint clause.
  ///
  /// - Parameters:
  ///     - clause: The new generic “where” clause.
  func withGenericWhereClause(_ clause: GenericWhereClauseSyntax?) -> Self
}
