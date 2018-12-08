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

public class LibraryAPI : APIElement, APIElementProtocol {

    // MARK: - Initialization

    internal init(product: Product, manifest: Syntax, reportProgress: (String) -> Void = SwiftCompiler._ignoreProgress) throws {
        _declaration = FunctionCallExprSyntax.normalizedLibraryDeclaration(name: product.name)

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

        let declaration = manifest.smallestSubnode(containing: ".library(name: \u{22}\(product.name)\u{22}")?.parent
        self.documentation = declaration?.documentation
        super.init()
    }

    // MARK: - Properties

    private let _declaration: FunctionCallExprSyntax

    public let modules: [ModuleAPI]

    // MARK: - APIElement

    public override var name: Syntax {
        return _declaration.libraryName()
    }

    public override var declaration: Syntax {
        return _declaration
    }

    public override var identifierList: Set<String> {
        return modules.map({ $0.identifierList }).reduce(into: Set<String>(), { $0 ∪= $1 })
    }

    public override var summary: [String] {
        return [name.source() + " • " + declaration.source()]
            + modules.map({ $0.name.source().prepending(" ") })
    }

    // MARK: - APIElementProtocol

    public let documentation: DocumentationSyntax?
}
