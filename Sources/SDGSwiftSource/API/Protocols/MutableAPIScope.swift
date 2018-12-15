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

internal protocol MutableAPIScope : MutableAPIElement {
    var children: [APIElement] { get set }
}

extension MutableAPIScope {

    // MARK: - Merging

    internal func moveConditionsToChildren() {
        for child in children {
            child.genericElement.prependCompilationCondition(compilationConditions)
            // #workaround(SwiftSyntax 0.40200.0, Prevents invalid index use by SwiftSyntax.)
            if constraints?.source().isEmpty ≠ false {
                if child.constraints?.source().isEmpty ≠ false {
                    child.genericElement.constraints.merge(with: constraints)
                } else {
                    child.genericElement.constraints = constraints
                }
            }
        }
        compilationConditions = nil
        constraints = nil
    }

    internal func merge(extension: ExtensionAPI) {
        `extension`.moveConditionsToChildren()
        children.append(contentsOf: `extension`.children)
        children = FunctionAPI.groupIntoOverloads(children)
    }

    internal func merging(extension: ExtensionAPI) -> Self {
        return nonmutatingVariant(of: { $0.merge(extension: $1) }, on: self, with: `extension`)
    }
}
