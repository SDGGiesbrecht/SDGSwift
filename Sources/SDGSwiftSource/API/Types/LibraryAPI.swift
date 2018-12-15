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

public final class LibraryAPI : UniquelyDeclaredManifestAPIElement {

    // MARK: - Initialization

    internal convenience init(product: Product, manifest: Syntax, reportProgress: (String) -> Void = SwiftCompiler._ignoreProgress) throws {
        let manifestDeclaration = manifest.smallestSubnode(containing: ".library(name: \u{22}\(product.name)\u{22}")?.parent
        self.init(documentation: manifestDeclaration?.documentation, declaration: FunctionCallExprSyntax.normalizedLibraryDeclaration(name: product.name))

        var modules: [ModuleAPI] = []
        for module in product.targets where ¬module.name.hasPrefix("_") {
            reportProgress(String(UserFacing<StrictString, InterfaceLocalization>({ localization in
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Parsing “" + StrictString(module.name) + "”..."
                }
            }).resolved()))
            modules.append(try ModuleAPI(module: module, manifest: manifest))
        }
        self.modules = modules
    }

    internal init(documentation: DocumentationSyntax?, alreadyNormalizedDeclaration declaration: FunctionCallExprSyntax, name: TokenSyntax, children: [APIElement]) {
        self.documentation = documentation
        self.declaration = declaration
        self.name = name
    }

    // MARK: - Properties

    public internal(set) var modules: [ModuleAPI] = []

    // MARK: - APIElement

    public func summary() -> [String] {
        return [name.source() + " • " + declaration.source()]
            + modules.map({ $0.name.source().prepending(" ") })
    }

    // MARK: - APIElementProtocol

    public let documentation: DocumentationSyntax?
    public internal(set) var constraints: GenericWhereClauseSyntax?
    public internal(set) var compilationConditions: Syntax?

    public func identifierList() -> Set<String> {
        return modules.map({ $0.identifierList() }).reduce(into: Set<String>(), { $0 ∪= $1 })
    }

    // MARK: - DeclaredAPIElement

    public let declaration: FunctionCallExprSyntax
    public let name: TokenSyntax
}
