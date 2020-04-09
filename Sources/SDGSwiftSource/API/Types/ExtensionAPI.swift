/*
 ExtensionAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(workspace version 0.32.0, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  import SDGControlFlow

  import SwiftSyntax

  /// An extension.
  public final class ExtensionAPI: APIElementProtocol, SortableAPIElement,
    _UndeclaredAPIElementProtocol
  {

    // MARK: - Initialization

    internal init<Syntax>(
      type: Syntax,
      constraints: GenericWhereClauseSyntax?,
      children: [APIElement]
    ) where Syntax: TypeSyntaxProtocol {
      _undeclaredStorage = UndeclaredAPIElementStorage(type: type)
      self.constraints = constraints
      self.children = children
    }

    // MARK: - Combining

    /// Returns whether or not the extension extends the specified type.
    ///
    /// - Parameters:
    ///     - type: The type to check.
    public func isExtension(of type: TypeAPI) -> Bool {
      return self.type.source() == type.genericName.source()
    }
    internal func nested(in type: TypeAPI) -> ExtensionAPI? {
      guard let memberType = self.type.as(MemberTypeIdentifierSyntax.self),
        memberType.rootType().source() == type.genericName.source()
      else {
        return nil
      }
      return ExtensionAPI(
        type: memberType.strippingRootType(),
        constraints: constraints,
        children: children
      )
    }
    /// Returns whether or not the extension extends the specified protocol.
    ///
    /// - Parameters:
    ///     - protocol: The protocol to check.
    public func isExtension(of protocol: ProtocolAPI) -> Bool {
      return self.type.source() == `protocol`.name.source()
    }
    /// Returns whether or not the extension extends the same type as the other specified extension.
    ///
    /// - Parameters:
    ///     - other: The other extension.
    public func extendsSameType(as other: ExtensionAPI) -> Bool {
      return type.source() == other.type.source()
    }

    internal static func combine(extensions: [ExtensionAPI]) -> [ExtensionAPI] {
      var sorted: [String: [ExtensionAPI]] = [:]

      for `extension` in extensions {
        sorted[`extension`.type.source(), default: []].append(`extension`)
      }

      var result: [ExtensionAPI] = []
      for (_, group) in sorted {
        var merged: ExtensionAPI?
        for `extension` in group {
          if let existing = merged {
            existing.merge(extension: `extension`)
            merged = existing
          } else {
            merged = `extension`
          }
        }
        result.append(merged!)
      }

      return result
    }

    // MARK: - APIElementProtocol

    public var _summaryName: String {
      return "(" + genericName.source() + ")"
    }

    // MARK: - UndeclaredAPIElementProtocol

    public var _undeclaredStorage: _UndeclaredAPIElementStorage
  }
#endif
