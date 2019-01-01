/*
 PackageAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections

import SDGSwift
import SDGSwiftPackageManager

public final class PackageAPI : _APIElementBase, NonOverloadableAPIElement, SortableAPIElement, UniquelyDeclaredManifestAPIElement {

    // MARK: - Initialization

    /// Creates a package API instance by parsing the specified package’s sources.
    ///
    /// - Throws: Errors inherited from `SyntaxTreeParser.parse(_:)`.
    public convenience init(package: PackageModel.Package, reportProgress: (String) -> Void = SwiftCompiler._ignoreProgress) throws {

        let manifestURL = URL(fileURLWithPath: package.manifest.path.asString)
        let manifest = try SyntaxTreeParser.parse(manifestURL)

        let node = (manifest.smallestSubnode(containing: "Package(\n    name: \u{22}\(package.name)\u{22}") ?? manifest.smallestSubnode(containing: "Package(name: \u{22}\(package.name)\u{22}"))
        let manifestDeclaration = node?.ancestors().first(where: { $0 is VariableDeclSyntax })

        let declaration = FunctionCallExprSyntax.normalizedPackageDeclaration(name: package.name)
        // #workaround(Swift 4.2.1, Using UniquelyDeclaredManifestAPIElement currently causes a segmentation fault.)
        // self.init(documentation: manifestDeclaration?.documentation, declaration: declaration)
        self.init(documentation: manifestDeclaration?.documentation, alreadyNormalizedDeclaration: declaration, constraints: nil, name: declaration.manifestEntryName(), children: [])

        for product in package.products where ¬product.name.hasPrefix("_") {
            switch product.type {
            case .library:
                children.append(.library(try LibraryAPI(product: product, manifest: manifest, reportProgress: reportProgress)))
            case .executable, .test:
                continue
            }
        }

        for library in libraries {
            for module in library.modules where ¬modules.contains(module) {
                children.append(.module(module))
            }
        }
    }

    internal init(documentation: DocumentationSyntax?, alreadyNormalizedDeclaration declaration: FunctionCallExprSyntax, constraints: GenericWhereClauseSyntax?, name: TokenSyntax, children: [APIElement]) {
        self.declaration = declaration
        self.name = name
        super.init(documentation: documentation)
        self.constraints = constraints
    }

    // MARK: - APIElementProtocol

    public func summarySubentries() -> [String] {
        var result = Array(libraries.lazy.map({ $0.summary() }).joined())
        result.append(contentsOf: modules.lazy.map({ $0.summary() }).joined())
        return result
    }

    // MARK: - DeclaredAPIElement

    public let declaration: FunctionCallExprSyntax

    public let name: TokenSyntax
}
