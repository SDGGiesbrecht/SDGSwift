/*
 ExtendedSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// A syntax node.
///
/// This type is comparable to `Syntax`, but represents syntax not handled by the `SwiftSyntax` module.
public class ExtendedSyntax : TextOutputStreamable {

    internal init(children: [ExtendedSyntax]) {
        self.children = children
    }

    // MARK: - Properties

    /// The children of this node.
    public internal(set) var children: [ExtendedSyntax]

    private var _offset: Int?
    private private(set) var positionOffset: Int {
        get {
            return _offset! // The unwrap can only fail if the top‐level node forgot to call determinePositions().
        }
        set {
            _offset = newValue
        }
    }
    private var endPositionOffset: Int {
        if let token = self as? ExtendedTokenSyntax {
            return positionOffset + token.text.scalars.count
        } else {
            return children.last?.endPositionOffset ?? positionOffset // @exempt(from: tests) Shouldn’t be childless.
        }
    }
    internal func determinePositions() {
        var offset = 0
        determineNestedPositions(offset: &offset)
    }
    private func determineNestedPositions(offset: inout Int) {
        positionOffset = offset
        for index in children.indices {
            let child = children[index]
            child.parent = self
            child.indexInParent = index

            child.determineNestedPositions(offset: &offset)
            if let token = child as? ExtendedTokenSyntax {
                offset = token.endPositionOffset
            }
        }
    }

    public internal(set) weak var parent: ExtendedSyntax?
    public internal(set) var indexInParent: Int = 0

    public var text: String {
        var result = ""
        write(to: &result)
        return result
    }

    // MARK: - Location

    public func lowerBound(in context: ExtendedSyntaxContext) -> String.ScalarView.Index {
        switch context {
        case .trivia(let trivia, context: let triviaContext):
            let sourceStart = trivia.lowerBound(in: triviaContext)
            return triviaContext.source.scalars.index(sourceStart, offsetBy: positionOffset)
        case .token(let token, context: let tokenContext):
            let sourceStart = token.lowerSyntaxBound(in: tokenContext)
            return tokenContext.fragmentContext.scalars.index(sourceStart, offsetBy: positionOffset)
        case .fragment(let code, context: let codeContext, offset: let offset):
            let fragmentLocation = code.lowerBound(in: codeContext)
            return codeContext.source.scalars.index(fragmentLocation, offsetBy: offset)
        }
    }

    public func upperBound(in context: ExtendedSyntaxContext) -> String.ScalarView.Index {
        switch context {
        case .trivia(let trivia, context: let triviaContext):
            let sourceStart = trivia.lowerBound(in: triviaContext)
            return triviaContext.source.scalars.index(sourceStart, offsetBy: endPositionOffset)
        case .token(let token, context: let tokenContext):
            let sourceStart = token.lowerSyntaxBound(in: tokenContext)
            return tokenContext.fragmentContext.scalars.index(sourceStart, offsetBy: endPositionOffset)
        case .fragment(let code, context: let codeContext, offset: let offset):
            let fragmentLocation = code.lowerBound(in: codeContext)
            return codeContext.source.scalars.index(fragmentLocation, offsetBy: offset + text.scalars.count)
        }
    }

    public func range(in context: ExtendedSyntaxContext) -> Range<String.ScalarView.Index> {
        return lowerBound(in: context) ..< upperBound(in: context)
    }

    // MARK: - Syntax Tree

    public func ancestors() -> AnySequence<ExtendedSyntax> {
        if let parent = self.parent {
            return AnySequence(sequence(first: parent, next: { $0.parent }))
        } else {
            return AnySequence([])
        }
    }

    private var parentRelationship: (parent: ExtendedSyntax, index: Int)? {
        guard let parent = self.parent else {
            return nil
        }
        return (parent, indexInParent)
    }
    internal func ancestorRelationships() -> AnySequence<(parent: ExtendedSyntax, index: Int)> {
        if let parentRelationship = self.parentRelationship {
            return AnySequence(sequence(first: parentRelationship, next: { $0.parent.parentRelationship }))
        } else {
            return AnySequence([]) // @exempt(from: tests) Unreachable. No extended token is a top‐level node.
        }
    }

    public func firstToken() -> ExtendedTokenSyntax? {
        if let token = self as? ExtendedTokenSyntax,
            ¬token.text.isEmpty {
            return token
        }
        return children.lazy.compactMap({ $0.firstToken() }).first
    }

    public func lastToken() -> ExtendedTokenSyntax? {
        if let token = self as? ExtendedTokenSyntax,
            ¬token.text.isEmpty {
            return token
        }
        return children.reversed().lazy.compactMap({ $0.lastToken() }).first
    }

    // MARK: - Rendering

    internal var renderedHtmlElement: String? {
        return nil
    }

    internal var renderedHTMLAttributes: [String: String] {
        return [:]
    }

    // @documentation(SDGSwiftSource.Syntax.renderedHTML)
    /// Returns the HTML result of documentation rendering.
    ///
    /// The resulting HTML depends on the CSS provided by `SyntaxHighlighter.css`.
    ///
    /// - Parameters:
    ///     - localization: The localization to use for generated content such as callout headings.
    ///     - internalIdentifiers: Optional. A set of identifiers to consider as belonging to the module.
    ///     - symbolLinks: Optional. A dictionary of target links for cross‐linking symbols. The values will be inserted as‐is in `href` attributes. URLs must already be properly encoded for this context before passing them.
    public func renderedHTML(localization: String, internalIdentifiers: Set<String> = [], symbolLinks: [String: String] = [:]) -> String {
        var result = ""
        if let element = renderedHtmlElement {
            result.append(contentsOf: "<" + element)
            let attributes = renderedHTMLAttributes
            if ¬attributes.isEmpty {
                for key in attributes.keys.sorted() {
                    result.append(contentsOf: " " + key + "=\u{22}" + attributes[key]! + "\u{22}")
                }
            }
            result.append(contentsOf: ">")
        }
        for child in children {
            result.append(contentsOf: child.renderedHTML(localization: localization, internalIdentifiers: internalIdentifiers, symbolLinks: symbolLinks))
        }
        if let element = renderedHtmlElement {
            result.append(contentsOf: "</" + element + ">")
        }
        return result
    }

    // MARK: - Syntax Colouring

    // #documentation(SDGSwiftSource.Syntax.syntaxHighlightedHTML)
    /// Returns a syntax‐highlighted HTML representation of the source.
    ///
    /// The resulting HTML depends on the CSS provided by `SyntaxHighlighter.css`.
    ///
    /// - Parameters:
    ///     - inline: Pass `true` to generate inline HTML instead of a separate block section.
    ///     - internalIdentifiers: Optional. A set of identifiers to consider as belonging to the module.
    ///     - symbolLinks: Optional. A dictionary of target links for cross‐linking symbols. The values will be inserted as‐is in `href` attributes. URLs must already be properly encoded for this context before passing them.
    public func syntaxHighlightedHTML(inline: Bool, internalIdentifiers: Set<String> = [], symbolLinks: [String: String] = [:]) -> String {
        return SyntaxHighlighter.frame(highlightedSyntax: nestedSyntaxHighlightedHTML(internalIdentifiers: internalIdentifiers, symbolLinks: symbolLinks), inline: inline)
    }

    internal func nestedSyntaxHighlightedHTML(internalIdentifiers: Set<String>, symbolLinks: [String: String]) -> String {
        return children.map({ $0.nestedSyntaxHighlightedHTML(internalIdentifiers: internalIdentifiers, symbolLinks: symbolLinks) }).joined()
    }

    // MARK: - TextOutputStreamable

    public func write<Target>(to target: inout Target) where Target : TextOutputStream {
        for child in children {
            child.write(to: &target)
        }
    }
}
