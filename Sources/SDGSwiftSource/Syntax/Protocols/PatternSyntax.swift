/*
 PatternSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic

extension PatternSyntax {

    internal func flattenedForAPI() -> [(identifier: IdentifierPatternSyntax, indexPath: [Int])] {
        var list: [(identifier: IdentifierPatternSyntax, indexPath: [Int])] = []
        switch self {
        case let identifier as IdentifierPatternSyntax :
            if ¬identifier.identifier.text.hasPrefix("_") {
                list.append((identifier: identifier, indexPath: []))
            }
        case let tuple as TuplePatternSyntax :
            var index = 0
            for element in tuple.elements {
                defer { index += 1 }
                let nested = element.pattern.flattenedForAPI()
                let indexed = nested.map { (entry: (identifier: IdentifierPatternSyntax, indexPath: [Int])) -> (identifier: IdentifierPatternSyntax, indexPath: [Int]) in
                    var mutable = entry
                    mutable.indexPath.prepend(index)
                    return mutable
                }
                list.append(contentsOf: indexed)
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

    internal func variableBindingForOverloadPattern() -> PatternSyntax {
        switch self {
        case let identifier as IdentifierPatternSyntax :
            return identifier.variableBindingIdentifierForOverloadPattern()
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
