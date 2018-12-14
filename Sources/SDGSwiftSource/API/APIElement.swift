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

public class APIElement {

    // MARK: - Initialization

    internal init() {
    }

    // MARK: - Properties

    public internal(set) var constraints: GenericWhereClauseSyntax?
    public internal(set) var compilationConditions: Syntax?

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
}
