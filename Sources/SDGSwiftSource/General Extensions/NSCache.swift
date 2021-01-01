/*
 NSCache.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3.1, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
  import Foundation

  internal class ParsedDocumentationCache: NSCache<NSString, DocumentationSyntax> {

    // MARK: - Initialization

    internal override init() {
      super.init()
      totalCostLimit = 10_000
    }

    // MARK: - Subscripts

    internal subscript(key: String) -> DocumentationSyntax? {
      get {
        return object(forKey: NSString(string: key))
      }
      set {
        let bridged = NSString(string: key)
        if let new = newValue {
          setObject(new, forKey: bridged, cost: bridged.length)
        } else {  // @exempt(from: tests) Unused.
          removeObject(forKey: bridged)
        }
      }
    }
  }
#endif
