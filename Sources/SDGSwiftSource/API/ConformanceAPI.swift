/*
 ConformanceAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public struct ConformanceAPI : UndeclaredAPIElement {

    // MARK: - Initialization

    internal init(type: TypeSyntax) {
        self.type = type.normalized()
    }

    // MARK: - Properties

    internal let type: TypeSyntax

    // MARK: - APIElement

    public func summary() -> [String] {
        var result = genericName.source()
        if let constraints = self.constraints {
            result += constraints.source()
        }
        appendCompilationConditions(to: &result)
        return [result]
    }

    // MARK: - APIElementProtocol

    public internal(set) var constraints: GenericWhereClauseSyntax?
    public internal(set) var compilationConditions: Syntax?

    public func identifierList() -> Set<String> {
        return []
    }
}
