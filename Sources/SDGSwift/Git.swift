/*
 Git.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGCollections
import SDGText
import SDGExternalProcess
import SDGVersioning

/// Git.
public enum Git : VersionedExternalProcess {

  // MARK: - Usage

  /// Creates a local repository by cloning the remote package.
  ///
  /// - Parameters:
  ///     - package: The package to clone.
  ///     - location: The location to create the clone.
  ///     - build: Optional. A specific version to check out.
  ///     - shallow: Optional. Specify `true` to perform a shallow clone. Defaults to `false`.
  ///     - reportProgress: Optional. A closure to execute for each line of output.
  ///     - progressReport: A line of output.
  @discardableResult public static func clone(_ package: Package, to location: URL, at build: Build = .development, shallow: Bool = false, reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) -> Result<String, VersionedExternalProcessExecutionError<Git>> {

    var command = [
      "clone",
      package.url.absoluteString,
      location.path
    ]

    switch build {
    case .version(let stable):
      command += ["\u{2D}\u{2D}branch", stable.string()]
      command += ["\u{2D}\u{2D}config", "advice.detachedHead=false"]
    case .development:
      break
    }

    if shallow {
      command += ["\u{2D}\u{2D}depth", "1"]
    }

    return runCustomSubcommand(command, reportProgress: reportProgress)
  }

  /// Retrieves the list of available versions of the package.
  ///
  /// - Parameters:
  ///     - package: The package.
  public static func versions(of package: Package) -> Result<Set<Version>, VersionedExternalProcessExecutionError<Git>> {
    return runCustomSubcommand([
      "ls\u{2D}remote",
      "\u{2D}\u{2D}tags",
      package.url.absoluteString
    ]).map { output in

      var versions: Set<Version> = []
      for line in output.lines {
        let lineText = line.line
        if let tagPrefix = lineText.firstMatch(for: "refs/tags/".scalars) {
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
  public static func latestCommitIdentifier(in package: Package) -> Result<String, VersionedExternalProcessExecutionError<Git>> {
    return runCustomSubcommand([
      "ls\u{2D}remote",
      package.url.absoluteString,
      "master"
    ]).map { output in
      return output.truncated(before: "\u{9}")
    }
  }

  // MARK: - VersionedExternalProcess

  public static let englishName: StrictString = "Git"
  public static var deutscherNameInDativ: StrictString = "Git"

  public static var commandName: String = "git"

  #warning("Remove this.")
  public static let compatibleVersionRange: Range<Version> = Version(1, 9, 0) ..< Version(2).compatibleVersions.upperBound

  public static let searchCommands: [[String]] = [
    ["which", "git"]
  ]

  public static let versionQuery: [String] = ["\u{2D}\u{2D}version"]
}
