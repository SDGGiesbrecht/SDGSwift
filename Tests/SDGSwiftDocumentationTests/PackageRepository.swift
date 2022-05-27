/*
 PackageRepository.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic

import SDGSwift
import SDGSwiftSource

import SymbolKit
import SwiftSyntax
#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
  import SwiftSyntaxParser
#endif

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
  import PackageModel
#endif

extension PackageRepository {

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
      func api(
        reportProgress: (_ progressReport: String) -> Void = { _ in }
      ) throws -> PackageAPI {
        let package = try self.package().get()
        let manifestURL = URL(fileURLWithPath: package.manifest.path.pathString)
        let manifest = try SyntaxParser.parseAndRetry(manifestURL)
        let documentation = try PackageAPI.documentation(for: package)
        let declaration = FunctionCallExprSyntax._normalizedPackageDeclaration(
          name: package.manifest.displayName
        )
        let api = PackageAPI(_documentation: documentation, declaration: declaration)

        for product in package.products where ¬product.name.hasPrefix("_") {
          switch product.type {
          case .library:
            api._children.append(
              .library(
                LibraryAPI(_productSkippingModules: product, manifest: manifest)
              )
            )
          case .executable, .test, .plugin, .snippet:
            continue
          }
        }

        return api
      }
    #endif
  #endif
}
