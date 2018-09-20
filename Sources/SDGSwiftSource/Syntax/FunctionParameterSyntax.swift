/*
 FunctionParameterSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension FunctionParameterSyntax {

    internal func parameterAPI(forSubscript: Bool) -> ParameterAPI {
        var label: String?
        if let possibleLabel = firstName,
            possibleLabel.tokenKind ≠ .wildcardKeyword {
            label = possibleLabel.text
        }
        var name: String
        if let different = secondName?.text {
            name = different
        } else {
            name = firstName?.text ?? "" // Guaranteed in valid source.
            if forSubscript {
                label = nil
            }
        }
        return ParameterAPI(
            label: label,
            name: name,
            isInOut: self.attributes?.contains(where: { $0.attributeName.tokenKind == .inoutKeyword }) == true,
            type: self.type?.reference ?? TypeReferenceAPI(name: "", genericArguments: []), // Guaranteed in valid source.
            hasDefault: defaultArgument ≠ nil)
    }
}
