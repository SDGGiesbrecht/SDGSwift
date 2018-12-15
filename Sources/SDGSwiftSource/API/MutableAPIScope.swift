/*
 MutableAPIScope.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

internal protocol MutableAPIScope : APIScopeProtocol, MutableAPIElement {
    var children: [APIElement] { get set }
}

extension MutableAPIScope {

    // MARK: - Merging

    internal mutating func moveConditionsToChildren() {
        var result: [APIElement] = []
        for child in children {
            var mutable = child
            mutable.prependCompilationCondition(compilationConditions)
            mutable.constraints = child.constraints.merged(with: constraints)
            result.append(mutable)
        }
        compilationConditions = nil
        constraints = nil
        children = result
    }

    internal mutating func merge(extension: ExtensionAPI) {
        var `extension` = `extension`

        `extension`.moveConditionsToChildren()
        children.append(contentsOf: `extension`.children)
        children = FunctionAPI.groupIntoOverloads(children)
    }
}
