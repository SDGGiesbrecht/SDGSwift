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

public class ModuleAPI : APIElement, APIElementProtocol {

    /// Creates a module API instance by parsing the specified target’s sources.
    ///
    /// - Throws: Errors inherited from `SyntaxTreeParser.parse(_:)`.
    public init(module: PackageModel.Target, manifest: Syntax?) throws {
        _declaration = FunctionCallExprSyntax.normalizedModuleDeclaration(name: module.name)

        var api: [APIElementKind] = []
        for sourceFile in module.sources.paths.lazy.map({ URL(fileURLWithPath: $0.asString) }) {
            try autoreleasepool {
                let source = try SyntaxTreeParser.parse(sourceFile)
                api += source.api()
            }
        }
        api = APIElement.merge(elements: api)

        let declaration = manifest?.smallestSubnode(containing: ".target(name: \u{22}\(module.name)\u{22}")?.parent
        self.documentation = declaration?.documentation
        super.init()

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

    // MARK: - Properties

    private let _declaration: FunctionCallExprSyntax

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

    public override var children: AnyBidirectionalCollection<APIElement> {
        let joined = ([
            types,
            extensions,
            protocols,
            functions,
            globalVariables
            ] as [[APIElement]]).joined()
        return AnyBidirectionalCollection(joined)
    }

    // MARK: - APIElement

    public override var name: Syntax {
        return _declaration.moduleName()
    }

    public override var declaration: Syntax {
        return _declaration
    }

    public override var identifierList: Set<String> {
        return children.map({ $0.identifierList }).reduce(into: Set([name.source()]), { $0 ∪= $1 })
    }

    public override var summary: [String] {
        return [name.source() + " • " + declaration.source()] + children.map({ $0.summary.map({ $0.prepending(" ") }) }).joined()
    }

    // MARK: - APIElementProtocol

    public let documentation: DocumentationSyntax?
}
