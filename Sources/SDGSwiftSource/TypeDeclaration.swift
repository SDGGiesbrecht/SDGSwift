/*
 TypeDeclaration.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type declaration.
public class TypeDeclaration : ContainerSyntaxElement {

    internal init(substructureInformation: SourceKit.Variant, in source: String) throws {
        name = Identifier(range: try SyntaxElement.range(from: substructureInformation, for: "key.name", in: source))
        try super.init(substructureInformation: substructureInformation, in: source, knownChildren: [name])

        // [_Warning: Temporary._]
        print(try substructureInformation.asDictionary().keys)
    }

    // MARK: - Properties

    let name: Identifier
}
