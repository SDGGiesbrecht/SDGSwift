/*
 FunctionDeclaration.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A function declaration.
public class FunctionDeclaration : ContainerSyntaxElement {

    internal init(substructureInformation: SourceKit.Variant, source: String, tokens: [SourceKit.PrimitiveToken]) throws {
        try super.init(substructureInformation: substructureInformation, source: source, tokens: tokens)
    }
}
