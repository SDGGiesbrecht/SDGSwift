/*
 APIElement.swift

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
  import SDGMathematics
  import SDGLocalization

  import SwiftSyntax

  /// An element of API.
  public enum APIElement: Comparable, Hashable {

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
    public internal(set) var constraints: GenericWhereClauseSyntax? {
      get {
        return elementProtocol.constraints
      }
      nonmutating set {
        elementProtocol.constraints = newValue
      }
    }

    // @documentation(SDGSwiftSource.APIElement.documentation)
    /// The element’s documentation.
    public var documentation: [SymbolDocumentation] {
      return elementProtocol.documentation
    }

    // @documentation(SDGSwiftSource.APIElement.compilationConditions)
    /// The compilation conditions under which the element is available.
    public internal(set) var compilationConditions: Syntax? {
      get {
        return elementProtocol.compilationConditions
      }
      nonmutating set {
        elementProtocol.compilationConditions = newValue
      }
    }

    // @documentation(SDGSwiftSource.APIElement.name)
    /// The name of the element.
    public var name: Syntax {
      return elementProtocol.genericName
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
    public internal(set) var isProtocolRequirement: Bool {
      get {
        return elementProtocol.isProtocolRequirement
      }
      nonmutating set {
        elementProtocol.isProtocolRequirement = newValue
      }
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

    // MARK: - Comparable

    // #warkaround(SDGCornerstone 9.0.0, RawRepresentable only necessary because of SR‐15734 evasion.)
    private enum Group: Int, Comparable, OrderedEnumeration {
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
#endif
