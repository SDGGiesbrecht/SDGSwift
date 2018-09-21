/*
 SameTypeRequirementSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

internal protocol Member : Syntax {
    var modifiers: ModifierListSyntax? { get }
}

extension Member {
    internal var typeMemberKeyword: TokenKind? {
        guard let modifiers = self.modifiers else {
            return nil
        }
        for modifier in modifiers {
            let tokenKind = modifier.name.tokenKind
            if tokenKind == .staticKeyword ∨ tokenKind == .classKeyword {
                return tokenKind
            }
        }
        return nil
    }
}
