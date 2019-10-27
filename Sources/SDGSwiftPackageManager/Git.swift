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

import SDGLogic
import SDGText
import SDGVersioning

import SDGSwift

extension Git {

    /// Initializes a repository with Git.
    ///
    /// - Parameters:
    ///     - repository: The uninitialized repository.
    public static func initialize(_ repository: PackageRepository) -> Result<Void, Git.Error> {
        return runCustomSubcommand(["init"], in: repository.location).map { _ in () }
    }

    /// Commits existing changes.
    ///
    /// - Parameters:
    ///     - repository: The repository for which to perform the commit.
    ///     - description: A description for the commit.
    public static func commitChanges(
        in repository: PackageRepository,
        description: StrictString) -> Result<Void, Git.Error> {
        return runCustomSubcommand([
            "add",
            "."
            ], in: repository.location).map { _ in

                return runCustomSubcommand([
                    "commit",
                    "\u{2D}\u{2D}message",
                    String(description)
                    ], in: repository.location)
        }
    }

    /// Tags a version.
    ///
    /// - Parameters:
    ///     - releaseVersion: The semantic version.
    ///     - repository: The repository to tag.
    public static func tag(version releaseVersion: Version, in repository: PackageRepository) -> Result<Void, Git.Error> {
        return runCustomSubcommand([
            "tag",
            releaseVersion.string()
            ], in: repository.location).map { _ in () }
    }

    /// Checks for uncommitted changes or additions in the repository.
    ///
    /// - Parameters:
    ///     - repository: The repository.
    ///     - exclusionPatterns: Patterns describing paths or files to ignore.
    ///
    /// - Returns: The report provided by Git. (An empty string if there are no changes.)
    public static func uncommittedChanges(
        in repository: PackageRepository,
        excluding exclusionPatterns: [String] = []) -> Result<String, Git.Error> {

        switch runCustomSubcommand([
            "add",
            ".",
            "\u{2D}\u{2D}intent\u{2D}to\u{2D}add"
            ], in: repository.location) {
        case .failure(let error):
            return .failure(error)
        case .success:
            break
        }

        return runCustomSubcommand([
            "diff",
            "\u{2D}\u{2D}",
            "."
            ] + exclusionPatterns.map({ ":(exclude)\($0)" }), in: repository.location)
    }

    /// Returns the list of files ignored by source control.
    ///
    /// - Parameters:
    ///     - repository: The repository.
    public static func ignoredFiles(in repository: PackageRepository) -> Result<[URL], Git.Error> {

        return runCustomSubcommand([
            "status",
            "\u{2D}\u{2D}ignored",
            "\u{2D}\u{2D}porcelain"
            ], in: repository.location).map { ignoredSummary in
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
