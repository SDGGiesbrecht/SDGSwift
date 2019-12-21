/*
 APIElementBase.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

import SwiftSyntax

public class _APIElementBase {

  // MARK: - Initialization

  internal init(
    documentation: [SymbolDocumentation],
    constraints: GenericWhereClauseSyntax? = nil,
    compilationConditions: Syntax? = nil,
    children: [APIElement] = []
  ) {
    self._storage = APIElementStorage(
      documentation: documentation,
      compilationConditions: compilationConditions,
      constraints: constraints,
      children: children
    )
  }

  // MARK: - Properties

  // #documentation(SDGSwiftSource.APIElement.isProtocolRequirement)
  /// Whether or not the element is a protocol requirement.
  public internal(set) var isProtocolRequirement: Bool = false
  // #documentation(SDGSwiftSource.APIElement.hasDefaultImplementation)
  /// Whether or not the element has a default implementation.
  public internal(set) var hasDefaultImplementation: Bool = false
  internal var _overloads: [APIElement] = []

  // @documentation(SDGSwiftSource.APIElement.userInformation)
  /// Arbitrary storage for use by client modules which need to associate other values to APIElement instances.
  ///
  /// This property is never used by anything in `SDGSwift` and will always be `nil` unless a client module sets it to something else.
  public var userInformation: Any?

  // MARK: - Merging

  internal func moveConditionsToChildren() {
    #warning("Remove _storage.")
    for child in _storage.children {
      child.compilationConditions.prependCompilationConditions(_storage.compilationConditions)
      if child.constraints ≠ nil {
        child.constraints.merge(with: _storage.constraints)
      } else {
        child.constraints = _storage.constraints
      }
    }
    _storage.compilationConditions = nil
    _storage.constraints = nil
  }

  internal func merge(extension: ExtensionAPI) {
    #warning("Remove _storage.")
    `extension`.moveConditionsToChildren()
    _storage.children.append(contentsOf: `extension`.children)
    _storage.children = FunctionAPI.groupIntoOverloads(_storage.children)
  }

  // MARK: - Overloads

  internal static func groupIntoOverloads<E>(_ elements: [E], convert: (E) -> APIElement) -> [E]
  where E: _OverloadableAPIElement {
    var grouped: [String: [E]] = [:]

    for element in elements {
      grouped[element.genericOverloadPattern().source(), default: []].append(element)
    }

    var result: [E] = []
    for (_, group) in grouped {
      var merged: [E] = []
      for element in group.sorted() {
        var shouldAppendNew = true
        partnerSearch: for index in merged.indices {
          let existing = merged[index]

          if let existingDocumenation = existing.documentation.last?.documentationComment {
            if let elementDocumentation = element.documentation.last?.documentationComment {
              if existingDocumenation.text == elementDocumentation.text {
                // Same documentation.
                existing.overloads.append(convert(element))
                shouldAppendNew = false
                break partnerSearch
              } else {
                // Differing documentation.
                continue partnerSearch
              }
            } else {
              // Only the existing element has documentation.
              existing.overloads.append(convert(element))
              shouldAppendNew = false
              break partnerSearch
            }
          } else if element.documentation.last ≠ nil {
            // Only the new element has documentation.
            element.overloads.append(convert(merged.remove(at: index)))
            break partnerSearch
          } else {
            // Neither has documentation.
            existing.overloads.append(convert(element))
            shouldAppendNew = false
            break partnerSearch
          }
        }
        if shouldAppendNew {
          merged.append(element)
        }
      }
      result.append(contentsOf: merged)
    }

    return result
  }

  internal static func groupIntoOverloads(_ elements: [APIElement]) -> [APIElement] {
    var types: [TypeAPI] = []
    var initializers: [InitializerAPI] = []
    var variables: [VariableAPI] = []
    var subscripts: [SubscriptAPI] = []
    var functions: [FunctionAPI] = []

    var result: [APIElement] = []

    for element in elements {
      switch element {
      case .package, .library, .module, .extension, .protocol, .case, .operator, .precedence,
        .conformance:
        result.append(element)
      case .type(let type):
        types.append(type)
      case .initializer(let initializer):
        initializers.append(initializer)
      case .variable(let variable):
        variables.append(variable)
      case .subscript(let `subscript`):
        subscripts.append(`subscript`)
      case .function(let function):
        functions.append(function)
      }
    }

    types = _APIElementBase.groupIntoOverloads(types) { .type($0) }
    initializers = _APIElementBase.groupIntoOverloads(initializers) { .initializer($0) }
    variables = _APIElementBase.groupIntoOverloads(variables) { .variable($0) }
    subscripts = _APIElementBase.groupIntoOverloads(subscripts) { .subscript($0) }
    functions = _APIElementBase.groupIntoOverloads(functions) { .function($0) }

    result.append(contentsOf: types.lazy.map({ APIElement.type($0) }))
    result.append(contentsOf: initializers.lazy.map({ APIElement.initializer($0) }))
    result.append(contentsOf: variables.lazy.map({ APIElement.variable($0) }))
    result.append(contentsOf: subscripts.lazy.map({ APIElement.subscript($0) }))
    result.append(contentsOf: functions.lazy.map({ APIElement.function($0) }))

    return result
  }

  // MARK: - APIElementProtocol

  public var _storage: _APIElementStorage
}
