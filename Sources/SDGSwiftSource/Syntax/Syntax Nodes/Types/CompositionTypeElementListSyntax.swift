/*
 CompositionTypeElementListSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3.1, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
  import SwiftSyntax

  extension CompositionTypeElementListSyntax {

    internal func normalized() -> CompositionTypeElementListSyntax {
      var result = map({ $0.normalized(withAmpersand: true) }).sorted(by: {
        $0.source() < $1.source()
      })
      if let last = result.indices.last {
        result[last] = result[last].normalized(withAmpersand: false)
      }
      return SyntaxFactory.makeCompositionTypeElementList(result)
    }
  }
#endif
