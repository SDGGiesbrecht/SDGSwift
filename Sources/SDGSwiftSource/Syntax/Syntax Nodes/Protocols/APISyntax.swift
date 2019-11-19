/*
 APISyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

import SwiftSyntax

internal protocol APISyntax: Syntax {
  func isPublic() -> Bool
  func isUnavailable() -> Bool
  var isHidden: Bool { get }
  var shouldLookForChildren: Bool { get }
  func createAPI(children: [APIElement]) -> [APIElement]
}

extension APISyntax {

  internal func isVisible() -> Bool {
    return isPublic() ∧ ¬isUnavailable() ∧ ¬isHidden
  }

  internal func parseAPI() -> [APIElement] {
    if ¬isVisible() ∨ (self as? OverridableDeclaration)?.isOverride() == true {
      return []
    }

    var children = shouldLookForChildren ? apiChildren() : []

    if let inheritor = self as? Inheritor,
      let conformances = inheritor.inheritanceClause?.conformances
    {
      children.append(contentsOf: conformances.lazy.map({ APIElement.conformance($0) }))
    }

    return createAPI(children: children)
  }
}
