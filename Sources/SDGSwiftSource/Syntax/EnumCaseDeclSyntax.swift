/*
 EnumCaseDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension EnumCaseDeclSyntax {

    var caseAPI: CaseAPI? {
        guard let element = elements.first else {
            return nil
        }

        let name = element.identifier.text
        if name.hasPrefix("_") {
            return nil
        }
        return CaseAPI(
            documentation: documentation,
            name: name,
            associatedValues: element.associatedValue?.parameterList.compactMap({ $0.type?.reference }) ?? [])
    }
}
