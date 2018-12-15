/*
 APIScope.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGCollections

public class APIScope {

    // MARK: - Initialization

    internal init() {
    }

    // MARK: - Properties

    public internal(set) var constraints: GenericWhereClauseSyntax?
    public internal(set) var compilationConditions: Syntax?

    // MARK: - APIElement

    private var _children: [APIElement] = []
    public var children: [APIElement] {
        get {
            return _children
        }
        set {
            _children = newValue.sorted()
        }
    }
}
