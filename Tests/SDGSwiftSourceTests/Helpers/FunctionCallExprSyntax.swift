/*
 FunctionCallExprSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(workspace version 0.32.0, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  import SwiftSyntax

  @testable import SDGSwiftSource

  extension FunctionCallExprSyntax {
    static func packageDeclaration(named name: String) -> FunctionCallExprSyntax {
      /// Provides access to the internal function.
      return FunctionCallExprSyntax.normalizedPackageDeclaration(name: name)
    }
  }
#endif
