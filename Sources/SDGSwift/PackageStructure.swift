/*
 PackageStructure.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGLogic
import SDGCollections
import SDGText
import SDGExternalProcess
import SDGVersioning

/// A remote Swift package.
public struct Package: TransparentWrapper {

  // MARK: - Initialization

  /// Creates an instance describing the package at the specified url.
  ///
  /// - Parameters:
  ///     - url: The package URL.
  public init(url: URL) {
    self.url = url
  }

  // MARK: - Properties

  /// The URL of the package.
  public let url: URL

  #if !PLATFORM_LACKS_FOUNDATION_PROCESS
    /// Retrieves the list of available versions.
    public func versions() -> Result<Set<Version>, VersionedExternalProcessExecutionError<Git>> {
      return Git.versions(of: self)
    }

    /// Retrieves the latest commit identifier in the master branch of the package.
    public func latestCommitIdentifier() -> Result<
      String, VersionedExternalProcessExecutionError<Git>
    > {
      return Git.latestCommitIdentifier(in: self)
    }
  #endif

  // MARK: - Workflow

  #if !PLATFORM_LACKS_FOUNDATION_PROCESS
    /// Retrieves the package, builds it, and copies its products to the specified destination.
    ///
    /// - Parameters:
    ///     - build: The version to build.
    ///     - destination: The directory to put the products in.
    ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
    public func build(
      _ build: Build,
      to destination: URL,
      reportProgress: (_ progressReport: String) -> Void = { _ in }
    ) -> Result<Void, BuildError> {

      return FileManager.default
        .withTemporaryDirectory(appropriateFor: destination) { temporaryDirectory in
          let temporaryCloneLocation = temporaryDirectory.appendingPathComponent(
            url.lastPathComponent
          )

          reportProgress("")

          switch PackageRepository.clone(
            self,
            to: temporaryCloneLocation,
            at: build,
            shallow: true,
            reportProgress: reportProgress
          ) {

          case .failure(let error):
            return .failure(.gitError(error))
          case .success(let temporaryRepository):

            reportProgress("")

            switch temporaryRepository.build(
              releaseConfiguration: true,
              reportProgress: reportProgress
            )
            {
            case .failure(let error):
              return .failure(.swiftError(error))
            case .success:
              let products: URL
              switch temporaryRepository.productsDirectory(releaseConfiguration: true) {
              case .failure(let error):
                return .failure(.swiftError(error))
              case .success(let directory):
                products = directory
              }

              let enumeratedProducts: [URL]
              do {
                enumeratedProducts = try FileManager.default.contentsOfDirectory(
                  at: products,
                  includingPropertiesForKeys: nil,
                  options: []
                )
              } catch {
                return .failure(.foundationError(error))
              }

              let intermediateDirectory = temporaryDirectory.appendingPathComponent(
                UUID().uuidString
              )
              for component in enumeratedProducts {
                let filename = component.lastPathComponent

                if filename ≠ "ModuleCache",
                  filename ≠ "plugins",
                  ¬filename.hasSuffix(".a"),
                  ¬filename.hasSuffix(".build"),
                  ¬filename.hasSuffix(".dSYM"),
                  ¬filename.hasSuffix(".json"),
                  ¬filename.hasSuffix(".product"),
                  ¬filename.hasSuffix(".swiftdoc"),
                  ¬filename.hasSuffix(".swiftmodule"),
                  ¬filename.hasSuffix(".swiftsourceinfo")
                {

                  do {
                    try FileManager.default.move(
                      component,
                      to: intermediateDirectory.appendingPathComponent(filename)
                    )
                  } catch {
                    return .failure(.foundationError(error))
                  }
                }
              }

              do {
                try FileManager.default.move(intermediateDirectory, to: destination)
              } catch {
                return .failure(.foundationError(error))
              }

              return .success(())
            }
          }
        }
    }

    private func developmentCache(for cache: URL) -> URL {
      return cache.appendingPathComponent("Development")
    }

    private func cacheDirectory(
      in cache: URL,
      for version: Build
    ) -> Result<URL, VersionedExternalProcessExecutionError<Git>> {
      switch version {
      case .version(let specific):
        return .success(cache.appendingPathComponent(specific.string()))
      case .development:
        return latestCommitIdentifier().map { identifier in
          return developmentCache(for: cache).appendingPathComponent(identifier)
        }
      }
    }

    /// Retrieves, builds and runs a command line tool defined by a Swift package.
    ///
    /// - Parameters:
    ///     - build: The version to build.
    ///     - executableNames: The name of the executable file. Multiple names can be supplied if the package defines localized products which are essentially the same executable.
    ///     - arguments: The arguments to send to the executable.
    ///     - cacheDirectory: Optional. A directory to store the executable in for future use. If the executable is already in the cache, the cached version will be used instead of fetching and rebuilding.
    ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
    @discardableResult public func execute(
      _ build: Build,
      of executableNames: Set<StrictString>,
      with arguments: [String],
      cacheDirectory: URL?,
      reportProgress: (_ progressReport: String) -> Void = { _ in }
    ) -> Result<String, ExecutionError> {

      return FileManager.default
        .withTemporaryDirectory(appropriateFor: nil) { temporaryDirectory in
          let cacheRoot = cacheDirectory ?? temporaryDirectory  // @exempt(from: tests)
          switch self.cacheDirectory(in: cacheRoot, for: build) {
          case .failure(let error):
            return .failure(.gitError(error))
          case .success(let cache):
            if ¬FileManager.default.fileExists(atPath: cache.path) {

              switch build {
              case .development:
                // Clean up older builds.
                try? FileManager.default.removeItem(at: developmentCache(for: cacheRoot))
              case .version:
                break
              }

              switch self.build(build, to: cache, reportProgress: reportProgress) {
              case .failure(let error):
                return .failure(.buildError(error))
              case .success:
                break
              }
            }

            let cacheContents: [URL]
            do {
              cacheContents = try FileManager.default.contentsOfDirectory(
                at: cache,
                includingPropertiesForKeys: nil,
                options: []
              )
            } catch {
              return .failure(.foundationError(error))
            }
            for executable in cacheContents
            where StrictString(executable.lastPathComponent) ∈ executableNames {

              #if os(Linux)
                // The move from the temporary directory to the cache may lose permissions.
                if ¬FileManager.default.isExecutableFile(atPath: executable.path) {
                  // @exempt(from: tests)
                  _ = try? Shell.default.run(command: ["chmod", "+x", executable.path]).get()
                }
              #endif

              reportProgress("")
              reportProgress(
                "$ " + executable.lastPathComponent + " " + arguments.joined(separator: " ")
              )
              return ExternalProcess(at: executable).run(
                arguments,
                reportProgress: reportProgress
              ).mapError { error in
                return .executionError(error)
              }
            }
            return .failure(.noSuchExecutable(requested: executableNames))
          }
        }
    }
  #endif

  // MARK: - TransparentWrapper

  public var wrappedInstance: Any {
    return url
  }
}
