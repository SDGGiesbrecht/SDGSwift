/*
 SwiftCompiler.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGSwift

import SymbolKit

extension SwiftCompiler {

  /// Assembles documentation components into a completed documentation site.
  ///
  /// - Parameters:
  ///   - outputDirectory: The directory in which to generate the site.
  ///   - name: A name for the DocC bundle.
  ///   - symbolGraphs: The symbol graphs to include.
  ///   - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
  public static func assembleDocumentation(
    in outputDirectory: URL,
    name: String,
    symbolGraphs: [SymbolGraph],
    hostingBasePath: String,
    reportProgress: (_ progressReport: String) -> Void = { _ in }
  ) -> Result<String, VersionedExternalProcessExecutionError<SwiftCompiler>> {
    do {
      return try FileManager.default.withTemporaryDirectory(appropriateFor: outputDirectory) { symbolGraphDirectory in
        var graphURLs: [URL] = []
        for (index, graph) in symbolGraphs.enumerated() {
          let url = symbolGraphDirectory
            .appendingPathComponent(String(index.inDigits()))
            .appendingPathExtension("symbols.json")
          try graph.save(
            to: url
          )
          graphURLs.append(url)
        }

        return assembleDocumentation(
          in: outputDirectory,
          name: name,
          symbolGraphs: graphURLs,
          hostingBasePath: hostingBasePath,
          reportProgress: reportProgress
        )
      }
    } catch {
      return .failure(.executionError(.foundationError(error)))
    }
  }
}
