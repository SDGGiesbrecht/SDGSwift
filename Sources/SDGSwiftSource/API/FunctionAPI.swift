/*
 FunctionAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections

public class FunctionAPI : UniquelyDeclaredAPIElement {

    // MARK: - Initialization

    internal init(documentation: DocumentationSyntax?, declaration: FunctionDeclSyntax) {
        self.documentation = documentation
        let (normalizedDeclaration, normalizedConstraints) = declaration.normalizedAPIDeclaration()
        _declaration = normalizedDeclaration
        name = normalizedDeclaration.name()
        constraints = constraints.merged(with: normalizedConstraints)
    }

    // MARK: - Properties

    internal let _declaration: FunctionDeclSyntax

    internal var isProtocolRequirement: Bool = false
    internal var hasDefaultImplementation: Bool = false
    private var _overloads: [FunctionAPI] = []
    internal var overloads: [FunctionAPI] {
        get {
            return _overloads
        }
        set {
            var new = newValue.sorted()
            if isProtocolRequirement {
                for index in new.indices {
                    let overload = new[index]
                    if overload.declaration.source() == declaration.source() {
                        hasDefaultImplementation = true
                        new.remove(at: index)
                        break
                    }
                }
            }
            _overloads = new
        }
    }

    // MARK: - Combining

    internal static func groupIntoOverloads(_ functions: [FunctionAPI]) -> [FunctionAPI] {
        var sorted: [String: [FunctionAPI]] = [:]

        for function in functions {
            sorted[function._declaration.overloadPattern().source(), default: []].append(function)
        }

        var result: [FunctionAPI] = []
        for (_, group) in sorted {
            var merged: FunctionAPI?
            for function in group.sorted() {
                if let existing = merged {
                    existing.overloads.append(function)
                } else {
                    merged = function
                }
            }
            result.append(merged!)
        }

        return result
    }

    internal static func groupIntoOverloads(_ elements: [APIElement]) -> [APIElement] {
        var functions: [FunctionAPI] = []
        var result: [APIElement] = []
        result.reserveCapacity(elements.count)
        for element in elements {
            switch element {
            case .function(let function):
                functions.append(function)
            default:
                result.append(element)
            }
        }
        functions = FunctionAPI.groupIntoOverloads(functions)
        result.append(contentsOf: functions.lazy.map({ APIElement.function($0) }))
        return result
    }

    // MARK: - APIElement

    public func summary() -> [String] {
        var result = ""
        if isProtocolRequirement {
            if hasDefaultImplementation {
                result += "(customizable) "
            } else {
                result += "(required) "
            }
        }
        result += name.source() + " • " + declaration.source()
        appendCompilationConditions(to: &result)
        var resultSummary = [result]
        for overload in overloads {
            var declaration = overload.declaration.source()
            overload.appendCompilationConditions(to: &declaration)
            resultSummary.append(declaration.prepending(" "))
        }
        return resultSummary
    }

    // MARK: - APIElementProtocol

    public let documentation: DocumentationSyntax?
    public internal(set) var constraints: GenericWhereClauseSyntax?
    public internal(set) var compilationConditions: Syntax?

    public func identifierList() -> Set<String> {
        return _declaration.identifierList()
    }

    // MARK: - DeclaredAPIElement

    public var declaration: FunctionDeclSyntax {
        return _declaration.withGenericWhereClause(constraints)
    }

    public let name: FunctionDeclSyntax
}
