/*
 SourceHeading.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A heading in source code.
public struct SourceHeading: StreamedViaChildren, SyntaxNode {

  // MARK: - Static Properties

  /// The fullest form of delimiter.
  public static let fullDelimiter: String = "MARK: \u{2D} "
  internal static let minimalDelimiter: String = "MARK:"

  // MARK: - Initialization

  internal init(
    mark: Token,
    heading: Token
  ) {
    self.mark = mark
    self.heading = heading
  }

  // MARK: - Properties

  /// The delimiter.
  public let mark: Token

  /// The heading.
  public let heading: Token

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    return [mark, heading]
  }
}
