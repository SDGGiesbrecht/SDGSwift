/*
 APIElementBase.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public class APIElementBase {

    // MARK: - Initialization

    init(documentation: DocumentationSyntax?) {
        self.documentation = documentation
    }

    // MARK: - Properties

    public let documentation: DocumentationSyntax?

    private var _constraints: GenericWhereClauseSyntax? = nil
    public internal(set) var constraints: GenericWhereClauseSyntax? {
        get {
            return _constraints
        } set {
            _constraints = newValue?.normalized()
        }
    }

    public internal(set) var compilationConditions: Syntax? = nil
}
