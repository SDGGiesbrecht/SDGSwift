/*
 AccessControlled.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
  import SDGLogic

  import SwiftSyntax

  internal protocol AccessControlled: SyntaxProtocol {
    var modifiers: ModifierListSyntax? { get }
  }

  extension AccessControlled {

    internal func isPublic() -> Bool {
      if let modifiers = self.modifiers,
        modifiers.contains(where: { $0.name.tokenKind == .publicKeyword ∨ $0.name.text == "open" })
      {
        return true
      } else {
        return ancestors().contains(where: { $0.is(ProtocolDeclSyntax.self) })
      }
    }
  }
#endif
