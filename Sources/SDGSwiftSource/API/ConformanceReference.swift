/*
 ConformanceReference.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3.2, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
  import SDGControlFlow

  /// A weak reference to the protocol a conformance refers to or to a superclass.
  public enum ConformanceReference {

    /// A protocol conformed to.
    case `protocol`(Weak<ProtocolAPI>)
    /// A superclass.
    case superclass(Weak<TypeAPI>)

    internal var elementProtocol: APIElementProtocol? {
      switch self {
      case .protocol(let `protocol`):
        return `protocol`.pointee
      case .superclass(let superclass):
        return superclass.pointee
      }
    }
  }
#endif
