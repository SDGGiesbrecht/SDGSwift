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
    /// - Throws: Errors inherited from `SyntaxTreeParser.parse(_:)`.
    public init(module: PackageModel.Target, manifest: Syntax?) throws {
        let name = module.name.decomposedStringWithCanonicalMapping
        _name = name

        var api: [APIElement] = []
        for sourceFile in module.sources.paths.lazy.map({ URL(fileURLWithPath: $0.asString) }) {
            try autoreleasepool { // @exempt(from: tests) False coverage result in Xcode 9.4.1.
                let source = try SyntaxTreeParser.parse(sourceFile)
                api += source.api()
            }
        }
        api = APIElement.merge(elements: api)

        let declaration = manifest?.smallestSubnode(containing: ".target(name: \u{22}\(name)\u{22}")?.parent
        super.init(documentation: declaration?.documentation)

        for element in api {
            switch element { // @exempt(from: tests) False coverage result in Xcode 9.4.1.
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

    public override var name: String {
        return _name
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

    public override var identifierList: Set<String> {
        return children.map({ $0.identifierList }).reduce(into: Set([_name]), { $0 ∪= $1 })
    }

    public override var summary: [String] {
        return [name + " • " + declaration.source()] + children.map({ $0.summary.map({ $0.prepending(" ") }) }).joined()
    }
}
