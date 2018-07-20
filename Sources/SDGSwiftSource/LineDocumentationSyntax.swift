/*
 LineDocumentationSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public class LineDocumentationSyntax : LineCommentSyntax {

    // MARK: - Class Properties

    internal override class var delimiter: ExtendedTokenSyntax {
        return ExtendedTokenSyntax(text: "///", kind: .lineDocumentationDelimiter)
    }

    internal override class func parse(contents: String) -> ExtendedSyntax {
        return DocumentationSyntax.parse(source: contents)
    }

    // MARK: - Properties

    // @documentation(SDGSwiftSource.LineDeveloperCommentSyntax.content)
    /// The content.
    public var content: ExtendedTokenSyntax {
        return _content as! ExtendedTokenSyntax
    }
}
