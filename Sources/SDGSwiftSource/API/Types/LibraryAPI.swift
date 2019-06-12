/*
 LibraryAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGCollections
import SDGText
import SDGLocalization

import SwiftSyntax
import PackageModel

import SDGSwift
import SDGSwiftPackageManager

import SDGSwiftLocalizations

/// A library product of a package.
public final class LibraryAPI : _APIElementBase, _NonOverloadableAPIElement, SortableAPIElement, _UniquelyDeclaredManifestAPIElement {

    // MARK: - Initialization

    internal convenience init(product: Product, manifest: Syntax, reportProgress: (String) -> Void = SwiftCompiler._ignoreProgress) throws {
        let manifestDeclaration = manifest.smallestSubnode(containing: ".library(name: \u{22}\(product.name)\u{22}")?.parent
        self.init(
            documentation: manifestDeclaration?.documentation ?? [], // @exempt(from: tests)
            declaration: FunctionCallExprSyntax.normalizedLibraryDeclaration(name: product.name))

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

    internal init(
        documentation: [SymbolDocumentation],
        alreadyNormalizedDeclaration declaration: FunctionCallExprSyntax,
        constraints: GenericWhereClauseSyntax?,
        name: TokenSyntax,
        children: [APIElement]) {

        self.declaration = declaration
        self.name = name
        super.init(documentation: documentation)
        self.constraints = constraints
    }

    // MARK: - APIElementProtocol

    public func _summarySubentries() -> [String] {
        return modules.map({ $0.name.source() })
    }

    // MARK: - DeclaredAPIElement

    // #documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.declaration)
    /// The element’s declaration.
    public let declaration: FunctionCallExprSyntax
    // #documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.name)
    /// The element’s name.
    public let name: TokenSyntax
}
