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

import SDGControlFlow

/// A local repository containing a Swift package.
public struct PackageRepository: TransparentWrapper {

  // MARK: - Initialization

  /// Creates an instance describing an existing package repository.
  ///
  /// - Parameters:
  ///     - location: The local directory where the package repository already resides.
  public init(at location: URL) {
    self.location = location
  }

  #if !(os(tvOS) || os(iOS) || os(watchOS))
    #if !os(WASI)  // #workaround(Swift 5.3.2, Web lacks Process.)
      /// Creates a local repository by cloning a remote package.
      ///
      /// - Parameters:
      ///     - package: The package to clone.
      ///     - location: The location to create the clone.
      ///     - build: Optional. A specific version to check out.
      ///     - shallow: Optional. Specify `true` to perform a shallow clone. Defaults to `false`. (This may be ignored if the available version of Git is too old.)
      ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
      ///     - progressReport: A line of output.
      public static func clone(
        _ package: Package,
        to location: URL,
        at build: Build = .development,
        shallow: Bool = false,
        reportProgress: (_ progressReport: String) -> Void = { _ in }
      ) -> Result<PackageRepository, VersionedExternalProcessExecutionError<Git>> {

        let repository = PackageRepository(at: location)
        switch Git.clone(
          package,
          to: location,
          at: build,
          shallow: shallow,
          reportProgress: reportProgress
        ) {
        case .failure(let error):
          return .failure(error)
        case .success:
          return .success(repository)
        }
      }
    #endif
  #endif

  // MARK: - Properties

  /// The location of the repository.
  public let location: URL

  #if !(os(tvOS) || os(iOS) || os(watchOS))
    #if !os(WASI)  // #workaround(Swift 5.3.2, Web lacks Process.)
      /// The directory to which products are built.
      ///
      /// - Parameters:
      ///     - releaseConfiguration: Whether or not the sought directory is for the release configuration.
      public func productsDirectory(
        releaseConfiguration: Bool
      ) -> Result<URL, VersionedExternalProcessExecutionError<SwiftCompiler>> {
        return SwiftCompiler.productsDirectory(
          for: self,
          releaseConfiguration: releaseConfiguration
        )
      }

      // MARK: - Workflow

      /// Builds the package.
      ///
      /// - Parameters:
      ///     - releaseConfiguration: Optional. Whether or not to build in the release configuration. Defaults to `false`, i.e. the default debug configuration.
      ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
      ///     - progressReport: A line of output.
      @discardableResult public func build(
        releaseConfiguration: Bool = false,
        reportProgress: (_ progressReport: String) -> Void = { _ in }
      ) -> Result<String, VersionedExternalProcessExecutionError<SwiftCompiler>> {
        return SwiftCompiler.build(
          self,
          releaseConfiguration: releaseConfiguration,
          reportProgress: reportProgress
        )
      }

      /// Runs a target in place.
      ///
      /// - Parameters:
      ///     - target: The target to run.
      ///     - arguments: The arguments to supply to the target.
      ///     - environment: Optional. A different set of environment variables.
      ///     - releaseConfiguration: Optional. Whether or not to build in the release configuration. Defaults to `false`, i.e. the default debug configuration.
      ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
      ///     - progressReport: A line of output.
      @discardableResult public func run(
        _ target: String,
        arguments: [String] = [],
        environment: [String: String]? = nil,
        releaseConfiguration: Bool = false,
        reportProgress: (_ progressReport: String) -> Void = { _ in }
      ) -> Result<String, VersionedExternalProcessExecutionError<SwiftCompiler>> {
        SwiftCompiler.run(
          target,
          from: self,
          arguments: arguments,
          environment: environment,
          releaseConfiguration: releaseConfiguration,
          reportProgress: reportProgress
        )
      }

      /// Tests the package.
      ///
      /// - Parameters:
      ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
      ///     - progressReport: A line of output.
      @discardableResult public func test(
        reportProgress: (_ progressReport: String) -> Void = { _ in }
      ) -> Result<String, VersionedExternalProcessExecutionError<SwiftCompiler>> {
        return SwiftCompiler.test(self, reportProgress: reportProgress)
      }

      public func _directoriesIgnoredForTestCoverage() -> [Foundation.URL] {
        return [
          ".build",
          "Packages",
        ].map { location.appendingPathComponent($0) }
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
        reportProgress: (_ progressReport: String) -> Void = { _ in }
      ) -> Swift.Result<TestCoverageReport?, SwiftCompiler.CoverageReportingError> {
        return SwiftCompiler.codeCoverageReport(
          for: self,
          ignoreCoveredRegions: ignoreCoveredRegions,
          reportProgress: reportProgress
        )
      }

      /// Resolves the package, fetching its dependencies.
      ///
      /// - Parameters:
      ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
      ///     - progressReport: A line of output.
      @discardableResult public func resolve(
        reportProgress: (_ progressReport: String) -> Void = { _ in }
      ) -> Result<String, VersionedExternalProcessExecutionError<SwiftCompiler>> {
        return SwiftCompiler.resolve(self, reportProgress: reportProgress)
      }
    #endif
  #endif

  // MARK: - TransparentWrapper

  public var wrappedInstance: Any {
    return location.path
  }
}
