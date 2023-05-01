/*
 NumberedHeading.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN
  import Markdown
#endif

/// A heading in source code using number sign notation.
public struct NumberedHeading: StreamedViaChildren, SyntaxNode {

  // MARK: - Properties

  /// The delimiter.
  public let delimiter: Token

  /// Any space between the delimiter and the heading text.
  public let indent: Token?

  /// The heading.
  public let heading: MarkdownNode

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    var children: [SyntaxNode] = [delimiter]
    if let indent = indent {
      children.append(indent)
    }
    children.append(heading)
    return children
  }
}
