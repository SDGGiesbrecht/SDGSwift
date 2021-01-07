/*
 TypeSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3.2, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
  import SDGControlFlow
  import SDGLogic

  import SwiftSyntax

  extension TypeSyntax {

    internal func normalized(extractingFromIndexPath indexPath: [Int] = []) -> TypeSyntax {
      if let simple = self.as(SimpleTypeIdentifierSyntax.self) {
        return simple.normalized()
      } else if let metatype = self.as(MetatypeTypeSyntax.self) {
        return TypeSyntax(metatype.normalized())
      } else if let member = self.as(MemberTypeIdentifierSyntax.self) {
        return member.normalized()
      } else if let optional = self.as(OptionalTypeSyntax.self) {
        return TypeSyntax(optional.normalized())
      } else if let implicitlyUnwrapped = self.as(ImplicitlyUnwrappedOptionalTypeSyntax.self) {
        return TypeSyntax(implicitlyUnwrapped.normalized())
      } else if let tuple = self.as(TupleTypeSyntax.self) {
        return tuple.normalized(extractingFromIndexPath: indexPath)
      } else if let composition = self.as(CompositionTypeSyntax.self) {
        return TypeSyntax(composition.normalized())
      } else if let array = self.as(ArrayTypeSyntax.self) {
        return TypeSyntax(array.normalized())
      } else if let dictionary = self.as(DictionaryTypeSyntax.self) {
        return TypeSyntax(dictionary.normalized())
      } else if let function = self.as(FunctionTypeSyntax.self) {
        return TypeSyntax(function.normalized())
      } else if let attributed = self.as(AttributedTypeSyntax.self) {
        return TypeSyntax(attributed.normalized())
      } else if let restriction = self.as(ClassRestrictionTypeSyntax.self) {
        return TypeSyntax(restriction.normalized())
      } else {  // @exempt(from: tests)
        warnUnidentified()
        return TypeSyntax(
          SyntaxFactory.makeSimpleTypeIdentifier(
            name: SyntaxFactory.makeToken(.wildcardKeyword),
            genericArgumentClause: nil
          )
        )
      }
    }

    // MARK: - Hidable

    internal var hidabilityIdentifier: TokenSyntax? {
      // Only used by extensions. Non‐extendable types are ignored.
      if let simple = self.as(SimpleTypeIdentifierSyntax.self) {
        return simple.name
      } else if let member = self.as(MemberTypeIdentifierSyntax.self) {
        return member.baseType.hidabilityIdentifier
      } else {  // @exempt(from: tests)
        warnUnidentified()
        return nil
      }
    }
  }
#endif
