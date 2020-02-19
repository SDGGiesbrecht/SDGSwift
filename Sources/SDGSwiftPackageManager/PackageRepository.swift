/*
 PackageRepository.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGText
import SDGLocalization
import SDGVersioning

#if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftPM won’t compile.)
  import PackageModel
  import Build
  import Workspace
#endif

import SDGSwift
import SDGSwiftLocalizations

extension PackageRepository {

  // MARK: - Initialization

  #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftPM won’t compile.)
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

  #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftPM won’t compile.)
    /// Returns the package manifest.
    public func manifest() -> Swift.Result<Manifest, SwiftCompiler.PackageLoadingError> {
      return SwiftCompiler.withDiagnostics { compiler, _ in
        return try ManifestLoader.loadManifest(
          packagePath: AbsolutePath(location.path),
          swiftCompiler: AbsolutePath(compiler.path)
        )
      }
    }

    /// Returns the package structure.
    public func package() -> Swift.Result<PackageModel.Package, SwiftCompiler.PackageLoadingError> {
      return SwiftCompiler.withDiagnostics { compiler, diagnostics in
        return try PackageBuilder.loadPackage(
          packagePath: AbsolutePath(location.path),
          swiftCompiler: AbsolutePath(compiler.path),
          diagnostics: diagnostics
        )
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

    internal func hostBuildParameters() -> Swift.Result<
      BuildParameters, SwiftCompiler.PackageLoadingError
    > {
      switch packageWorkspace() {
      case .failure(let error):
        return .failure(error)
      case .success(let workspace):
        switch SwiftCompiler.hostToolchain() {
        case .failure(let error):
          return .failure(error)
        case .success(let toolchain):
          return .success(
            BuildParameters(
              dataPath: workspace.dataPath,
              configuration: .debug,
              toolchain: toolchain,
              flags: BuildFlags()
            )
          )
        }
      }
    }

    /// Returns the package graph.
    public func packageGraph() -> Swift.Result<PackageGraph, SwiftCompiler.PackageLoadingError> {
      return SwiftCompiler.withDiagnostics { compiler, diagnostics in
        return try Workspace.loadGraph(
          packagePath: AbsolutePath(location.path),
          swiftCompiler: AbsolutePath(compiler.path),
          diagnostics: diagnostics
        )
      }
    }
  #endif

  /// Checks for uncommitted changes or additions.
  ///
  /// - Returns: The report provided by Git. (An empty string if there are no changes.)
  public func uncommittedChanges() -> Swift.Result<
    String, VersionedExternalProcessExecutionError<SDGSwift.Git>
  > {
    return Git.uncommittedChanges(in: self)
  }

  /// Returns the list of files ignored by source control.
  public func ignoredFiles() -> Swift.Result<
    [Foundation.URL], VersionedExternalProcessExecutionError<SDGSwift.Git>
  > {
    return Git.ignoredFiles(in: self)
  }

  #if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftPM won’t compile.)
    public func _directoriesIgnoredForTestCoverage() -> Swift.Result<
      [Foundation.URL], SwiftCompiler.PackageLoadingError
    > {
      return packageWorkspace().map { workspace in
        return [
          workspace.dataPath.asURL,
          workspace.editablesPath.asURL
        ]
      }
    }

    /// Returns the code coverage report for the package.
    ///
    /// - Parameters:
    ///     - ignoreCoveredRegions: Optional. Set to `true` if only coverage gaps are significant. When `true`, covered regions will be left out of the report, resulting in faster parsing.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///     - progressReport: A line of output.
    ///
    /// - Returns: The report, or `nil` if there is no code coverage information.
    public func codeCoverageReport(
      ignoreCoveredRegions: Bool = false,
      reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress
    ) -> Swift.Result<TestCoverageReport?, SwiftCompiler.CoverageReportingError> {
      return SwiftCompiler.codeCoverageReport(
        for: self,
        ignoreCoveredRegions: ignoreCoveredRegions,
        reportProgress: reportProgress
      )
    }
  #endif

  // MARK: - Workflow

  /// Checks out a branch.
  ///
  /// - Parameters:
  ///     - branch: The branch to check out.
  public func checkout(_ branch: String) -> Swift.Result<
    Void, VersionedExternalProcessExecutionError<SDGSwift.Git>
  > {
    return Git.checkout(branch, in: self)
  }

  /// Commits existing changes.
  ///
  /// - Parameters:
  ///     - description: A description for the commit.
  public func commitChanges(description: StrictString) -> Swift.Result<
    Void, VersionedExternalProcessExecutionError<SDGSwift.Git>
  > {
    return Git.commitChanges(in: self, description: description)
  }

  /// Tags a version.
  ///
  /// - Parameters:
  ///     - releaseVersion: The semantic version.
  public func tag(version releaseVersion: SDGVersioning.Version) -> Swift.Result<
    Void, VersionedExternalProcessExecutionError<SDGSwift.Git>
  > {
    return Git.tag(version: releaseVersion, in: self)
  }
}
