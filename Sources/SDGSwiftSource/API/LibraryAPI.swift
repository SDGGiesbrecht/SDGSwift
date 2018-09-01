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

public class LibraryAPI : APIElement {

    // MARK: - Initialization

    internal init(product: Product, manifest: Syntax, reportProgress: (String) -> Void = SwiftCompiler._ignoreProgress) throws {
        let name = product.name.decomposedStringWithCanonicalMapping
        _name = name

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

        let declaration = manifest.smallestSubnode(containing: ".library(name: \u{22}\(name)\u{22}")?.parent
        super.init(documentation: declaration?.documentation)
    }

    // MARK: - Properties

    private let _name: String

    public let modules: [ModuleAPI]

    // MARK: - APIElement

    public override var name: String {
        return _name
    }

    public override var declaration: FunctionCallExprSyntax {
        return SyntaxFactory.makeFunctionCallExpr(
            calledExpression: SyntaxFactory.makeMemberAccessExpr(
                base: SyntaxFactory.makeBlankExpr(),
                dot: SyntaxFactory.makeToken(.period),
                name: SyntaxFactory.makeToken(.identifier("library"))),
            leftParen: SyntaxFactory.makeToken(.leftParen),
            argumentList: SyntaxFactory.makeFunctionCallArgumentList([
                SyntaxFactory.makeFunctionCallArgument(
                    label: SyntaxFactory.makeToken(.identifier("name")),
                    colon: SyntaxFactory.makeToken(.colon, trailingTrivia: .spaces(1)),
                    expression: SyntaxFactory.makeStringLiteralExpr(name),
                    trailingComma: nil)
                ]),
            rightParen: SyntaxFactory.makeToken(.rightParen))
    }

    public override var identifierList: Set<String> {
        return modules.map({ $0.identifierList }).reduce(into: Set<String>(), { $0 ∪= $1 })
    }

    public override var summary: [String] {
        return [name + " • " + declaration.source()]
            + modules.map({ $0.name.prepending(" ") })
    }
}
