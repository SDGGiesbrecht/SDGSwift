/*
 PatternSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
  import SDGControlFlow
  import SDGLogic

  import SwiftSyntax

  extension PatternSyntax {

    internal var concreteSyntaxIsHidden: Bool {
      if let identifier = self.as(IdentifierPatternSyntax.self) {
        return identifier.isHidden
      } else if let tuple = self.as(TuplePatternSyntax.self) {
        return tuple.elements.allSatisfy({ $0.pattern.concreteSyntaxIsHidden })
      } else {  // @exempt(from: tests)
        warnUnidentified()
        return false
      }
    }

    internal func flattenedForAPI() -> [(identifier: IdentifierPatternSyntax, indexPath: [Int])] {
      var list: [(identifier: IdentifierPatternSyntax, indexPath: [Int])] = []
      if let identifier = self.as(IdentifierPatternSyntax.self) {
        list.append((identifier: identifier, indexPath: []))
      } else if let tuple = self.as(TuplePatternSyntax.self) {
        var index = 0
        for element in tuple.elements {
          defer { index += 1 }
          let nested = element.pattern.flattenedForAPI()

          typealias Indexed = (identifier: IdentifierPatternSyntax, indexPath: [Int])
          let indexed = nested.map { (entry: Indexed) -> Indexed in
            var mutable = entry
            mutable.indexPath.prepend(index)
            return mutable
          }

          list.append(contentsOf: indexed)
        }
      } else {  // @exempt(from: tests)
        warnUnidentified()
      }
      return list.filter({ ¬$0.identifier.isHidden })
    }

    internal func normalizedVariableBindingForAPIDeclaration() -> PatternSyntax {
      if let identifier = self.as(IdentifierPatternSyntax.self) {
        return PatternSyntax(identifier.normalizedVariableBindingIdentiferForAPIDeclaration())
      } else {  // @exempt(from: tests)
        warnUnidentified()
        return self
      }
    }

    internal func variableBindingForOverloadPattern() -> PatternSyntax {
      if let identifier = self.as(IdentifierPatternSyntax.self) {
        return PatternSyntax(identifier.variableBindingIdentifierForOverloadPattern())
      } else {  // @exempt(from: tests)
        warnUnidentified()
        return self
      }
    }

    internal func variableBindingForName() -> PatternSyntax {
      if let identifier = self.as(IdentifierPatternSyntax.self) {
        return PatternSyntax(identifier.variableBindingIdentifierForName())
      } else {  // @exempt(from: tests)
        warnUnidentified()
        return self
      }
    }
  }
#endif
