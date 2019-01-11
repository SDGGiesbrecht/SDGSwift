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
    #warning("This is O(n). Make it a method.")
    var isPublic: Bool { get }
    func isUnavailable() -> Bool
    var isHidden: Bool { get }
}

extension APISyntax {

    internal func isVisible() -> Bool {
        return isPublic ∧ ¬isUnavailable() ∧ ¬isHidden
    }
}
