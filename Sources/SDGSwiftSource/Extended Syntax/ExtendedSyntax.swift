/*
 ExtendedSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// A syntax node.
///
/// This type is comparable to `Syntax`, but represents syntax not handled by the `SwiftSyntax` module.
public class ExtendedSyntax : TextOutputStreamable {

    internal init(children: [ExtendedSyntax]) { // @exempt(from: tests) False coverage result in Xcode 9.4.1.
        self.children = children
    }

    // MARK: - Properties

    /// The children of this node.
    public internal(set) var children: [ExtendedSyntax]

    public var text: String {
        var result = ""
        write(to: &result)
        return result
    }

    // MARK: - Syntax Colouring

    public func syntaxColouredHTML() -> String {
        var result = ""
        for child in children {
            result.append(contentsOf: child.syntaxColouredHTML())
        }
        return result
    }

    // MARK: - Rendering

    internal var renderedHtmlElement: String? {
        return nil
    }

    internal var renderedHTMLAttributes: [String: String] {
        return [:]
    }

    public func renderedHTML() -> String {
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
            result.append(contentsOf: child.renderedHTML())
        }
        if let element = renderedHtmlElement {
            result.append(contentsOf: "</" + element + ">")
        }
        return result
    }

    public func syntaxHighlightedHTML(inline: Bool, internalIdentifiers: Set<String> = []) -> String {
        return Syntax.wrap(syntaxHighlighting: nestedSyntaxHighlightedHTML(inline: inline, internalIdentifiers: internalIdentifiers), inline: inline)
    }

    internal func nestedSyntaxHighlightedHTML(inline: Bool, internalIdentifiers: Set<String>) -> String {
        return children.map({ $0.nestedSyntaxHighlightedHTML(inline: inline, internalIdentifiers: internalIdentifiers) }).joined()
    }

    // MARK: - TextOutputStreamable

    public func write<Target>(to target: inout Target) where Target : TextOutputStream {
        for child in children {
            child.write(to: &target)
        }
    }
}
