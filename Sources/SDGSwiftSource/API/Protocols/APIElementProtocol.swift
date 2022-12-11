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

    // #documentation(SDGSwiftSource.APIElement.declaration)
    /// The element’s declaration.
    var possibleDeclaration: Syntax? { get }

    // #documentation(SDGSwiftSource.APIElement.name)
    /// The name of the element.
    var genericName: Syntax { get }
  }

  extension APIElementProtocol {

    // MARK: - Summary

    public var _summaryName: String {
      return genericName.source()
    }
  }
#endif
