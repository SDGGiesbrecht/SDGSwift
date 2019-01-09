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
            return children.last?.endPositionOffset ?? positionOffset
        }
    }
    internal func determinePositions() {
        var offset = 0
        determineNestedPositions(offset: &offset)
    }
    private func determineNestedPositions(offset: inout Int) {
        positionOffset = offset
        for child in children {
            child.determineNestedPositions(offset: &offset)
            if let token = child as? ExtendedTokenSyntax {
                offset = token.endPositionOffset
            }
        }
    }

    public var text: String {
        var result = ""
        write(to: &result)
        return result
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
