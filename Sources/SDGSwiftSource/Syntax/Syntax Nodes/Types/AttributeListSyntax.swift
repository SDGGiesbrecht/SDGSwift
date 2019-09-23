/*
 AttributeListSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

extension AttributeListSyntax {

    internal func indicatesAbsence() -> Bool {
        return contains(where: { $0.attributeIndicatesAbsence() })
    }

    internal func normalizedForAPIDeclaration() -> AttributeListSyntax? {
        let normalized = compactMap({ $0.normalizedAttributeForAPIDeclaration() }).sorted(by: AttributeSyntax.arrange)
        return normalized.isEmpty ? nil : SyntaxFactory.makeAttributeList(normalized)
    }
}
