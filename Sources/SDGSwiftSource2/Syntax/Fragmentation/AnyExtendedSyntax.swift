/*
 AnyExtendedSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type‐erased syntax node.
public struct AnyExtendedSyntax: ExtendedSyntax {

  // MARK: - Initialization

  /// Creates a type‐erased syntax node.
  ///
  /// - Parameters:
  ///   - wrapped: The syntax node to type‐erase.
  public init(_ wrapped: ExtendedSyntax) {
    self.wrapped = wrapped
  }

  // MARK: - Properties

  public var wrapped: ExtendedSyntax

  // MARK: - Properties

  public var children: [ExtendedSyntax] {
    return wrapped.children
  }
}
