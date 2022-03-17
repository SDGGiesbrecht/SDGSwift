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

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
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

    @available(macOS 10.15, *)
    private static func manifestResourceProvider()
      -> Swift.Result<ManifestResourceProvider, PackageLoadingError>
    {
      return withDiagnostics { compiler, _ in
        return try UserManifestResources(
          swiftCompiler: AbsolutePath(compiler.path),
          swiftCompilerFlags: []
        )
      }
    }

    @available(macOS 10.15, *)
    internal static func manifestLoader() -> Swift.Result<ManifestLoader, PackageLoadingError> {
      return manifestResourceProvider().map { ManifestLoader(manifestResources: $0) }
    }
  #endif
}
