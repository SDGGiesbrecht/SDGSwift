/*
 LineCommentSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

public class LineCommentSyntax : ExtendedSyntax {

    // MARK: - Class Properties

    internal class var delimiter: ExtendedTokenSyntax {
        primitiveMethod()
    }

    internal class func parse(contents: String) -> ExtendedSyntax {
        primitiveMethod()
    }

    // MARK: - Initialization

    internal init(source: String) {
        let delimiter = type(of: self).delimiter

        var line = source
        line.removeFirst(delimiter.text.count)
        self.delimiter = delimiter
        var children: [ExtendedSyntax] = [delimiter]

        if line.first == " " {
            line.removeFirst()
            let indent = ExtendedTokenSyntax(text: " ", kind: .whitespace)
            self.indent = indent
            children.append(indent)
        } else {
            self.indent = nil
        }

        let content = type(of: self).parse(contents: line)
        _content = content
        children.append(content)

        super.init(children: children)
    }

    // MARK: - Properties

    /// The delimiter.
    public let delimiter: ExtendedTokenSyntax

    /// The intent.
    public let indent: ExtendedTokenSyntax?

    internal var _content: ExtendedSyntax
}
