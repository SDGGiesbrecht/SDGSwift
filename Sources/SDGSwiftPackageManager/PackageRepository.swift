/*
 PackageRepository.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGText
import SDGLocalization
import SDGVersioning

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
  import PackageModel
  import Workspace
  import TSCBasic
#endif

import SDGSwift

import SDGSwiftLocalizations

extension PackageRepository {

  // MARK: - Initialization

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
    /// Creates a new package by initializing it at the specified URL.
    ///
    /// - Parameters:
    ///     - location: The location at which to initialize the new package.
    ///     - name: A name for the package.
    ///     - type: The type of package.
    public static func initializePackage(
      at location: Foundation.URL,
      named name: StrictString,
      type: InitPackage.PackageType
    ) -> Swift.Result<PackageRepository, InitializationError> {

      let repository = PackageRepository(at: location)

      do {
        let initializer = try InitPackage(
          name: String(name),
          destinationPath: AbsolutePath(location.path),
          packageType: type
        )
        try initializer.writePackageStructure()
      } catch {
        return .failure(.packageManagerError(error))
      }

      switch Git.initialize(repository) {
      case .failure(let error):
        return .failure(.gitError(error))
      case .success:
        break
      }
      switch repository.commitChanges(
        description: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishUnitedKingdom:
            return "Initialised."
          case .englishUnitedStates, .englishCanada:
            return "Initialized."
          case .deutschDeutschland:
            return "Stellte vorein."
          }
        }).resolved()
      ) {
      case .failure(let error):
        return .failure(.gitError(error))
      case .success:
        return .success(repository)
      }
    }
  #endif

  // MARK: - Properties

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
    /// Returns the package manifest.
    public func manifest() -> Swift.Result<Manifest, SwiftCompiler.PackageLoadingError> {
      return SwiftCompiler.withDiagnostics { compiler, _ in
        return try tsc_await { completion in
          ManifestLoader.loadManifest(
            packagePath: AbsolutePath(location.path),
            swiftCompiler: AbsolutePath(compiler.path),
            swiftCompilerFlags: [],
            packageKind: .root,
            on: .global(),
            completion: completion
          )
        }
      }
    }

    /// Returns the package structure.
    public func package() -> Swift.Result<PackageModel.Package, SwiftCompiler.PackageLoadingError> {
      return SwiftCompiler.withDiagnostics { compiler, diagnostics in
        return try tsc_await { completion in
          PackageBuilder.loadPackage(
            packagePath: AbsolutePath(location.path),
            swiftCompiler: AbsolutePath(compiler.path),
            swiftCompilerFlags: [],
            diagnostics: diagnostics,
            on: .global(),
            completion: completion
          )
        }
      }
    }

    /// Returns the package workspace.
    public func packageWorkspace() -> Swift.Result<Workspace, SwiftCompiler.PackageLoadingError> {
      return SwiftCompiler.manifestLoader().map { loader in
        return Workspace.create(
          forRootPackage: AbsolutePath(location.path),
          manifestLoader: loader
        )
      }
    }

    /// Returns the package graph.
    public func packageGraph() -> Swift.Result<PackageGraph, SwiftCompiler.PackageLoadingError> {
      return SwiftCompiler.withDiagnostics { compiler, diagnostics in
        return try Workspace.loadGraph(
          packagePath: AbsolutePath(location.path),
          swiftCompiler: AbsolutePath(compiler.path),
          swiftCompilerFlags: [],
          diagnostics: diagnostics
        )
      }
    }
  #endif

  #if !PLATFORM_LACKS_FOUNDATION_PROCESS
    /// Checks for uncommitted changes or additions.
    ///
    /// - Returns: The report provided by Git. (An empty string if there are no changes.)
    public func uncommittedChanges()
      -> Swift.Result<String, VersionedExternalProcessExecutionError<SDGSwift.Git>>
    {
      return Git.uncommittedChanges(in: self)
    }

    /// Returns the list of files ignored by source control.
    public func ignoredFiles()
      -> Swift.Result<[Foundation.URL], VersionedExternalProcessExecutionError<SDGSwift.Git>>
    {
      return Git.ignoredFiles(in: self)
    }

    // MARK: - Workflow

    /// Checks out a branch.
    ///
    /// - Parameters:
    ///     - branch: The branch to check out.
    public func checkout(
      _ branch: String
    ) -> Swift.Result<Void, VersionedExternalProcessExecutionError<SDGSwift.Git>> {
      return Git.checkout(branch, in: self)
    }

    /// Commits existing changes.
    ///
    /// - Parameters:
    ///     - description: A description for the commit.
    public func commitChanges(
      description: StrictString
    ) -> Swift.Result<Void, VersionedExternalProcessExecutionError<SDGSwift.Git>> {
      return Git.commitChanges(in: self, description: description)
    }

    /// Tags a version.
    ///
    /// - Parameters:
    ///     - releaseVersion: The semantic version.
    public func tag(
      version releaseVersion: SDGVersioning.Version
    ) -> Swift.Result<Void, VersionedExternalProcessExecutionError<SDGSwift.Git>> {
      return Git.tag(version: releaseVersion, in: self)
    }
  #endif
}
