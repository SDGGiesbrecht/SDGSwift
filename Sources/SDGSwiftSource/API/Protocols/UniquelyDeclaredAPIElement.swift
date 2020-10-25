/*
 UniquelyDeclaredAPIElement.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  import SwiftSyntax

  internal protocol _UniquelyDeclaredAPIElement: DeclaredAPIElement {
    associatedtype Declaration: SyntaxProtocol
    associatedtype Name: SyntaxProtocol

    init(
      documentation: [SymbolDocumentation],
      alreadyNormalizedDeclaration declaration: Declaration,
      constraints: GenericWhereClauseSyntax?,
      name: Name,
      children: [APIElement]
    )

    // @documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.declaration)
    /// The element’s declaration.
    var declaration: Declaration { get }
    // @documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.name)
    /// The element’s name.
    var name: Name { get }
  }

  extension _UniquelyDeclaredAPIElement {

    public var genericDeclaration: Syntax {
      return Syntax(declaration)
    }

    public var genericName: Syntax {
      return Syntax(name)
    }
  }
#endif
