/*
 Git.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGMathematics
import SDGCollections
import SDGText
import SDGExternalProcess
import SDGVersioning

/// Git.
public enum Git: VersionedExternalProcess {

  // MARK: - Static Properties

  public static let _currentMajor: Version = Version(2)
  #if !PLATFORM_LACKS_FOUNDATION_PROCESS
    private static var currentMajor: Version {
      return _currentMajor
    }

    // MARK: - Usage

    /// Creates a local repository by cloning the remote package.
    ///
    /// - Parameters:
    ///     - package: The package to clone.
    ///     - location: The location to create the clone.
    ///     - build: Optional. A specific version to check out.
    ///     - shallow: Optional. Specify `true` to perform a shallow clone. Defaults to `false`. (This may be ignored if the available version of Git is too old.)
    ///     - reportProgress: Optional. A closure to execute for each line of Git’s output.
    @discardableResult public static func clone(
      _ package: Package,
      to location: URL,
      at build: Build = .development,
      shallow: Bool = false,
      reportProgress: (_ progressReport: String) -> Void = { _ in }
    ) -> Result<String, VersionedExternalProcessExecutionError<Git>> {

      var earliest = Version(1, 0, 0)
      var command = [
        "clone",
        package.url.absoluteString,
        location.path,
      ]

      switch build {
      case .version(let stable):
        earliest.increase(to: Version(1, 6, 5))
        command += ["\u{2D}\u{2D}branch", stable.string()]
        let configurationAvailable = Version(1, 7, 7)
        if let resolved = version(
          forConstraints: earliest..<currentMajor.compatibleVersions.upperBound
        ),
          resolved ≥ configurationAvailable
        {
          earliest.increase(to: configurationAvailable)
          command += ["\u{2D}\u{2D}config", "advice.detachedHead=false"]
        }
      case .development:
        break
      }

      if shallow {
        let depthAvailable = Version(1, 5, 0)
        if let resolved = version(
          forConstraints: earliest..<currentMajor.compatibleVersions.upperBound
        ),
          resolved ≥ depthAvailable
        {
          earliest.increase(to: depthAvailable)
          command += ["\u{2D}\u{2D}depth", "1"]
        }
      }

      return runCustomSubcommand(
        command,
        versionConstraints: earliest..<currentMajor.compatibleVersions.upperBound,
        reportProgress: reportProgress
      )
    }

    /// Retrieves the list of available versions of the package.
    ///
    /// - Parameters:
    ///     - package: The package.
    public static func versions(
      of package: Package
    ) -> Result<Set<Version>, VersionedExternalProcessExecutionError<Git>> {
      let version = Version(1, 0, 0)..<currentMajor.compatibleVersions.upperBound
      return runCustomSubcommand(
        [
          "ls\u{2D}remote",
          "\u{2D}\u{2D}tags",
          package.url.absoluteString,
        ],
        versionConstraints: version
      ).map { output in

        var versions: Set<Version> = []
        for line in output.lines {
          let lineText = line.line
          if let tagPrefix = lineText.firstMatch(
            for: "refs/tags/".scalars.literal(for: String.ScalarView.SubSequence.self)
          ) {
            let tag = String(lineText[tagPrefix.range.upperBound...])
            if let version = Version(tag) {
              versions.insert(version)
            }
          }
        }
        return versions
      }
    }

    /// Retrieves the latest commit identifier in the master branch of the package.
    ///
    /// - Parameters:
    ///     - package: The package.
    public static func latestCommitIdentifier(
      in package: Package
    ) -> Result<String, VersionedExternalProcessExecutionError<Git>> {
      let versions = Version(1, 0, 0)..<currentMajor.compatibleVersions.upperBound
      return runCustomSubcommand(
        [
          "ls\u{2D}remote",
          package.url.absoluteString,
          "master",
        ],
        versionConstraints: versions
      ).map { output in
        return output.truncated(before: "\u{9}")
      }
    }
  #endif

  // MARK: - VersionedExternalProcess

  public static var englishName: StrictString { "Git" }
  public static var deutscherNameInDativ: StrictString { "Git" }

  public static var commandName: String { "git" }

  public static var searchCommands: [[String]] {
    [
      ["which", "git"]
    ]
  }

  public static var versionQuery: [String] { ["\u{2D}\u{2D}version"] }
}
