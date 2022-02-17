/*
 OverloadableAPIElement.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax

  internal protocol _OverloadableAPIElement: SortableAPIElement {
    func genericOverloadPattern() -> Syntax
    var isProtocolRequirement: Bool { get }
    var hasDefaultImplementation: Bool { get set }
    var _overloads: [APIElement] { get set }
  }

  extension _OverloadableAPIElement {

    // MARK: - Overloads

    public var overloads: [APIElement] {
      get {
        return _overloads
      }
      set {
        var new = newValue.sorted()
        if isProtocolRequirement {
          for index in new.indices {
            let overload = new[index]
            if type(of: overload.elementProtocol) == type(of: self),
              let overloadDeclaration = overload.elementProtocol.possibleDeclaration,
              let declaration = possibleDeclaration,
              overloadDeclaration.source() == declaration.source(),
              overload.constraints?.source() == constraints?.source()
            {

              hasDefaultImplementation = true
              new.remove(at: index)
              break
            }
          }
        }
        _overloads = new
      }
    }
  }
#endif
