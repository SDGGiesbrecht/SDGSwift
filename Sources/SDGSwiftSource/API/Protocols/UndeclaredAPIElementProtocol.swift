/*
 UndeclaredAPIElementProtocol.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

internal protocol UndeclaredAPIElementProtocol : NonOverloadableAPIElement, SortableAPIElement {
    var type: TypeSyntax { get }
}

extension UndeclaredAPIElementProtocol {

    public var possibleDeclaration: Syntax? {
        return nil
    }

    public var genericName: Syntax {
        return type
    }

    // MARK: - APIElementProtocol

    public func _shallowIdentifierList() -> Set<String> {
        return []
    }
}
