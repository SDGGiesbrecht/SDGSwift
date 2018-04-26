
import SDGSwift

extension Git {

    /// Initializes a repository with Git.
    ///
    /// - Throws: Either a `Git.Error` or an `ExternalProcess.Error`.
    public static func initialize(_ repository: PackageRepository) throws {
        _ = try runCustomSubcommand(["init"], in: repository.location)
    }

    /// Commits existing changes.
    ///
    /// - Throws: Either a `Git.Error` or an `ExternalProcess.Error`.
    public static func commitChanges(in repository: PackageRepository, description: StrictString) throws {
        _ = try runCustomSubcommand([
            "add",
            "."
            ], in: repository.location)
        _ = try runCustomSubcommand([
            "commit",
            "\u{2D}\u{2D}m",
            String(description)
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
}
