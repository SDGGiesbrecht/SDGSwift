/*
 AttributeListSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.2.4, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  import SwiftSyntax

  extension AttributeListSyntax {

    internal func indicatesAbsence() -> Bool {
      return contains(where: { $0.attributeIndicatesAbsence() })
    }

    internal func normalizedForAPIDeclaration() -> AttributeListSyntax? {
      let unsorted = lazy.compactMap({ $0.normalizedAttributeForAPIDeclaration() })
      var builtIn: [AttributeSyntax] = []
      var custom: [Syntax] = []
      for entry in unsorted {
        if let attribute = entry.as(AttributeSyntax.self) {  // Built‐in
          builtIn.append(attribute)
        } else {  // Custom
          custom.append(entry)
        }
      }
      let sorted = builtIn.sorted(by: AttributeSyntax.arrange).map({ Syntax($0) }) + custom
      return sorted.isEmpty ? nil : SyntaxFactory.makeAttributeList(sorted)
    }
  }
#endif
