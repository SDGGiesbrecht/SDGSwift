/*
 TokenListSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension TokenListSyntax {

    internal func normalizedForAPIAttribute() -> TokenListSyntax {
        return SyntaxFactory.makeTokenList(compactMap({ token in
            switch token.tokenKind {
            case .colon, .comma, .rightParen:
                return token.generallyNormalized(trailingTrivia: .spaces(1))
            default:
                return token.generallyNormalized()
            }
        }))
    }
}
