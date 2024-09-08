/*
 Manifest.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

import OrderedCollections

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
  import PackageModel

    import SwiftSyntax

  extension Manifest {

      internal func publicLibraries(manifestURL: String, manifest: SourceFileSyntax) -> [LibraryAPI]
      {
        return products.compactMap { product in
          if product.name.hasPrefix("_") {
            return nil
          }
          switch product.type {
          case .library:
            return LibraryAPI(
              name: product.name,
              modules: product.targets.filter({ ¬$0.hasPrefix("_") }),
              manifestURL: manifestURL,
              manifest: manifest
            )
          default:
            return nil
          }
        }
      }

    internal func publicModules() -> OrderedSet<String> {
      return OrderedSet(
        products
          .lazy.filter({ ¬$0.name.hasPrefix("_") })
          .flatMap({ (product) -> [String] in
            switch product.type {
            case .library:
              return product.targets
                .lazy.filter { ¬$0.hasPrefix("_") }
            case .executable, .snippet, .plugin, .test:
              return []
            }
          })
      )
    }
  }
#endif
