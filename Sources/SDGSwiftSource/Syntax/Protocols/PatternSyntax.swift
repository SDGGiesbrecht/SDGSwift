/*
 PatternSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic

extension PatternSyntax {

    internal func flattenedForAPI() -> [IdentifierPatternSyntax] {
        var list: [IdentifierPatternSyntax] = []
        switch self {
        case let identifier as IdentifierPatternSyntax :
            if ¬identifier.identifier.text.hasPrefix("_") {
                list.append(identifier)
            }
        default: // @exempt(from: tests) Should never occur.
            if BuildConfiguration.current == .debug { // @exempt(from: tests)
                print("Unidentified binding pattern: \(Swift.type(of: self))")
            }
        }
        return list
    }

    internal func normalizedVariableBindingForAPIDeclaration() -> PatternSyntax {
        switch self {
        case let identifier as IdentifierPatternSyntax :
            return identifier.normalizedVariableBindingIdentiferForAPIDeclaration()
        default: // @exempt(from: tests) Should never occur.
            if BuildConfiguration.current == .debug { // @exempt(from: tests)
                print("Unidentified pattern: \(Swift.type(of: self))")
            }
            return self
        }
    }

    internal func variableBindingForName() -> PatternSyntax {
        switch self {
        case let identifier as IdentifierPatternSyntax :
            return identifier.variableBindingIdentifierForName()
        default: // @exempt(from: tests) Should never occur.
            if BuildConfiguration.current == .debug { // @exempt(from: tests)
                print("Unidentified pattern: \(Swift.type(of: self))")
            }
            return self
        }
    }
}
