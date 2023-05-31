/*
 FunctionParameterSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

  import SDGLogic

  import SwiftSyntax

  extension FunctionParameterSyntax {

    // MARK: - Names & Labels

    internal var internalName: TokenSyntax? {
      if secondName?.presence == .present {
        return secondName
      } else {
        return firstName
      }
    }
  }
