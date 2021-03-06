/*
 CalloutSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A documentation callout.
public class CalloutSyntax: ExtendedSyntax {  // @exempt(from: classFinality)

  // MARK: - Initialization

  internal required init(
    bullet: ExtendedTokenSyntax,
    indent: ExtendedTokenSyntax,
    name: ExtendedTokenSyntax,
    space: ExtendedTokenSyntax? = nil,
    parameterName: ExtendedTokenSyntax? = nil,
    colon: ExtendedTokenSyntax,
    contents: [ExtendedSyntax]
  ) {  // @exempt(from: tests)  Unreachable from tvOS.

    self.bullet = bullet
    self.indent = indent
    self.name = name
    self.space = space
    self.parameterName = parameterName
    self.colon = colon
    self.contents = contents

    var children: [ExtendedSyntax] = []
    children.append(bullet)
    children.append(indent)
    children.append(name)
    if let theSpace = space {
      children.append(theSpace)
    }
    if let parameter = parameterName {
      children.append(parameter)
    }
    children.append(colon)
    children.append(contentsOf: contents)

    super.init(children: children)
  }

  // MARK: - Properties

  /// The bullet.
  public let bullet: ExtendedTokenSyntax

  /// The indent after the bullet.
  public let indent: ExtendedTokenSyntax

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

  internal override
    var renderedHTMLAttributes: [String: String]
  {  // @exempt(from: tests)  Unreachable from tvOS.
    return ["class": "callout \(name.text.lowercased())"]
  }

  internal override
    var renderedHtmlElement: String?
  {  // @exempt(from: tests)  Unreachable from tvOS.
    return "div"
  }
}
