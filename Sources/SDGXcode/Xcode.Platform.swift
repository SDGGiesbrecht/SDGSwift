/*
 Xcode.Platform.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Xcode {

  /// A target platform supported by Xcode.
  public enum Platform: Equatable, Sendable {

    /// macOS.
    case macOS

    /// tvOS.
    case tvOS(simulator: Bool)

    /// iOS.
    case iOS(simulator: Bool)

    /// watchOS.
    case watchOS(simulator: Bool)

    /// The SDK name used by the command line interface.
    ///
    /// This is the argument for the `sdk` flag.
    public var commandLineSDKName: String {
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

    /// The platform name used by the command line interface.
    ///
    /// This is the value of the `platform` key for the `destination` flag (without the `generic/` prefix).
    public var commandLineBuildDestinationPlatformName: String {
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
