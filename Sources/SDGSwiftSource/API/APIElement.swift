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

    // MARK: - Initialization

    internal init(documentation: DocumentationSyntax?) {
        self.documentation = documentation
    }

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
            for type in types where `extension`.isExtension(of: type) {
                type.merge(extension: `extension`)
                continue extensionIteration
            }
            for `protocol` in protocols where `extension`.isExtension(of: `protocol`) {
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

    public var identifierList: Set<String> {
        return []
    }

    public internal(set) var constraints: GenericWhereClauseSyntax?
    public internal(set) var compilationConditions: Syntax?

    public let documentation: DocumentationSyntax?

    public var children: AnyBidirectionalCollection<APIElement> {
        return AnyBidirectionalCollection([])
    }

    public var summary: [String] {
        primitiveMethod()
    }

    /// Arbitrary storage for use by client modules which need to associate other values to APIElement instances.
    ///
    /// This property is never used by anything in `SDGSwift` and will always be `nil` unless a client module sets it to something else.
    public var userInformation: Any?

    // MARK: - Description

    internal func appendCompilationConditions(to description: inout String) {
        if let conditions = compilationConditions {
            description += " • " + conditions.source()
        }
    }

    internal func prependCompilationCondition(_ addition: Syntax?) {
        if let new = addition {
            if let existing = compilationConditions {
                let existingCondition = Array(existing.tokens().dropFirst())
                let newCondition = Array(new.tokens().dropFirst())
                compilationConditions = SyntaxFactory.makeUnknownSyntax(tokens: [
                    SyntaxFactory.makeToken(.poundIfKeyword, trailingTrivia: .spaces(1)),
                    SyntaxFactory.makeToken(.leftParen)
                    ] + newCondition + [
                        SyntaxFactory.makeToken(.rightParen),
                        SyntaxFactory.makeToken(.spacedBinaryOperator("\u{26}&"), leadingTrivia: .spaces(1), trailingTrivia: .spaces(1)),
                        SyntaxFactory.makeToken(.leftParen)
                    ] + existingCondition + [
                        SyntaxFactory.makeToken(.rightParen)
                    ])
            } else {
                compilationConditions = new
            }
        }
    }

    // MARK: - Comparable

    public static func < (precedingValue: APIElement, followingValue: APIElement) -> Bool {
        if precedingValue.name == followingValue.name {
            return (precedingValue.declaration?.source() ?? "") < (followingValue.declaration?.source() ?? "") // @exempt(from: tests) Empty declarations should never occur.
        } else {
            return precedingValue.name < followingValue.name
        }
    }

    // MARK: - Equatable

    public static func == (precedingValue: APIElement, followingValue: APIElement) -> Bool {
        return (precedingValue.name, precedingValue.declaration?.source()) == (followingValue.name, followingValue.declaration?.source())
    }

    // MARK: - Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(declaration?.source() ?? name)
    }
}
