/*
 XcodeSDK.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Xcode {

  /// An Xcode SDK.
  public enum SDK: Equatable {

    /// macOS.
    case macOS

    /// tvOS.
    case tvOS(simulator: Bool)

    /// iOS.
    case iOS(simulator: Bool)

    /// watchOS.
    case watchOS(simulator: Bool)

    /// The name used by the command line interface.
    public var commandLineName: String {
      switch self {
      case .macOS:
        return "macosx"
      case .tvOS(let simulator):
        if simulator {
          return "appletvsimulator"
        } else {
          return "appletvos"
        }
      case .iOS(let simulator):
        if simulator {
          return "iphonesimulator"
        } else {
          return "iphoneos"
        }
      case .watchOS(let simulator):
        if simulator {
          return "watchsimulator"
        } else {
          return "watchos"
        }
      }
    }

    internal var cacheDirectoryName: String {  // @exempt(from: tests)
      // Many of these cannot be reached from continuous integration.
      switch self {
      case .macOS:
        return "macOS"
      case .tvOS(let simulator):  // @exempt(from: tests)
        var result = "tvOS"
        if simulator {
          result += " Simulator"
        }
        return result
      case .iOS(let simulator):  // @exempt(from: tests)
        var result = "iOS"
        if simulator {
          result += " Simulator"
        }
        return result
      case .watchOS(let simulator):  // @exempt(from: tests)
        var result = "watchOS"
        if simulator {
          result += " Simulator"
        }
        return result
      }
    }
  }
}
