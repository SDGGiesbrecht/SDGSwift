/*
 ImageNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An image insertion in documentation.
public struct ImageNode: StreamedViaChildren, SyntaxNode {

  // MARK: - Initialization

  internal init?(components: [SyntaxNode]) {
    var remainder = components[...]

    guard let leadingDelimiters = remainder.first as? Token else {
      return nil  // @exempt(from: tests) Believed to be unreachable.
    }
    remainder.removeFirst()

    var leadingDelimitersRemainder = leadingDelimiters.text()[...]

    guard leadingDelimitersRemainder.first == "!" else {
      return nil  // @exempt(from: tests) Believed to be unreachable.
    }
    leadingDelimitersRemainder.removeFirst()
    self.delimiter = Token(kind: .imageDelimiter)

    guard
      leadingDelimitersRemainder.elementsEqual("["),
      let link = LinkNode(
        components: [Token(kind: .openingLinkContentDelimiter)].appending(
          contentsOf: remainder
        )
      )
    else {
      return nil  // @exempt(from: tests) Believed to be unreachable.
    }
    self.link = link
  }

  // MARK: - Properties

  /// The delimiter.
  public let delimiter: Token

  /// The link.
  public let link: LinkNode

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    return [delimiter, link]
  }
}
