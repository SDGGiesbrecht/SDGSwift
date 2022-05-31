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
import SDGText

import SDGSwift
import SDGSwiftSource

import SymbolKit
#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax
#endif
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

        let graphs = try symbolGraphs(reportProgress: reportProgress).get()
        for graph in graphs {
          print(graph.module)
        }

        for product in package.products where ¬product.name.hasPrefix("_") {
          switch product.type {
          case .library:
            let library = LibraryAPI(_productSkippingModules: product, manifest: manifest)
            for module in product.targets where ¬module.name.hasPrefix("_") {
              reportProgress(
                String(LibraryAPI._reportForParsing(module: StrictString(module.name)).resolved())
              )
              let moduleAPI = try ModuleAPI(
                _module: module,
                manifest: manifest,
                skippingSources: true
              )
              for graph in graphs where graph.module.name == module.name {
                moduleAPI.assimilate(symbolGraph: graph)
              }
              library._children.append(.module(moduleAPI))
            }
            api._children.append(
              .library(
                library
              )
            )
          case .executable, .test, .plugin, .snippet:
            continue
          }
        }

        for library in api.libraries {
          for module in library.modules where ¬api.modules.contains(module) {
            api._children.append(.module(module))
          }
        }

        return api
      }
    #endif
  #endif
}
