/*
 SyntaxCollection.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

extension SyntaxCollection {

  /// Returns whether the collection is empty.
  public var isEmpty: Bool {
    return first == nil
  }

  /// Returns the first element of the collection.
  public var first: Element? {
    return first(where: { _ in true })
  }
}
