/*
 UniquelyDeclaredManifestAPIElement.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

internal protocol UniquelyDeclaredManifestAPIElement : UniquelyDeclaredAPIElement where Declaration == FunctionCallExprSyntax, Name == TokenSyntax {

}

extension UniquelyDeclaredManifestAPIElement {

    internal init(documentation: DocumentationSyntax?, declaration: Declaration) {
        self.init(documentation: documentation, alreadyNormalizedDeclaration: declaration, name: declaration.manifestEntryName(), children: [])
    }

    // MARK: - APIElementProtocol

    public func shallowIdentifierList() -> Set<String> {
        return []
    }
}
