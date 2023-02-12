/*
 ParameterDocumentation.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Parameter documentation.
public struct ParameterDocumentation {

  /// The paramater name.
  public let name: ExtendedTokenSyntax

  /// The description.
  public let description: [ExtendedSyntax]
}
