/*
 GenericArgumentListSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension GenericArgumentListSyntax {

    internal func normalized() -> GenericArgumentListSyntax {
        var arguments = map({ $0.normalized(comma: true) })
        if ¬arguments.isEmpty {
            let last = arguments.removeLast()
            arguments.append(last.normalized(comma: false))
        }
        return SyntaxFactory.makeGenericArgumentList(arguments)
    }
}
