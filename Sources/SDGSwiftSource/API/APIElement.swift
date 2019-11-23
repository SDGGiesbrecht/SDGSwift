/*
 APIElement.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGMathematics
import SDGLocalization

import SwiftSyntax

/// An element of API.
public enum APIElement: Comparable, Hashable {

  // MARK: - Static Methods

  internal static func merge(elements: [APIElement]) -> [APIElement] {

    var extensions: [ExtensionAPI] = []
    var types: [TypeAPI] = []
    var protocols: [ProtocolAPI] = []
    var other: [APIElement] = []
    for element in elements {
      switch element {
      case .extension(let `extension`):
        extensions.append(`extension`)
      case .type(let type):
        types.append(type)
      case .protocol(let `protocol`):
        protocols.append(`protocol`)
      default:
        other.append(element)
      }
    }

    var unmergedExtensions: [ExtensionAPI] = []
    extensionIteration: for `extension` in extensions {
      for type in types where type.mergeIfExtended(by: `extension`) {
        continue extensionIteration
      }
      for `protocol` in protocols where `extension`.isExtension(of: `protocol`) {
        `protocol`.merge(extension: `extension`)
        continue extensionIteration
      }
      `extension`.moveConditionsToChildren()
      unmergedExtensions.append(`extension`)
    }
    other.append(
      contentsOf: ExtensionAPI.combine(extensions: unmergedExtensions).lazy.map({
        APIElement.extension($0)
      })
    )

    other.append(contentsOf: types.lazy.map({ APIElement.type($0) }))
    other.append(contentsOf: protocols.lazy.map({ APIElement.protocol($0) }))

    let result = _APIElementBase.groupIntoOverloads(other)
    resolveConformances(elements: result)
    return result
  }

  internal static func resolveConformances(elements: [APIElement]) {

    var cache: ([String: ProtocolAPI], [String: TypeAPI])?

    for element in elements {
      for nestedElement in element.nestedList(of: APIElementProtocol.self) {
        for conformance in nestedElement.conformances where conformance.reference == nil {
          let (protocols, superclasses) = cached(in: &cache) {
            let protocols = elements.lazy.map({ $0.nestedList(of: ProtocolAPI.self) }).joined()
            let superclasses = elements.lazy.map({ $0.nestedList(of: TypeAPI.self) }).joined()
              .filter({ $0.isSubclassable() })
            return (
              Dictionary(
                protocols.lazy.map({ ($0.name.source(), $0) }),
                uniquingKeysWith: { first, _ in first }
              ),
              Dictionary(
                superclasses.lazy.map({ ($0.genericName.source(), $0) }),
                uniquingKeysWith: { first, _ in first }
              )
            )
          }
          nestedElement.inherit(from: conformance, protocols: protocols, classes: superclasses)
        }
      }
    }
  }

  // MARK: - Cases

  /// A Swift package.
  case package(PackageAPI)

  /// A library product of a package.
  case library(LibraryAPI)

  /// A Swift module.
  case module(ModuleAPI)

  /// A type.
  ///
  /// A type may be a structure, class, enumeration, type alias or associated type.
  case type(TypeAPI)

  /// A protocol.
  case `protocol`(ProtocolAPI)

  /// An extension.
  case `extension`(ExtensionAPI)

  /// An enumeration case.
  case `case`(CaseAPI)

  /// An initializer.
  case initializer(InitializerAPI)

  /// A variable or property.
  case variable(VariableAPI)

  /// A subscript.
  case `subscript`(SubscriptAPI)

  /// A function or method.
  case function(FunctionAPI)

  /// An operator.
  case `operator`(OperatorAPI)

  /// An operator precedence group.
  case precedence(PrecedenceAPI)

  /// A conformance or superclass.
  case conformance(ConformanceAPI)

  // MARK: - Methods

  internal var elementBase: _APIElementBase {
    switch self {
    case .package(let package):
      return package
    case .library(let library):
      return library
    case .module(let module):
      return module
    case .type(let type):
      return type
    case .extension(let `extension`):
      return `extension`
    case .protocol(let `protocol`):
      return `protocol`
    case .case(let `case`):
      return `case`
    case .initializer(let initializer):
      return initializer
    case .variable(let variable):
      return variable
    case .subscript(let `subscript`):
      return `subscript`
    case .function(let function):
      return function
    case .operator(let `operator`):
      return `operator`
    case .precedence(let precedence):
      return precedence
    case .conformance(let conformance):
      return conformance
    }
  }

  internal var elementProtocol: APIElementProtocol {
    switch self {
    case .package(let package):
      return package
    case .library(let library):
      return library
    case .module(let module):
      return module
    case .type(let type):
      return type
    case .extension(let `extension`):
      return `extension`
    case .protocol(let `protocol`):
      return `protocol`
    case .case(let `case`):
      return `case`
    case .initializer(let initializer):
      return initializer
    case .variable(let variable):
      return variable
    case .subscript(let `subscript`):
      return `subscript`
    case .function(let function):
      return function
    case .operator(let `operator`):
      return `operator`
    case .precedence(let precedence):
      return precedence
    case .conformance(let conformance):
      return conformance
    }
  }

  // @documentation(SDGSwiftSource.APIElement.declaration)
  /// The element’s declaration.
  public var declaration: Syntax? {
    return elementProtocol.possibleDeclaration
  }

  // @documentation(SDGSwiftSource.APIElement.constraints)
  /// Any generic constraints the element has.
  public var constraints: GenericWhereClauseSyntax? {
    return elementProtocol.constraints
  }

  // @documentation(SDGSwiftSource.APIElement.documentation)
  /// The element’s documentation.
  public var documentation: [SymbolDocumentation] {
    return elementProtocol.documentation
  }

  // @documentation(SDGSwiftSource.APIElement.compilationConditions)
  /// The compilation conditions under which the element is available.
  public var compilationConditions: Syntax? {
    return elementProtocol.compilationConditions
  }

  // @documentation(SDGSwiftSource.APIElement.name)
  /// The name of the element.
  public var name: Syntax {
    return elementProtocol.genericName
  }

  // @documentation(SDGSwiftSource.APIElement.overloads)
  /// The element’s overloads.
  public var overloads: [APIElement] {
    return elementProtocol.overloads
  }

  // @documentation(SDGSwiftSource.APIElement.children)
  /// Any children the element has.
  ///
  /// For example, types may have methods and properties as children.
  public var children: [APIElement] {
    return elementProtocol.children
  }

  // @documentation(SDGSwiftSource.APIElement.libraries)
  /// The children which are libraries.
  public var libraries: AnyBidirectionalCollection<LibraryAPI> {
    return elementProtocol.libraries
  }

  // @documentation(SDGSwiftSource.APIElement.modules)
  /// The children which are modules.
  public var modules: AnyBidirectionalCollection<ModuleAPI> {
    return elementProtocol.modules
  }

  // @documentation(SDGSwiftSource.APIElement.types)
  /// The children which are types.
  public var types: AnyBidirectionalCollection<TypeAPI> {
    return elementProtocol.types
  }

  // @documentation(SDGSwiftSource.APIElement.extensions)
  /// The children which are extensions.
  public var extensions: AnyBidirectionalCollection<ExtensionAPI> {
    return elementProtocol.extensions
  }

  // @documentation(SDGSwiftSource.APIElement.protocols)
  /// The children which are protocols.
  public var protocols: AnyBidirectionalCollection<ProtocolAPI> {
    return elementProtocol.protocols
  }

  // @documentation(SDGSwiftSource.APIElement.cases)
  /// The children which are cases.
  public var cases: AnyBidirectionalCollection<CaseAPI> {
    return elementProtocol.cases
  }

  // @documentation(SDGSwiftSource.APIElement.typeProperties)
  /// The children which are type properties.
  public var typeProperties: AnyBidirectionalCollection<VariableAPI> {
    return elementProtocol.typeProperties
  }

  // @documentation(SDGSwiftSource.APIElement.typeMethods)
  /// The children which are type methods.
  public var typeMethods: AnyBidirectionalCollection<FunctionAPI> {
    return elementProtocol.typeMethods
  }

  // @documentation(SDGSwiftSource.APIElement.initializers)
  /// The children which are initializers.
  public var initializers: AnyBidirectionalCollection<InitializerAPI> {
    return elementProtocol.initializers
  }

  // @documentation(SDGSwiftSource.APIElement.instanceProperties)
  /// The children which are instance properties or global variables.
  public var instanceProperties: AnyBidirectionalCollection<VariableAPI> {
    return elementProtocol.instanceProperties
  }

  // @documentation(SDGSwiftSource.APIElement.subscripts)
  /// The children which are subscripts.
  public var subscripts: AnyBidirectionalCollection<SubscriptAPI> {
    return elementProtocol.subscripts
  }

  // @documentation(SDGSwiftSource.APIElement.instanceMethods)
  /// The children which are instance methods or global functions.
  public var instanceMethods: AnyBidirectionalCollection<FunctionAPI> {
    return elementProtocol.instanceMethods
  }

  // @documentation(SDGSwiftSource.APIElement.operators)
  /// The children which are operators.
  public var operators: AnyBidirectionalCollection<OperatorAPI> {
    return elementProtocol.operators
  }

  // @documentation(SDGSwiftSource.APIElement.precedenceGroups)
  /// The children which are operator precedence groups.
  public var precedenceGroups: AnyBidirectionalCollection<PrecedenceAPI> {
    return elementProtocol.precedenceGroups
  }

  // @documentation(SDGSwiftSource.APIElement.conformances)
  /// The children which are conformances or superclasses.
  public var conformances: AnyBidirectionalCollection<ConformanceAPI> {
    return elementProtocol.conformances
  }

  // @documentation(SDGSwiftSource.APIElement.isProtocolRequirement)
  /// Whether or not the element is a protocol requirement.
  public var isProtocolRequirement: Bool {
    return elementProtocol.isProtocolRequirement
  }

  // @documentation(SDGSwiftSource.APIElement.hasDefaultImplementation)
  /// Whether or not the element has a default implementation.
  public var hasDefaultImplementation: Bool {
    return elementProtocol.hasDefaultImplementation
  }

  private func nestedList<T>(of type: T.Type) -> [T] {
    var result: [T] = []
    if let element = elementProtocol as? T {
      result.append(element)
    }
    for child in children {
      result.append(contentsOf: child.nestedList(of: T.self))
    }
    return result
  }

  // @documentation(SDGSwiftSource.APIElement.summary)
  /// A summary of the element’s API.
  public func summary() -> [String] {
    return elementProtocol.summary()
  }

  // @documentation(SDGSwiftSource.APIElement.identifierList)
  /// A list of all identifiers made available by the element.
  public func identifierList() -> Set<String> {
    return elementProtocol.identifierList()
  }

  // #documentation(SDGSwiftSource.APIElement.userInformation)
  /// Arbitrary storage for use by client modules which need to associate other values to APIElement instances.
  ///
  /// This property is never used by anything in `SDGSwift` and will always be `nil` unless a client module sets it to something else.
  public var userInformation: Any? {
    get {
      return elementBase.userInformation
    }
    nonmutating set {
      elementBase.userInformation = newValue
    }
  }

  // MARK: - Comparable

  private enum Group: OrderedEnumeration {
    case package
    case library
    case module
    case type
    case `extension`
    case `protocol`
    case `case`
    case typeProperty
    case typeMethod
    case initializer
    case variable
    case `subscript`
    case function
    case `operator`
    case precedence
    case conformance
  }

  private func comparisonIdentity() -> (Group, String, String, String) {
    func flatten(
      _ group: Group,
      _ properties: (name: String, declaration: String, constraints: String)
    ) -> (Group, String, String, String) {
      return (group, properties.name, properties.declaration, properties.constraints)
    }
    switch self {
    case .package(let package):
      return flatten(.package, package.comparisonIdentity())
    case .library(let library):
      return flatten(.library, library.comparisonIdentity())
    case .module(let module):
      return flatten(.module, module.comparisonIdentity())
    case .type(let type):
      return flatten(.type, type.comparisonIdentity())
    case .extension(let `extension`):
      return flatten(.extension, `extension`.comparisonIdentity())
    case .protocol(let `protocol`):
      return flatten(.protocol, `protocol`.comparisonIdentity())
    case .case(let `case`):
      return flatten(.case, `case`.comparisonIdentity())
    case .initializer(let initializer):
      return flatten(.initializer, initializer.comparisonIdentity())
    case .variable(let variable):
      if variable.declaration.isTypeMember() {
        return flatten(.typeProperty, variable.comparisonIdentity())
      } else {
        return flatten(.variable, variable.comparisonIdentity())
      }
    case .subscript(let `subscript`):
      return flatten(.subscript, `subscript`.comparisonIdentity())
    case .function(let function):
      if function.declaration.isTypeMember() {
        return flatten(.typeMethod, function.comparisonIdentity())
      } else {
        return flatten(.function, function.comparisonIdentity())
      }
    case .operator(let `operator`):
      return flatten(.operator, `operator`.comparisonIdentity())
    case .precedence(let precedence):
      return flatten(.precedence, precedence.comparisonIdentity())
    case .conformance(let conformance):
      return flatten(.conformance, conformance.comparisonIdentity())
    }
  }

  public static func < (precedingValue: APIElement, followingValue: APIElement) -> Bool {
    return precedingValue.comparisonIdentity() < followingValue.comparisonIdentity()
  }

  // MARK: - Equatable

  public static func == (precedingValue: APIElement, followingValue: APIElement) -> Bool {
    return precedingValue.comparisonIdentity() == followingValue.comparisonIdentity()
  }

  // MARK: - Hashable

  public func hash(into hasher: inout Hasher) {
    hasher.combine(declaration?.source() ?? name.source())
  }
}
