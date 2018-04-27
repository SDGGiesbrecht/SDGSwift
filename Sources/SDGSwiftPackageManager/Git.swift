
import SDGSwift

extension Git {

    /// Initializes a repository with Git.
    ///
    /// - Throws: Either a `Git.Error` or an `ExternalProcess.Error`.
    public static func initialize(_ repository: PackageRepository) throws {
        try runCustomSubcommand(["init"], in: repository.location)
    }

    /// Commits existing changes.
    ///
    /// - Throws: Either a `Git.Error` or an `ExternalProcess.Error`.
    public static func commitChanges(in repository: PackageRepository, description: StrictString) throws {
        try runCustomSubcommand([
            "add",
            "."
            ], in: repository.location)
        try runCustomSubcommand([
            "commit",
            "\u{2D}\u{2D}message",
            String(description)
            ], in: repository.location)
    }

    /// Tags a version.
    ///
    /// - Throws: Either a `Git.Error` or an `ExternalProcess.Error`.
    public static func tag(version: Version, in repository: PackageRepository) throws {
        try runCustomSubcommand([
            "tag",
            version.string()
            ], in: repository.location)
    }

    /// Checks for uncommitted changes or additions in the repository.
    ///
    /// - Parameters:
    ///     - exclusionPatterns: Patterns describing paths or files to ignore.
    ///
    /// - Returns: The report provided by Git. (An empty string if there are no changes.)
    ///
    /// - Throws: Either a `Git.Error` or an `ExternalProcess.Error`.
    public static func uncommittedChanges(in repository: PackageRepository, excluding exclusionPatterns: [String] = []) throws -> String {
        _ = try runCustomSubcommand([
            "add",
            ".",
            "\u{2D}\u{2D}intent\u{2D}to\u{2D}add",
            ], in: repository.location)
        return try runCustomSubcommand([
            "diff",
            "\u{2D}\u{2D}",
            ".",
            ] + exclusionPatterns.map({ ":(exclude)\($0)" }), in: repository.location)
    }

    /// Returns the list of files ignored by source control.
    ///
    /// - Throws: Either a `Git.Error` or an `ExternalProcess.Error`.
    public static func ignoredFiles(in repository: PackageRepository) throws -> [URL] {
        let ignoredSummary = try runCustomSubcommand([
            "status",
            "\u{2D}\u{2D}ignored"
            ], in: repository.location)

        var result: [URL] = []
        if let headerRange = ignoredSummary.scalars.firstMatch(for: "Ignored files:".scalars)?.range {
            let remainder = String(ignoredSummary[headerRange.upperBound...])
            for line in remainder.lines.lazy.dropFirst(3).lazy.map({ $0.line }) where ¬line.isEmpty {
                let relativePath = String(StrictString(line.dropFirst()))
                result.append(repository.location.appendingPathComponent(relativePath))
            }
        }
        return result
    }
}
