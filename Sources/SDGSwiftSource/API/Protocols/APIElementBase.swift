/*
 APIElementBase.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

public class _APIElementBase {

    // MARK: - Initialization

    internal init(documentation: DocumentationSyntax?, constraints: GenericWhereClauseSyntax? = nil, compilationConditions: Syntax? = nil, children: [APIElement] = []) {
        self.documentation = documentation
        self.compilationConditions = compilationConditions
        self.constraints = constraints
        self.children = children
    }

    // MARK: - Properties

    public let documentation: DocumentationSyntax?

    private var _constraints: GenericWhereClauseSyntax? = nil
    public internal(set) var constraints: GenericWhereClauseSyntax? {
        get {
            return _constraints
        } set {
            _constraints = newValue?.normalized()
        }
    }

    public internal(set) var compilationConditions: Syntax? = nil

    private var _children: [APIElement] = []
    public internal(set) var children: [APIElement] {
        get {
            return _children
        } set {
            _children = newValue.sorted()
        }
    }

    // MARK: - Merging

    internal func moveConditionsToChildren() {
        for child in children {
            child.elementBase.compilationConditions.prependCompilationConditions(compilationConditions)
            // #workaround(SwiftSyntax 0.40200.0, Prevents invalid index use by SwiftSyntax.)
            if constraints?.source().isEmpty ≠ false {
                if child.constraints?.source().isEmpty ≠ false {
                    child.elementBase.constraints.merge(with: constraints)
                } else {
                    child.elementBase.constraints = constraints
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
}
