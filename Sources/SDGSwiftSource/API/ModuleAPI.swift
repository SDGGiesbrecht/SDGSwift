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

public class ModuleAPI : APIElement {

    /// Creates a module API instance by parsing the specified target’s sources.
    ///
    /// - Throws: Errors inherited from `Syntax.parse(_:)`.
    public init(module: PackageModel.Target) throws {
        _name = module.name.decomposedStringWithCanonicalMapping
        super.init()

        var api: [APIElement] = []
        for sourceFile in module.sources.paths.lazy.map({ URL(fileURLWithPath: $0.asString) }) {
            let source = try Syntax.parse(sourceFile)
            api += source.api()
        }
        api = APIElement.merge(elements: api)

        for element in api {
            switch element {
            case let type as TypeAPI :
                types.append(type)
            case let `protocol` as ProtocolAPI :
                protocols.append(`protocol`)
            case let `extension` as ExtensionAPI :
                `extensions`.append(`extension`)
            case let function as FunctionAPI :
                functions.append(function)
            case let globalVariable as VariableAPI :
                globalVariables.append(globalVariable)
            default:
                if BuildConfiguration.current == .debug { // @exempt(from: tests) Should never occur.
                    print("Unidentified API element: \(Swift.type(of: element))")
                }
            }
        }
    }

    // MARK: - Properties

    private let _name: String

    private var _types: [TypeAPI] = []
    private var types: [TypeAPI] {
        get {
            return _types
        }
        set {
            _types = newValue.sorted()
        }
    }

    private var _extensions: [ExtensionAPI] = []
    private var extensions: [ExtensionAPI] {
        get {
            return _extensions
        }
        set {
            _extensions = newValue.sorted()
        }
    }

    private var _protocols: [ProtocolAPI] = []
    private var protocols: [ProtocolAPI] {
        get {
            return _protocols
        }
        set {
            _protocols = newValue.sorted()
        }
    }

    private var _functions: [FunctionAPI] = []
    private var functions: [FunctionAPI] {
        get {
            return _functions
        }
        set {
            _functions = newValue.sorted()
        }
    }

    private var _globalVariables: [VariableAPI] = []
    private var globalVariables: [VariableAPI] {
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

    public override var name: String {
        return _name
    }

    internal override var identifiers: Set<String> {
        return children.map({ $0.identifiers }).reduce(into: Set([_name]), { $0 ∪= $1 })
    }

    public override var declaration: FunctionCallExprSyntax {
        return SyntaxFactory.makeFunctionCallExpr(
            calledExpression: SyntaxFactory.makeMemberAccessExpr(
                base: SyntaxFactory.makeBlankExpr(),
                dot: SyntaxFactory.makeToken(.period),
                name: SyntaxFactory.makeToken(.identifier("target"))),
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

    public override var summary: [String] {
        return [name + " • " + declaration.source()] + children.map({ $0.summary.map({ $0.prepending(" ") }) }).joined()
    }
}
