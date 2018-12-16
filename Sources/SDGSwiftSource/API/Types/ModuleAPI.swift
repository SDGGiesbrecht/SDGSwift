/*
 ModuleAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

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
        self.init(documentation: manifestDeclaration?.documentation, declaration: FunctionCallExprSyntax.normalizedModuleDeclaration(name: module.name))

        var api: [APIElement] = []
        for sourceFile in module.sources.paths.lazy.map({ URL(fileURLWithPath: $0.asString) }) {
            try autoreleasepool {
                let source = try SyntaxTreeParser.parse(sourceFile)
                api += source.api()
            }
        }
        api = APIElement.merge(elements: api)

        for element in api {
            switch element {
            case .type(let type):
                types.append(type)
            case .protocol(let `protocol`):
                protocols.append(`protocol`)
            case .extension(let `extension`):
                `extensions`.append(`extension`)
            case .function(let function):
                functions.append(function)
            case .variable(let globalVariable):
                globalVariables.append(globalVariable)
            case .package, .library, .module, .case, .initializer, .subscript, .conformance: // @exempt(from: tests) Invalid in global scope.
                break
            }
        }
    }

    internal init(documentation: DocumentationSyntax?, alreadyNormalizedDeclaration declaration: FunctionCallExprSyntax, name: TokenSyntax, children: [APIElement]) {
        self.declaration = declaration
        self.name = name
        super.init(documentation: documentation)
    }

    // MARK: - Properties

    private var _types: [TypeAPI] = []
    public var types: [TypeAPI] {
        get {
            return _types
        }
        set {
            _types = newValue.sorted()
        }
    }

    private var _extensions: [ExtensionAPI] = []
    public var extensions: [ExtensionAPI] {
        get {
            return _extensions
        }
        set {
            _extensions = newValue.sorted()
        }
    }

    private var _protocols: [ProtocolAPI] = []
    public var protocols: [ProtocolAPI] {
        get {
            return _protocols
        }
        set {
            _protocols = newValue.sorted()
        }
    }

    private var _functions: [FunctionAPI] = []
    public var functions: [FunctionAPI] {
        get {
            return _functions
        }
        set {
            _functions = newValue.sorted()
        }
    }

    private var _globalVariables: [VariableAPI] = []
    public var globalVariables: [VariableAPI] {
        get {
            return _globalVariables
        }
        set {
            _globalVariables = newValue.sorted()
        }
    }

    public var symbols: [APIElement] {
        let joined = [
            types.map({ APIElement.type($0) }),
            extensions.map({ APIElement.extension($0) }),
            protocols.map({ APIElement.protocol($0) }),
            functions.map({ APIElement.function($0) }),
            globalVariables.map({ APIElement.variable($0) })
            ].joined()
        return Array(joined)
    }

    // MARK: - APIElement

    public func summary() -> [String] {
        return [name.source() + " • " + declaration.source()] + symbols.map({ $0.summary().map({ $0.prepending(" ") }) }).joined()
    }

    // MARK: - APIElementProtocol

    public func shallowIdentifierList() -> Set<String> {
        return symbols.map({ $0.identifierList() }).reduce(into: Set([name.source()]), { $0 ∪= $1 })
    }

    // MARK: - DeclaredAPIElement

    public let declaration: FunctionCallExprSyntax

    public let name: TokenSyntax
}
