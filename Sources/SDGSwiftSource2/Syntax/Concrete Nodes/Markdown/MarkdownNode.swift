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
import SDGMathematics
import SDGCollections

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
      return [Token.unknown(text())]
    #else
      switch markdown {
      case is BlockQuote:
        let components = fallbackChildren()
        return Quotation(components: components).map({ [$0] })
          ?? components  // @exempt(from: tests)
      case is CodeBlock:
        return CodeBlockNode(source: text()).map({ [$0] })
          ?? fallbackChildren()  // @exempt(from: tests)
      case is Emphasis:
        let components = fallbackChildren()
        return EmphasisNode(components: components).map({ [$0] })
          ?? components  // @exempt(from: tests)
      case is InlineCode:
        return InlineCodeNode(source: text()).map({ [$0] })
          ?? fallbackChildren()  // @exempt(from: tests)
      case is Heading:
        return NumberedHeading(source: text()).map({ [$0] })
          ?? UnderlinedHeading(source: text()).map({ [$0] })
          ?? fallbackChildren()  // @exempt(from: tests)
      case is Image:
        let components = fallbackChildren()
        return ImageNode(components: components).map({ [$0] })
          ?? components  // @exempt(from: tests)
      case is LineBreak:
        return [Token(kind: .markdownLineBreak)]
      case is Link:
        let components = fallbackChildren()
        return LinkNode(components: components).map({ [$0] })
          ?? components  // @exempt(from: tests)
      case is ListItem:
        let components = fallbackChildren()
        guard let list = ListItemNode(components: components) else {
          return components  // @exempt(from: tests)
        }
        return [CalloutNode(listItem: list, cache: &cache) ?? list]
      case is OrderedList:
        return [ListNode(components: fallbackChildren(), isOrdered: true)]
      case is Paragraph:
        return [ParagraphNode(components: fallbackChildren())]
      case is SoftBreak:
        return [Token(kind: .lineBreaks(text()))]
      case is Strong:
        let components = fallbackChildren()
        return StrongNode(components: components).map({ [$0] })
          ?? components  // @exempt(from: tests)
      case is Text:
        return [Token(kind: .documentationText(text()))]
      case is ThematicBreak:
        var children: [SyntaxNode] = []
        var components = text()
        if text().scalars.last ∈ MarkdownNode.lineBreakScalars {
          children.append(Token(kind: .lineBreaks(String(components.removeLast()))))
        }
        return children.prepending(Token(kind: .asterism(components)))
      case is UnorderedList:
        return ListNode.filterCallouts(fromUnorderedList: fallbackChildren(), cache: &cache)
      default:
        return fallbackChildren()
      }
    #endif
  }

  private static let whitespaceScalars: Set<Unicode.Scalar> = [" ", "\t"]
  private static let lineBreakScalars: Set<Unicode.Scalar> = ["\n", "\r"]
  private static let syntaxScalars = whitespaceScalars ∪ lineBreakScalars
  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN
    private func fallbackChildren() -> [SyntaxNode] {
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
          case MarkdownNode.whitespaceScalars:
            var group = String(first)
            while source.first == first {
              group.scalars.append(source.removeFirst())
            }
            kinds.append(.whitespace(group))
          case MarkdownNode.lineBreakScalars:
            var group = String(first)
            while source.first == first {
              group.scalars.append(source.removeFirst())
            }
            kinds.append(.lineBreaks(group))
          default:
            var group = String(first)
            while ¬source.isEmpty,
              source.first ∉ MarkdownNode.syntaxScalars
            {
              group.scalars.append(source.removeFirst())
            }
            kinds.append(Token.unknown(group).kind)
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
        return interveningNodes(upTo: childRange.lowerBound).appending(
          MarkdownNode(
            unsafeMarkdown: child,
            rootSource: rootSource,
            range: childRange
          )
        )
      })
      result.append(contentsOf: interveningNodes(upTo: self.range.upperBound))

      // Line break’s ranges are misaligned.
      while let documentationIndex = result.indices.first(where: { index in
        if (result[index...].dropFirst().first as? MarkdownNode)?.markdown is LineBreak,
          let textMarkdown = result[index] as? MarkdownNode,
          textMarkdown.markdown is Text,
          textMarkdown.text().hasSuffix("  ")
        {
          return true
        } else {
          return false
        }
      }) {
        let documentation = result[documentationIndex] as! MarkdownNode
        let adjustedDivision = documentation.rootSource.index(
          documentation.range.upperBound,
          offsetBy: −2
        )
        result[documentationIndex] = MarkdownNode(
          unsafeMarkdown: documentation.markdown,
          rootSource: documentation.rootSource,
          range: documentation.range.lowerBound..<adjustedDivision
        )
        let lineBreakIndex = result.index(after: documentationIndex)
        let lineBreak = result[lineBreakIndex] as! MarkdownNode
        result[lineBreakIndex] = MarkdownNode(
          unsafeMarkdown: lineBreak.markdown,
          rootSource: lineBreak.rootSource,
          range: adjustedDivision..<lineBreak.range.upperBound
        )
      }

      return result
    }
  #endif

  // MARK: - TextOutputStreamable

  public func write<Target>(to target: inout Target) where Target: TextOutputStream {
    String(String.UnicodeScalarView(rootSource.scalars[range])).write(to: &target)
  }
}
