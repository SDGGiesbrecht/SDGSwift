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
  public enum APIElement {

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
  }
#endif
