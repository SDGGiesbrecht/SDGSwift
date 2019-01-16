/*
 ModuleAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGCollections

import SDGSwiftPackageManager

public final class ModuleAPI : _APIElementBase, NonOverloadableAPIElement, SortableAPIElement, UniquelyDeclaredManifestAPIElement {

    /// Creates a module API instance by parsing the specified target’s sources.
    ///
    /// - Throws: Errors inherited from `SyntaxTreeParser.parse(_:)`.
    public convenience init(module: PackageModel.Target, manifest: Syntax?) throws {
        let manifestDeclaration = manifest?.smallestSubnode(containing: ".target(name: \u{22}\(module.name)\u{22}")?.parent
        try self.init(documentation: manifestDeclaration?.documentation, declaration: FunctionCallExprSyntax.normalizedModuleDeclaration(name: module.name), sources: module.sources.paths.lazy.map({ URL(fileURLWithPath: $0.asString) }))
    }

    public convenience init(documentation: DocumentationSyntax?, declaration: FunctionCallExprSyntax, sources: [URL]) throws {
        self.init(documentation: documentation, declaration: declaration)
        var api: [APIElement] = []
        for sourceFile in sources {
            try autoreleasepool {
                let source = try SyntaxTreeParser.parseAndRetry(sourceFile)
                api.append(contentsOf: source.api())
            }
        }
        apply(parsedElements: api)
    }
    internal convenience init(source: String) throws {
        self.init(documentation: nil, declaration: SyntaxFactory.makeBlankFunctionCallExpr())
        let syntax = try SyntaxTreeParser.parse(source)
        apply(parsedElements: syntax.api())
    }
    private func apply(parsedElements: [APIElement]) {
        children.append(contentsOf: APIElement.merge(elements: parsedElements))
    }

    internal init(documentation: DocumentationSyntax?, alreadyNormalizedDeclaration declaration: FunctionCallExprSyntax, constraints: GenericWhereClauseSyntax?, name: TokenSyntax, children: [APIElement]) {
        self.declaration = declaration
        self.name = name
        super.init(documentation: documentation)
        self.constraints = constraints
    }

    // MARK: - DeclaredAPIElement

    public let declaration: FunctionCallExprSyntax

    public let name: TokenSyntax
}
