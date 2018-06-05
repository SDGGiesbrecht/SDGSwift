/*
 Configuration.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

import SDGSwift

extension Configuration {

    private static let cache = FileManager.default.url(in: .cache, at: "Configurations")

    /// Loads the configuration in the specified directory with the specified file name.
    ///
    /// - Parameters:
    ///     - configuration: The subclass of `Configuration` to load. (This is equivalent to the package manager’s `Package` type.
    ///     - fileName: The localized file name (without “.swift”) of the configuration. Any of the localized names will be detected. If several are present, which one gets loaded is undefined. (This file name is equivalent to the package manager’s `Package.swift`.)
    ///     - directory: The directory in which to look fo a configuration.
    ///     - product: The name of the product which defines the `Configuration` subclass. It will be directly imported in configuration files. (This is equivalent to the package manager’s `PackageDescription` module).
    ///     - package: The package were the module is defined.
    ///     - version: The version of the package to link against.
    ///
    /// - Returns: The loaded configuration if one is present, otherwise the default configuration.
    ///
    /// - Throws: A `Foundation` file system error, a `SwiftCompiler.Error`, an `ExternalProcess.Error` a `Foundation` JSON error, or a `Configuration.Error`.
    public class func load<C, L>(configuration: C.Type, named fileName: UserFacing<StrictString, L>, from directory: URL, linkingAgainst product: String, in package: Package, at version: Version) throws -> C where C : Configuration, L : InputLocalization {

        var possibleConfigurationFile: URL?
        for localization in L.cases {
            let resolvedFileName = fileName.resolved(for: localization)
            let url = directory.appendingPathComponent("\(resolvedFileName).swift")
            if try url.checkResourceIsReachable() {
                possibleConfigurationFile = url
                break
            }
        }

        guard let configurationFile = possibleConfigurationFile else {
            return C()
        }

        let extensionRemoved = configurationFile.deletingPathExtension()
        let fileNameOnly = extensionRemoved.lastPathComponent
        let parentDirectory = extensionRemoved.deletingLastPathComponent()
        let parentDirectoryNameOnly = parentDirectory.lastPathComponent

        let configurationRepository = PackageRepository(at: cache.appendingPathComponent(parentDirectoryNameOnly).appendingPathComponent(fileNameOnly))

        let mainLocation = configurationRepository.location.appendingPathComponent("Sources/configure/main.swift")
        var configurationContents = try String(from: configurationFile)
        configurationContents.append("\nimport SDGSwiftConfiguration\n_exportConfiguration()\n")
        if let existingMain = try? String(from: mainLocation),
            existingMain == configurationContents {
            // Already there.
        } else {
            try configurationContents.save(to: mainLocation)
        }

        let manifestLocation = configurationRepository.location.appendingPathComponent("Package.swift")
        var manifest = String(data: Resources.package, encoding: .utf8)!
        manifest.replaceMatches(for: "[*URL*]", with: package.url.absoluteString)
        manifest.replaceMatches(for: "[*version*]", with: version.string())
        manifest.replaceMatches(for: "[*product*]", with: product)
        if let existingManifest = try? String(from: manifestLocation),
            existingManifest == manifest {
            // Already there.
        } else {
            try manifest.save(to: manifestLocation)
        }

        try configurationRepository.build()
        let json = try SwiftCompiler.runCustomSubcommand(["run", "configure"], in: configurationRepository.location)

        let decoded = try JSONDecoder().decode([C?].self, from: json.file)
        guard let registry = decoded.first else {
            throw Configuration.Error.corruptConfiguration
        }
        guard let registered = registry else {
            throw Configuration.Error.emptyConfiguration
        }
        return registered
    }
}
