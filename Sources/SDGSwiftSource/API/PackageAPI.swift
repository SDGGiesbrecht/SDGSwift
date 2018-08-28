/*
 PackageAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections

import SDGSwift
import SDGSwiftPackageManager

public class PackageAPI : APIElement {

    // MARK: - Initialization

    /// Creates a package API instance by parsing the specified package’s sources.
    ///
    /// - Throws: Errors inherited from `Syntax.parse(_:)`.
    public init(package: PackageModel.Package, reportProgress: (String) -> Void = SwiftCompiler._ignoreProgress) throws {
        _name = package.name.decomposedStringWithCanonicalMapping

        let manifestURL = URL(fileURLWithPath: package.manifest.path.asString)
        let manifest = try Syntax.parse(manifestURL)

        var libraries: [LibraryAPI] = []
        for product in package.products where ¬product.name.hasPrefix("_") {
            switch product.type {
            case .library:
                libraries.append(try LibraryAPI(product: product, manifest: manifest, reportProgress: reportProgress))
            case .executable, .test:
                continue
            }
        }
        self.libraries = libraries

        var modules: [ModuleAPI] = []
        for library in libraries {
            for module in library.modules where ¬modules.contains(module) {
                modules.append(module)
            }
        }
        self.modules = modules

        super.init()

        let declaration = manifest.smallestSubnode(containing: "Package(\n    name: \u{22}\(package.name)\u{22}")?.parent ?? manifest.smallestSubnode(containing: "Package(name: \u{22}\(package.name)\u{22}")
        documentation = declaration?.documentation
    }

    // MARK: - Properties

    private let _name: String

    public let libraries: [LibraryAPI]
    public let modules: [ModuleAPI]

    // MARK: - APIElement

    public override var name: String {
        return _name
    }

    public override var declaration: FunctionCallExprSyntax {
        return SyntaxFactory.makeFunctionCallExpr(
            calledExpression: SyntaxFactory.makeIdentifierExpr(
                identifier: SyntaxFactory.makeToken(.identifier("Package"))),
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
        return libraries.map({ $0.identifierList }).reduce(into: Set<String>(), { $0 ∪= $1 })
    }

    public override var summary: [String] {
        return [name + " • " + declaration.source()]
    }
}
