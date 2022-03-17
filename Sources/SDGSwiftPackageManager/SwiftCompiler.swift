/*
 SwiftCompiler.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGVersioning

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
  import Workspace
  import TSCBasic
#endif

import SDGSwift

extension SwiftCompiler {

  // MARK: - Properties

  private static let compatibleVersions = SDGVersioning.Version(5, 6, 0)...Version(5, 6, 0)

  internal static func swiftCLocation()
    -> Swift.Result<Foundation.URL, VersionedExternalProcessLocationError<SwiftCompiler>>
  {
    // @exempt(from: tests) Unreachable on tvOS.
    return location(versionConstraints: compatibleVersions).map { swift in
      return swift.deletingLastPathComponent().appendingPathComponent("swiftc")
    }
  }
}
