/*
 ConformanceAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public final class ConformanceAPI : _UndeclaredAPIElementBase, SortableAPIElement, UndeclaredAPIElementProtocol {

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

    public func identifierList() -> Set<String> {
        return []
    }
}
