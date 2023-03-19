/*
 ExtendedSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A syntax node.
///
/// This type is comparable to `Syntax`, but represents syntax not handled by the `SwiftSyntax` module.
public protocol ExtendedSyntax: TextOutputStreamable {

  /// The children of the node.
  var children: [ExtendedSyntax] { get }
}

extension ExtendedSyntax {

  /// The node’s source text.
  public var text: String {
    var result = ""
    write(to: &result)
    return result
  }

  // MARK: - TextOutputStreamable

  public func write<Target>(
    to target: inout Target
  ) where Target: TextOutputStream {
    for child in children {
      child.write(to: &target)
    }
  }
}
