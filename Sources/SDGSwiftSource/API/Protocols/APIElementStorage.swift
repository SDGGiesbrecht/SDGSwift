/*
 APIElementStorage.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax

  public struct _APIElementStorage {

    // MARK: - Initialization

    internal init(
      documentation: [SymbolDocumentation],
      compilationConditions: Syntax? = nil,
      constraints: GenericWhereClauseSyntax? = nil
    ) {
      self.documentation = documentation
      self.compilationConditions = compilationConditions
      self.constraints = constraints
    }

    // MARK: - Properties

    internal let documentation: [SymbolDocumentation]

    internal var compilationConditions: Syntax?

    private var _constraints: GenericWhereClauseSyntax?
    internal var constraints: GenericWhereClauseSyntax? {
      get {
        return _constraints
      }
      set {
        _constraints = newValue?.normalized()
      }
    }

    private var _children: [APIElement] = []

    internal var isProtocolRequirement: Bool = false
    internal var hasDefaultImplementation: Bool = false
    internal var _overloads: [APIElement] = []

    internal var userInformation: Any?
  }
#endif
