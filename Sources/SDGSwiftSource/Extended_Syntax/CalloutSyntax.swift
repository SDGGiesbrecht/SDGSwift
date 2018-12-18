/*
 CalloutSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public class CalloutSyntax : ExtendedSyntax {

    // MARK: - Initialization

    internal required init(
        bullet: ExtendedTokenSyntax?,
        indent: ExtendedTokenSyntax?,
        name: ExtendedTokenSyntax,
        space: ExtendedTokenSyntax?,
        parameterName: ExtendedTokenSyntax?,
        colon: ExtendedTokenSyntax,
        contents: [ExtendedSyntax]) {

        self.bullet = bullet
        self.indent = indent
        self.name = name
        self.space = space
        self.parameterName = parameterName
        self.colon = colon
        self.contents = contents

        var children: [ExtendedSyntax] = []
        if let theBullet = bullet {
            children.append(theBullet) // @exempt(from: tests) False coverage result in Xcode 9.4.1)
        }
        if let theIndent = indent {
            children.append(theIndent) // @exempt(from: tests) False coverage result in Xcode 9.4.1)
        }
        children.append(name)
        if let theSpace = space {
            children.append(theSpace) // @exempt(from: tests) False coverage result in Xcode 9.4.1)
        }
        if let parameter = parameterName {
            children.append(parameter) // @exempt(from: tests) False coverage result in Xcode 9.4.1)
        }
        children.append(colon)
        children.append(contentsOf: contents)

        super.init(children: children)
    }

    // MARK: - Properties

    /// The bullet.
    public let bullet: ExtendedTokenSyntax?

    /// The indent after the bullet.
    public let indent: ExtendedTokenSyntax?

    /// The callout name.
    public let name: ExtendedTokenSyntax

    /// The space before the parameter name.
    public let space: ExtendedTokenSyntax?

    /// The parameter name.
    public let parameterName: ExtendedTokenSyntax?

    /// The colon after the name.
    public let colon: ExtendedTokenSyntax

    /// The contents of the callout.
    public let contents: [ExtendedSyntax]

    // MARK: - ExtendedSyntax

    internal override var renderedHTMLAttributes: [String: String] {
        return ["class": "callout \(name.text.lowercased())"]
    }

    internal override var renderedHtmlElement: String? {
        return "div"
    }
}
