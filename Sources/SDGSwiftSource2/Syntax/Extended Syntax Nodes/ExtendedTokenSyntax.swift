/*
 ExtendedTokenSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A syntax node representing a single token.
///
/// This type is comparable to `TokenSyntax`, but represents syntax not handled by the `SwiftSyntax` module.
public final class ExtendedTokenSyntax: ExtendedSyntax, TextOutputStreamable {

  // MARK: - Initialization

  /// Creates an extended syntax token.
  public init(
    kind: ExtendedTokenKind
  ) {
    self.kind = kind
  }

  // MARK: - Properties

  /// The kind of the token.
  public let kind: ExtendedTokenKind

  // MARK: - ExtendedSyntax

  public var children: [ExtendedSyntax] {
    return []
  }

  // MARK: - TextOutputStreamable

  public func write<Target>(
    to target: inout Target
  ) where Target: TextOutputStream {
    kind.text.write(to: &target)
  }
}
