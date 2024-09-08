/*
 Package.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGCollections

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
  import PackageModel

  extension Package {

    internal func publicModules() -> [Target] {
      let publicModules = manifest.publicModules()
      return targets.filter({ $0.name ∈ publicModules })
    }

    internal func publicModuleSources() -> [String: [URL]] {
      return Dictionary(
        publicModules().map({ module in
          return (
            module.name,
            module.sources.paths.lazy.map({ URL(fileURLWithPath: $0.pathString) })
          )
        }),
        uniquingKeysWith: { first, _ in first }  // @exempt(from: tests)
      )
    }
  }
#endif
