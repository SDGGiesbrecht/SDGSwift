/*
 DocumentationParameterList.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A parameter list in symbol documentation.
public class DocumentationParameterList : DocumentationCallout {

    internal init(callout: DocumentationCallout, parameters: [DocumentationListElement], in source: String) {
        var parameterList: [DocumentationParameterListEntry] = []
        for parameter in parameters {
            if let parsed = DocumentationParameterListEntry(entry: parameter, in: source) { // [_Exempt from Test Coverage_] False result in Xcode 9.3.
                parameterList.append(parsed)
            }
        }
        self.parameters = parameterList
        super.init(bullet: callout.bullet, callout: callout.callout, colon: callout.colon, end: parameterList.last?.range.upperBound ?? callout.range.upperBound, in: source, knownChildren: parameterList) // [_Exempt from Test Coverage_] After ?? would require invalid syntax.
    }

    // MARK: - Properties

    /// The individual parameters.
    public let parameters: [DocumentationParameterListEntry]
}
