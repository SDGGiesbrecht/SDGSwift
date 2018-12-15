/*
 MutableAPIScope.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic

internal protocol MutableAPIScope : APIElementProtocol {
    var children: [APIElement] { get set }
}

extension MutableAPIScope {

    // MARK: - Merging

    internal func merge(extension: ExtensionAPI) {
        `extension`.moveConditionsToChildren()
        children.append(contentsOf: `extension`.children)
        children = FunctionAPI.groupIntoOverloads(children)
    }

    internal func merging(extension: ExtensionAPI) -> Self {
        return nonmutatingVariant(of: { $0.merge(extension: $1) }, on: self, with: `extension`)
    }
}
