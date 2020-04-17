/*
 Git.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(WASI)  // #workaround(Swift 5.2.2, Web lacks Foundation.)
  import Foundation

  import SDGLogic
  import SDGText
  import SDGVersioning

  import SDGSwift

  extension Git {

    private static var currentMajor: Version {
      return _currentMajor
    }

    /// Initializes a repository with Git.
    ///
    /// - Parameters:
    ///     - repository: The uninitialized repository.
    public static func initialize(_ repository: PackageRepository) -> Result<
      Void, VersionedExternalProcessExecutionError<Git>
    > {
      let versions = Version(1, 5, 0)..<currentMajor.compatibleVersions.upperBound
      return runCustomSubcommand(["init"], in: repository.location, versionConstraints: versions)
        .map { _ in () }
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
      ).map { _ in

        return runCustomSubcommand(
          [
            "commit",
            "\u{2D}\u{2D}message",
            String(description),
          ],
          in: repository.location,
          versionConstraints: versions
        )
      }
    }

    /// Tags a version.
    ///
    /// - Parameters:
    ///     - releaseVersion: The semantic version.
    ///     - repository: The repository to tag.
    public static func tag(version releaseVersion: Version, in repository: PackageRepository)
      -> Result<Void, VersionedExternalProcessExecutionError<Git>>
    {
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
    public static func ignoredFiles(in repository: PackageRepository) -> Result<
      [URL], VersionedExternalProcessExecutionError<Git>
    > {
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
        where line.hasPrefix(indicator) {
          let relativePath = String(line.dropFirst(indicator.count))
          result.append(repository.location.appendingPathComponent(relativePath))
        }
        return result
      }
    }
  }
#endif
