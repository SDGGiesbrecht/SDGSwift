/*
 SwiftCompiler.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(WASI)  // #workaround(workspace version 0.32.1, Web lacks Foundation.)
  import Foundation
#endif

import SDGVersioning

// #workaround(workspace version 0.32.0, SwiftPM won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  import TSCBasic
  import Workspace
#endif

import SDGSwift

extension SwiftCompiler {

  // MARK: - Properties

  private static let compatibleVersions = SDGVersioning.Version(5, 2, 0)...Version(5, 2, 1)

  #if !os(WASI)  // #workaround(workspace version 0.32.1, Web lacks Foundation.)
    internal static func swiftCLocation()
      -> Swift.Result<Foundation.URL, VersionedExternalProcessLocationError<SwiftCompiler>>
    {
      return location(versionConstraints: compatibleVersions).map { swift in
        return swift.deletingLastPathComponent().appendingPathComponent("swiftc")
      }
    }

    // #workaround(workspace version 0.32.0, SwiftPM won’t compile.)
    #if !(os(Windows) || os(Android))
      internal static func withDiagnostics<T>(
        _ closure: (_ compiler: Foundation.URL, _ diagnostics: DiagnosticsEngine) throws -> T
      ) -> Swift.Result<T, PackageLoadingError> {
        switch SwiftCompiler.swiftCLocation() {
        case .failure(let error):
          return .failure(.swiftLocationError(error))
        case .success(let compiler):
          let diagnostics = DiagnosticsEngine()
          do {
            let result = try closure(compiler, diagnostics)
            if diagnostics.hasErrors {
              return .failure(.packageManagerError(nil, diagnostics.diagnostics))
            }
            return .success(result)
          } catch {
            return .failure(.packageManagerError(error, diagnostics.diagnostics))
          }
        }
      }

      private static func manifestResourceProvider()
        -> Swift.Result<ManifestResourceProvider, PackageLoadingError>
      {
        return withDiagnostics { compiler, _ in
          return try UserManifestResources(swiftCompiler: AbsolutePath(compiler.path))
        }
      }

      internal static func manifestLoader() -> Swift.Result<ManifestLoader, PackageLoadingError> {
        return manifestResourceProvider().map { ManifestLoader(manifestResources: $0) }
      }
    #endif
  #endif
}
