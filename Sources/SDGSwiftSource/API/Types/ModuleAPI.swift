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

/// A Swift module.
public final class ModuleAPI : _APIElementBase, _NonOverloadableAPIElement, SortableAPIElement, _UniquelyDeclaredManifestAPIElement {

    /// Creates a module API instance by parsing the specified target’s sources.
    ///
    /// - Parameters:
    ///     - module: The module target.
    ///     - manifest: The syntax of the package manifest.
    public convenience init(module: PackageModel.Target, manifest: Syntax?) throws {
        let manifestDeclaration = manifest?.smallestSubnode(containing: ".target(name: \u{22}\(module.name)\u{22}")?.parent
        try self.init(documentation: manifestDeclaration?.documentation, declaration: FunctionCallExprSyntax.normalizedModuleDeclaration(name: module.name), sources: module.sources.paths.lazy.map({ URL(fileURLWithPath: $0.pathString) }))
    }

    /// Creates a module API instance by parsing the specified source files.
    ///
    /// - Parameters:
    ///     - documentation: The documentation for the module.
    ///     - declaration: The module’s declaration from the package manifest.
    /// 	- sources: The source files.
    public convenience init(documentation: DocumentationSyntax?, declaration: FunctionCallExprSyntax, sources: [URL]) throws {
        self.init(documentation: documentation, declaration: declaration)
        var api: [APIElement] = []
        for sourceFile in sources.filter({ $0.pathExtension == "swift" }).sorted() {
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

    // #documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.declaration)
    /// The element’s declaration.
    public let declaration: FunctionCallExprSyntax
    // #documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.name)
    /// The element’s name.
    public let name: TokenSyntax
}
