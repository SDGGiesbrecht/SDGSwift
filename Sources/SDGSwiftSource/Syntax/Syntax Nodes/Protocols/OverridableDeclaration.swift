/*
 OverridableDeclaration.swift

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

  internal protocol OverridableDeclaration {
    var modifiers: ModifierListSyntax? { get }
  }

  extension OverridableDeclaration {

    func isOverride() -> Bool {
      if let modifiers = self.modifiers,
        modifiers.contains(where: { $0.name.text == "override" })
      {
        return true
      }
      return false
    }
  }
#endif
