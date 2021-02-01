/*
 SwiftCompiler.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGVersioning

// #workaround(Swift 5.3.2, SwiftPM won’t compile.)
#if !(os(Windows) || os(WASI) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
  import Workspace
#endif

import SDGSwift

extension SwiftCompiler {

  // MARK: - Properties

  private static let compatibleVersions = SDGVersioning.Version(5, 3, 0)...Version(5, 3, 3)

  internal static func swiftCLocation()
    -> Swift.Result<Foundation.URL, VersionedExternalProcessLocationError<SwiftCompiler>>
  {
    // @exempt(from: tests) Unreachable on tvOS.
    return location(versionConstraints: compatibleVersions).map { swift in
      return swift.deletingLastPathComponent().appendingPathComponent("swiftc")
    }
  }

  // #workaround(Swift 5.3.2, SwiftPM won’t compile.)
  #if !(os(Windows) || os(WASI) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
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
}
