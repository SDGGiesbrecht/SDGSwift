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

    // MARK: - Summary

    public var _summaryName: String {
      return genericName.source()
    }
  }
#endif
