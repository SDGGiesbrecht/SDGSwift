/*
 APIElement.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGLocalization

public class APIElement : Comparable, Hashable {

    // MARK: - Static Methods

    internal static func merge(elements: [APIElement]) -> [APIElement] {

        var extensions: [ExtensionAPI] = []
        var functions: [FunctionAPI] = []
        var types: [TypeAPI] = []
        var protocols: [ProtocolAPI] = []
        var other: [APIElement] = []
        for element in elements {
            switch element {
            case let `extension` as ExtensionAPI :
                extensions.append(`extension`)
            case let type as TypeAPI :
                types.append(type)
            case let `protocol` as ProtocolAPI :
                protocols.append(`protocol`)
            case let function as FunctionAPI :
                functions.append(function)
            default:
                other.append(element)
            }
        }

        var unmergedExtensions: [ExtensionAPI] = []
        extensionIteration: for `extension` in extensions {
            let extensionType = `extension`.type
            for type in types where extensionType == type.typeName {
                type.merge(extension: `extension`)
                continue extensionIteration
            }
            for `protocol` in protocols where extensionType.declaration.source() == `protocol`.name {
                `protocol`.merge(extension: `extension`)
                continue extensionIteration
            }
            `extension`.moveConditionsToChildren()
            unmergedExtensions.append(`extension`)
        }
        other.append(contentsOf: ExtensionAPI.combine(extensions: unmergedExtensions))

        functions = FunctionAPI.groupIntoOverloads(functions)

        return types as [APIElement] + protocols as [APIElement] + functions as [APIElement] + other
    }

    // MARK: - Properties

    public var name: String {
        primitiveMethod()
    }

    public var declaration: Syntax? {
        primitiveMethod()
    }

    internal var identifiers: Set<String> {
        return []
    }

    private var _constraints: [ConstraintAPI] = []
    public internal(set) var constraints: [ConstraintAPI] {
        get {
            return _constraints
        }
        set {
            _constraints = newValue.map({ $0.normalized() }).sorted()
        }
    }
    public internal(set) var compilationConditions: String?

    public internal(set) var documentation: DocumentationSyntax?

    public var children: AnyBidirectionalCollection<APIElement> {
        return AnyBidirectionalCollection([])
    }

    public var summary: [String] {
        primitiveMethod()
    }

    // MARK: - Description

    internal func constraintSyntax() -> GenericWhereClauseSyntax? {
        guard ¬constraints.isEmpty else {
            return nil
        }

        var syntaxElements: [Syntax] = []
        for index in constraints.indices {
            let constraint = constraints[index]
            syntaxElements.append(constraint.syntax(trailingComma: index ≠ constraints.index(before: constraints.endIndex)))
        }

        return SyntaxFactory.makeGenericWhereClause(
            whereKeyword: SyntaxFactory.makeToken(.whereKeyword, leadingTrivia: .spaces(1), trailingTrivia: .spaces(1)),
            requirementList: SyntaxFactory.makeGenericRequirementList(syntaxElements))
    }

    internal func appendCompilationConditions(to description: inout String) {
        if let conditions = compilationConditions {
            description += " • " + conditions
        }
    }

    // MARK: - Comparable

    public static func < (precedingValue: APIElement, followingValue: APIElement) -> Bool {
        // #workaround(Swift 4.1.2, Order differs between operating systems.)
        if precedingValue.name == followingValue.name {
            return (precedingValue.declaration?.source() ?? "").scalars.lexicographicallyPrecedes((followingValue.declaration?.source() ?? "").scalars) // @exempt(from: tests) Empty declarations should never occur.
        } else {
            return precedingValue.name.scalars.lexicographicallyPrecedes(followingValue.name.scalars)
        }
    }

    // MARK: - Equatable

    public static func == (precedingValue: APIElement, followingValue: APIElement) -> Bool { // @exempt(from: tests) Apparently not actually used by the sorting algorithm.
        return (precedingValue.name, precedingValue.declaration?.source()) == (followingValue.name, followingValue.declaration?.source())
    }

    // MARK: - Hashable

    public var hashValue: Int {
        return declaration?.source().hashValue ?? name.hashValue // @exempt(from: tests) Fallback is theoretically unreachable.
    }
}
