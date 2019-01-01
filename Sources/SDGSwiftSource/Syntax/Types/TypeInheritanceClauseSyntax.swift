/*
 TypeInheritanceClauseSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension TypeInheritanceClauseSyntax {

    internal var conformances: [ConformanceAPI] {
        var result: [ConformanceAPI] = []
        for inheritance in inheritedTypeCollection {
            result.append(ConformanceAPI(type: inheritance.typeName))
        }
        return result
    }
}
