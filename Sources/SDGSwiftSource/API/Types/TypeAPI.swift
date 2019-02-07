/*
 TypeAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGCollections

/// A type.
///
/// A type may be a structure, class, enumeration, type alias or associated type.
public final class TypeAPI : _APIElementBase, APIElementProtocol, DeclaredAPIElement, OverloadableAPIElement, SortableAPIElement {

    // MARK: - Initialization

    internal init<T>(documentation: DocumentationSyntax?, declaration: T, children: [APIElement]) where T : TypeDeclaration {
        let (normalizedDeclaration, normalizedConstraints) = declaration.normalizedAPIDeclaration()
        self.declaration = normalizedDeclaration
        genericName = normalizedDeclaration.name()
        super.init(documentation: documentation, children: children)
        self.constraints = normalizedConstraints
    }

    // MARK: - Properties

    private let declaration: TypeDeclaration

    internal func isSubclassable() -> Bool {
        return declaration is ClassDeclSyntax
    }

    // MARK: - APIElementBase

    internal func mergeIfExtended(by extension: ExtensionAPI) -> Bool {
        if `extension`.isExtension(of: self) {
            super.merge(extension: `extension`)
            return true
        }
        if let nested = `extension`.nested(in: self) {
            for subtype in types where subtype.mergeIfExtended(by: nested) {
                return true
            }
        }
        return false
    }

    // MARK: - APIElementProtocol

    public func _shallowIdentifierList() -> Set<String> {
        return declaration.identifierList()
    }

    // MARK: - DeclaredAPIElement

    public var genericDeclaration: Syntax {
        return declaration
    }

    public let genericName: Syntax

    // MARK: - OverloadableAPIElement

    internal func genericOverloadPattern() -> Syntax {
        return genericName
    }
}
