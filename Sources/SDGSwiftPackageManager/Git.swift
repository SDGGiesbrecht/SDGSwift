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

import SDGLogic
import SDGMathematics
import SDGCollections
import SDGText
import SDGVersioning

import SDGSwift

extension Git {

  #if !PLATFORM_LACKS_FOUNDATION_PROCESS
    private static var currentMajor: Version {
      return _currentMajor
    }

    /// Initializes a repository with Git.
    ///
    /// - Parameters:
    ///     - repository: The uninitialized repository.
    public static func initialize(
      _ repository: PackageRepository
    ) -> Result<Void, VersionedExternalProcessExecutionError<Git>> {
      var earliestVersion = Version(1, 5, 0)
      var command = ["init"]

      let customizableBranch = Version(2, 27, 0)
      if let resolved = version(
        forConstraints: earliestVersion..<currentMajor.compatibleVersions.upperBound
      ),
        resolved ≥ customizableBranch
      {
        earliestVersion.increase(to: customizableBranch)  // @exempt(from: tests)
        command.append(contentsOf: ["\u{2D}\u{2D}initial\u{2D}branch", "master"])
      }

      return runCustomSubcommand(
        command,
        in: repository.location,
        versionConstraints: earliestVersion..<currentMajor.compatibleVersions.upperBound
      ).map { _ in () }
    }

    /// Checks a branch out.
    ///
    /// - Parameters:
    ///     - branch: The branch to check out.
    ///     - repository: The repository in which to check the branch out.
    public static func checkout(_ branch: String, in repository: PackageRepository) -> Result<
      Void, VersionedExternalProcessExecutionError<Git>
    > {
      let versions = Version(1, 0, 0)..<currentMajor.compatibleVersions.upperBound
      return runCustomSubcommand(
        ["checkout", branch],
        in: repository.location,
        versionConstraints: versions
      ).map { _ in () }
    }

    /// Commits existing changes.
    ///
    /// - Parameters:
    ///     - repository: The repository for which to perform the commit.
    ///     - description: A description for the commit.
    public static func commitChanges(
      in repository: PackageRepository,
      description: StrictString
    ) -> Result<Void, VersionedExternalProcessExecutionError<Git>> {
      let versions = Version(1, 5, 3)..<currentMajor.compatibleVersions.upperBound
      return runCustomSubcommand(
        [
          "add",
          ".",
        ],
        in: repository.location,
        versionConstraints: versions
      ).flatMap { _ in

        return runCustomSubcommand(
          [
            "commit",
            "\u{2D}\u{2D}message",
            String(description),
          ],
          in: repository.location,
          versionConstraints: versions
        ).map { _ in () }
      }
    }

    /// Tags a version.
    ///
    /// - Parameters:
    ///     - releaseVersion: The semantic version.
    ///     - repository: The repository to tag.
    public static func tag(
      version releaseVersion: Version,
      in repository: PackageRepository
    ) -> Result<Void, VersionedExternalProcessExecutionError<Git>> {
      let versions = Version(1, 0, 0)..<currentMajor.compatibleVersions.upperBound
      return runCustomSubcommand(
        [
          "tag",
          releaseVersion.string(),
        ],
        in: repository.location,
        versionConstraints: versions
      ).map { _ in () }
    }

    /// Checks for uncommitted changes or additions in the repository.
    ///
    /// - Parameters:
    ///     - repository: The repository.
    ///
    /// - Returns: The report provided by Git. (An empty string if there are no changes.)
    public static func uncommittedChanges(
      in repository: PackageRepository
    ) -> Result<String, VersionedExternalProcessExecutionError<Git>> {

      let versions = Version(1, 6, 1)..<currentMajor.compatibleVersions.upperBound
      switch runCustomSubcommand(
        [
          "add",
          ".",
          "\u{2D}\u{2D}intent\u{2D}to\u{2D}add",
        ],
        in: repository.location,
        versionConstraints: versions
      ) {
      case .failure(let error):
        return .failure(error)
      case .success:
        break
      }

      return runCustomSubcommand(["diff"], in: repository.location, versionConstraints: versions)
    }

    /// Returns the list of files ignored by source control.
    ///
    /// - Parameters:
    ///     - repository: The repository.
    public static func ignoredFiles(
      in repository: PackageRepository
    ) -> Result<[URL], VersionedExternalProcessExecutionError<Git>> {
      let versions = Version(1, 7, 7)..<currentMajor.compatibleVersions.upperBound
      return runCustomSubcommand(
        [
          "status",
          "\u{2D}\u{2D}ignored",
          "\u{2D}\u{2D}porcelain",
        ],
        in: repository.location,
        versionConstraints: versions
      ).map { ignoredSummary in
        let indicator = Array("!! ".scalars)
        var result: [URL] = []
        for line in ignoredSummary.lines.lazy.map({ $0.line })
        where line.hasPrefix(indicator.literal(for: String.ScalarView.SubSequence.self)) {
          var relativePath = String(line.dropFirst(indicator.count))
          if relativePath.hasPrefix("\u{22}"),
            relativePath.dropFirst().hasSuffix("\u{22}")
          {  // @exempt(from: tests) Depends on version of Git available.
            relativePath.removeFirst()
            relativePath.removeLast()

            let octal: Set<UTF8.CodeUnit> = Set(0x30..<0x38)
            var utf8 = Array(relativePath.utf8)
            utf8.mutateMatches(
              for: [0x5C] + RepetitionPattern(ConditionalPattern({ $0 ∈ octal }), count: 3...3)
            ) { (match) -> [UTF8.CodeUnit] in
              let escapeScalars = match.contents.dropFirst().lazy.map({ Unicode.Scalar($0) })
              let escape = String(String.UnicodeScalarView(escapeScalars))
              let integer = UTF8.CodeUnit(escape, radix: 8)!
              return [integer]
            }
            relativePath = String(decoding: utf8, as: UTF8.self)
          }
          result.append(repository.location.appendingPathComponent(relativePath))
        }
        return result
      }
    }
  #endif
}
