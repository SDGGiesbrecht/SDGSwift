/*
 TextFreedom.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// How much freedom the user has in choosing the text of the element.
public enum TextFreedom: Sendable {

  // MARK: - Cases

  /// The user can choose any arbitrary text, (but may still be subject to minor syntax restrictions).
  ///
  /// Examples include comments, documentation or declaration names.
  case arbitrary

  /// The user can rename the element using some form of alias.
  ///
  /// Examples include type references, function calls or variable uses.
  case aliasable

  /// The element is invariable.
  ///
  /// Examples include keywords, the braces around closures or the parentheses around function arguments.
  case invariable
}
