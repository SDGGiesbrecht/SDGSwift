/*
 APIElementProtocol.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SDGControlFlow
  import SDGLogic
  import SDGCollections

  import SwiftSyntax

  /// A type‐erased element of API.
  public protocol APIElementProtocol: AnyObject {

    var _storage: _APIElementStorage { get set }

    // #documentation(SDGSwiftSource.APIElement.declaration)
    /// The element’s declaration.
    var possibleDeclaration: Syntax? { get }

    // #documentation(SDGSwiftSource.APIElement.name)
    /// The name of the element.
    var genericName: Syntax { get }

    func _shallowIdentifierList() -> Set<String>
    var _summaryName: String { get }
  }

  extension APIElementProtocol {

    // MARK: - Storage

    internal var storage: APIElementStorage {
      get {
        return _storage
      }
      set {
        _storage = newValue
      }
    }

    // #documentation(SDGSwiftSource.APIElement.documentation)
    /// The element’s documentation.
    public var documentation: [SymbolDocumentation] {
      return storage.documentation
    }

    // #documentation(SDGSwiftSource.APIElement.compilationConditions)
    /// The compilation conditions under which the element is available.
    public internal(set) var compilationConditions: Syntax? {
      get {
        return storage.compilationConditions
      }
      set {
        storage.compilationConditions = newValue
      }
    }

    // #documentation(SDGSwiftSource.APIElement.constraints)
    /// Any generic constraints the element has.
    public internal(set) var constraints: GenericWhereClauseSyntax? {
      get {
        return storage.constraints
      }
      set {
        storage.constraints = newValue
      }
    }

    // #documentation(SDGSwiftSource.APIElement.children)
    /// Any children the element has.
    ///
    /// For example, types may have methods and properties as children.
    public internal(set) var children: [APIElement] {
      get {
        return storage.children
      }
      set {
        storage.children = newValue
      }
    }

    // #documentation(SDGSwiftSource.APIElement.isProtocolRequirement)
    /// Whether or not the element is a protocol requirement.
    public internal(set) var isProtocolRequirement: Bool {
      get {
        return storage.isProtocolRequirement
      }
      set {
        storage.isProtocolRequirement = newValue
      }
    }

    // #documentation(SDGSwiftSource.APIElement.hasDefaultImplementation)
    /// Whether or not the element has a default implementation.
    public internal(set) var hasDefaultImplementation: Bool {
      get {
        return storage.hasDefaultImplementation
      }
      set {
        storage.hasDefaultImplementation = newValue
      }
    }

    internal var _overloads: [APIElement] {
      get {
        return storage._overloads
      }
      set {
        storage._overloads = newValue
      }
    }

    // #documentation(SDGSwiftSource.APIElement.userInformation)
    /// Arbitrary storage for use by client modules which need to associate other values to APIElement instances.
    ///
    /// This property is never used by anything in `SDGSwift` and will always be `nil` unless a client module sets it to something else.
    public var userInformation: Any? {
      get {
        return storage.userInformation
      }
      set {
        storage.userInformation = newValue
      }
    }

    // MARK: - Summary

    public var _summaryName: String {
      return genericName.source()
    }

    internal func appendCompilationConditions(to description: inout String) {
      if let conditions = compilationConditions {
        description += " • " + conditions.source()
      }
    }

    internal func appendConstraints(to description: inout String) {
      if let constraints = constraints {
        description += constraints.source()
      }
    }

    // MARK: - Children

    private func filtered<T>(_ filter: (APIElement) -> T?) -> AnyBidirectionalCollection<T> {
      return AnyBidirectionalCollection(children.lazy.map(filter).compactMap({ $0 }))
    }

    // #documentation(SDGSwiftSource.APIElement.libraries)
    /// The children which are libraries.
    public var libraries: AnyBidirectionalCollection<LibraryAPI> {
      return filtered { (element) -> LibraryAPI? in
        switch element {
        case .library(let library):
          return library
        default:
          return nil
        }
      }
    }

    // #documentation(SDGSwiftSource.APIElement.modules)
    /// The children which are modules.
    public var modules: AnyBidirectionalCollection<ModuleAPI> {
      return filtered { (element) -> ModuleAPI? in
        switch element {
        case .module(let module):
          return module
        default:
          return nil
        }
      }
    }
  }
#endif
