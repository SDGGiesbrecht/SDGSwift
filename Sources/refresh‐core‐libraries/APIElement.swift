/*
 APIElement.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

import SDGSwiftSource

var inProtocol = false
extension APIElement {

    func appendInheritables(to api: inout [String]) {
        switch self {
        case .package, .library, .module:
            for child in [
                types.map({ APIElement.type($0) }),
                protocols.map({ APIElement.protocol($0) }),
                extensions.map({ APIElement.extension($0) }),
                ].joined() {
                child.appendInheritables(to: &api)
            }
        case .type(let type):
            switch type.genericDeclaration {
            case let `class` as ClassDeclSyntax:
                if let modifiers = `class`.modifiers,
                    modifiers.contains(where: { $0.name.text == "open" }) {
                    api.append(`class`.source() + " {")
                    for child in children {
                        child.appendInheritables(to: &api)
                    }
                    api.append("}")
                }
            default:
                break
            }
        case .protocol(let `protocol`):
            inProtocol = true
            defer { inProtocol = false }
            api.append(`protocol`.declaration.madePublic().source() + " {")
            for child in children {
                child.appendInheritables(to: &api)
            }
            api.append("}")
        case .extension(let `extension`):
            api.append("extension " + `extension`.genericName.source() + " {")
            for child in children {
                child.appendInheritables(to: &api)
            }
            api.append("}")
        case .case, .operator, .precedence, .conformance:
            break
        case .initializer(let initializer):
            append(simpleDeclaration: initializer.declaration.madePublic(inProtocol), implementation: true, to: &api)
        case .variable(let variable):
            append(simpleDeclaration: variable.declaration.madePublic(inProtocol), implementation: false, to: &api)
        case .subscript(let `subscript`):
            append(simpleDeclaration: `subscript`.declaration.madePublic(inProtocol), implementation: true, to: &api)
        case .function(let function):
            if function.declaration.identifier.text ≠ "" {
                append(simpleDeclaration: function.declaration.madePublic(inProtocol), implementation: true, to: &api)
            }
        }
    }

    private func append(simpleDeclaration declaration: Syntax, implementation: Bool, to api: inout [String]) {
        var declaration = "    " + declaration.source()
        if let constraints = self.constraints?.source() {
            declaration += constraints
        }
        if implementation ∧ ¬inProtocol {
            declaration += " {}"
        }
        if let conditions = self.compilationConditions?.source() {
            declaration.prepend(contentsOf: conditions + "\n")
            declaration += "\n#endif"
        }
        api.append(declaration)
    }
}
