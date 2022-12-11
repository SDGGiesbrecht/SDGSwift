/*
 ExtensionAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SDGControlFlow

  import SwiftSyntax

  /// An extension.
  public final class ExtensionAPI: APIElementProtocol,
    _UndeclaredAPIElementProtocol
  {

    // MARK: - Initialization

    internal init<Syntax>(
      type: Syntax,
      constraints: GenericWhereClauseSyntax?
    ) where Syntax: TypeSyntaxProtocol {
      _undeclaredStorage = UndeclaredAPIElementStorage(type: type)
    }

    // MARK: - APIElementProtocol

    public var _summaryName: String {
      return "(" + genericName.source() + ")"
    }

    // MARK: - UndeclaredAPIElementProtocol

    public var _undeclaredStorage: _UndeclaredAPIElementStorage
  }
#endif
