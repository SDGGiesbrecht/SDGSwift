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

public final class PackageAPI : APIElementBase, UniquelyDeclaredManifestAPIElement {

    // MARK: - Initialization

    /// Creates a package API instance by parsing the specified package’s sources.
    ///
    /// - Throws: Errors inherited from `SyntaxTreeParser.parse(_:)`.
    public convenience init(package: PackageModel.Package, reportProgress: (String) -> Void = SwiftCompiler._ignoreProgress) throws {

        let manifestURL = URL(fileURLWithPath: package.manifest.path.asString)
        let manifest = try SyntaxTreeParser.parse(manifestURL)

        let node = (manifest.smallestSubnode(containing: "Package(\n    name: \u{22}\(package.name)\u{22}") ?? manifest.smallestSubnode(containing: "Package(name: \u{22}\(package.name)\u{22}"))
        let manifestDeclaration = node?.ancestors().first(where: { $0 is VariableDeclSyntax })

        // #workaround(Does not use UniquelyDeclaredManifestAPIElement yet.)
        let declaration = FunctionCallExprSyntax.normalizedPackageDeclaration(name: package.name)
        self.init(documentation: manifestDeclaration?.documentation, alreadyNormalizedDeclaration: declaration, name: declaration.manifestEntryName(), children: [])

        for product in package.products where ¬product.name.hasPrefix("_") {
            switch product.type {
            case .library:
                libraries.append(try LibraryAPI(product: product, manifest: manifest, reportProgress: reportProgress))
            case .executable, .test:
                continue
            }
        }

        for library in libraries {
            for module in library.modules where ¬modules.contains(module) {
                modules.append(module)
            }
        }
    }

    internal init(documentation: DocumentationSyntax?, alreadyNormalizedDeclaration declaration: FunctionCallExprSyntax, name: TokenSyntax, children: [APIElement]) {
        self.declaration = declaration
        self.name = name
        super.init(documentation: documentation)
    }

    // MARK: - Properties

    public internal(set) var libraries: [LibraryAPI] = []
    public internal(set) var modules: [ModuleAPI] = []

    // MARK: - APIElement

    public func summary() -> [String] {
        return [name.source() + " • " + declaration.source()]
            + libraries.map({ $0.summary().map({ $0.prepending(" ") }) }).joined()
            + modules.map({ $0.summary().map({ $0.prepending(" ") }) }).joined()
    }

    // MARK: - APIElementProtocol

    public internal(set) var constraints: GenericWhereClauseSyntax?
    public internal(set) var compilationConditions: Syntax?

    public func identifierList() -> Set<String> {
        return libraries.map({ $0.identifierList() }).reduce(into: Set<String>(), { $0 ∪= $1 })
    }

    // MARK: - DeclaredAPIElement

    public let declaration: FunctionCallExprSyntax

    public let name: TokenSyntax
}
