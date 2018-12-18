/*
 SyntaxChildren.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension SyntaxChildren {

    internal func first<T>(_ type: T.Type) -> T? {
        return first(where: { $0 is T }) as? T
    }

    internal func first(_ tokenKind: TokenKind) -> TokenSyntax? {
        return first(where: { ($0 as? TokenSyntax)?.tokenKind == tokenKind }) as? TokenSyntax
    }

    private func first(_ kindCheck: (TokenKind) -> Bool) -> TokenSyntax? {
        let found = first(where: { token in
            if let kind = (token as? TokenSyntax)?.tokenKind,
                kindCheck(kind) {
                return true
            } else {
                return false
            }
        })
        return found as? TokenSyntax
    }
    internal func firstIdentifier() -> TokenSyntax? {
        return first {
            if case .identifier = $0 {
                return true
            } else {
                return false
            }
        }
    }
}
