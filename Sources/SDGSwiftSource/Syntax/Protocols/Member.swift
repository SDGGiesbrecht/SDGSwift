/*
 Member.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

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
            return nil // @exempt(from: tests) SwiftSyntax seems to prefer empty over nil.
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
