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

internal protocol APISyntax : Syntax {
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

    internal var shouldLookForChildren: Bool {
        return false
    }

    internal func parseAPI() -> [APIElement] {
        if ¬isVisible() {
            return []
        }

        let children = shouldLookForChildren ? apiChildren() : []
        return createAPI(children: children)
    }
}
