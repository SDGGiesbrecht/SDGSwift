/*
 MarkdownNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN
  import Markdown
#endif

/// A syntax node from the Markdown library.
public struct MarkdownNode: SyntaxNode, TextOutputStreamable {

  // MARK: - Initialization

  /// Creates a Markdown node by parsing source.
  ///
  /// - Parameters:
  ///   - source: The Markdown source.
  public init(source: String) {
    #if PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN
      self.rootSource = source
      self.range = source.scalars.bounds
    #else
      self.init(
        unsafeMarkdown: Document(parsing: source),
        rootSource: source,
        range: source.scalars.bounds
      )
    #endif
  }

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN
    /// This must remain private to ensure only *parsed* nodes are accepted, so that they have the requisite range information. See `children`.
    private init(
      unsafeMarkdown markdown: Markup,
      rootSource: String,
      range: Range<String.UnicodeScalarView.Index>
    ) {
      self.markdown = markdown
      self.rootSource = rootSource
      self.range = range
    }
  #endif

  // MARK: - Properties

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN
    /// The Markdown node.
    public let markdown: Markup
  #endif
  private let rootSource: String
  private let range: Range<String.UnicodeScalarView.Index>

  // MARK: - SyntaxNode

  public func children(cache: inout ParserCache) -> [SyntaxNode] {
    #if PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN
      return [Token.unknown(text)]
    #else
      switch markdown {
      case is InlineCode:
        return [
          InlineCodeNode(source: text)
            ?? Token.unknown(text)  // @exempt(from: tests)
        ]
      case is SoftBreak:
        return [Token(kind: .lineBreaks(text))]
      case is Text:
        return [Token(kind: .documentationText(text))]
      default:
        var lastAccountedForIndex: String.UnicodeScalarView.Index = self.range.lowerBound
        func interveningNodes(upTo index: String.UnicodeScalarView.Index) -> [SyntaxNode] {
          guard index ≠ lastAccountedForIndex else {
            return []
          }
          var source = rootSource.scalars[lastAccountedForIndex..<index]
          var kinds: [Token.Kind] = []
          while ¬source.isEmpty {
            let first = source.removeFirst()
            switch first {
            case " ", "\t":
              var group = String(first)
              while source.first == first {
                group.scalars.append(source.removeFirst())
              }
              kinds.append(.whitespace(group))
            case "#":
              var group = String(first)
              while source.first == first {
                group.scalars.append(source.removeFirst())
              }
              kinds.append(.headingDelimiter(group))
            default:
              kinds.append(.swiftSyntax(.unknown(String(first))))
            }
          }
          return kinds.map { Token(kind: $0) }
        }
        var result = markdown.children.flatMap({ child in
          let childRange: Range<String.UnicodeScalarView.Index>
          defer { lastAccountedForIndex = childRange.upperBound }
          if let knownRange = child.range {
            childRange = rootSource.scalarRange(of: knownRange)
          } else {
            childRange = lastAccountedForIndex..<lastAccountedForIndex
          }
          var intervening = interveningNodes(upTo: childRange.lowerBound)

          if let heading = child as? Heading {
            var indent: Token?
            if let foundIndent = intervening.last as? Token {
              indent = foundIndent
            }
            if let delimiter = intervening.last as? Token,
              case .headingDelimiter = delimiter.kind
            {
              if indent ≠ nil {
                intervening.removeLast()
              }
              intervening.removeLast()
              return intervening.appending(
                NumberedHeading(
                  delimiter: delimiter,
                  indent: indent,
                  heading: MarkdownNode(
                    unsafeMarkdown: heading,
                    rootSource: rootSource,
                    range: childRange
                  )
                )
              )
            }
          }

          return intervening.appending(
            MarkdownNode(
              unsafeMarkdown: child,
              rootSource: rootSource,
              range: childRange
            )
          )
        })
        result.append(contentsOf: interveningNodes(upTo: self.range.upperBound))
        return result
      }
    #endif
  }

  // MARK: - TextOutputStreamable

  public func write<Target>(to target: inout Target) where Target: TextOutputStream {
    String(String.UnicodeScalarView(rootSource.scalars[range])).write(to: &target)
  }
}
