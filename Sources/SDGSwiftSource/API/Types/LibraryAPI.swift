/*
 LibraryAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGCollections

import SDGSwift
import SDGSwiftPackageManager

import SDGSwiftLocalizations

public final class LibraryAPI : _APIElementBase, NonOverloadableAPIElement, SortableAPIElement, UniquelyDeclaredManifestAPIElement {

    // MARK: - Initialization

    internal convenience init(product: Product, manifest: Syntax, reportProgress: (String) -> Void = SwiftCompiler._ignoreProgress) throws {
        let manifestDeclaration = manifest.smallestSubnode(containing: ".library(name: \u{22}\(product.name)\u{22}")?.parent
        self.init(documentation: manifestDeclaration?.documentation, declaration: FunctionCallExprSyntax.normalizedLibraryDeclaration(name: product.name))

        for module in product.targets where ¬module.name.hasPrefix("_") {
            reportProgress(String(UserFacing<StrictString, InterfaceLocalization>({ localization in
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Parsing “" + StrictString(module.name) + "”..."
                }
            }).resolved()))
            children.append(.module(try ModuleAPI(module: module, manifest: manifest)))
        }
    }

    internal init(documentation: DocumentationSyntax?, alreadyNormalizedDeclaration declaration: FunctionCallExprSyntax, name: TokenSyntax, children: [APIElement]) {
        self.declaration = declaration
        self.name = name
        super.init(documentation: documentation)
    }

    // MARK: - APIElementProtocol

    public func summarySubentries() -> [String] {
        return modules.map({ $0.name.source() })
    }

    // MARK: - DeclaredAPIElement

    public let declaration: FunctionCallExprSyntax
    public let name: TokenSyntax
}
