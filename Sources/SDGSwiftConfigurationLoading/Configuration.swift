/*
 Configuration.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGLocalization

import SDGSwift

extension Configuration {

    private static let cache = FileManager.default.url(in: .cache, at: "Configurations")

    // [_Example 1: Configuration File_] [_Example 2: Configuration Loading_]
    /// Loads the configuration in the specified directory with the specified file name.
    ///
    /// A loadable file might look something like this:
    ///
    /// ```swift
    /// // Import the configuration definitions.
    /// import SampleConfiguration
    ///
    /// /*
    ///  Exernal packages can be imported with this syntax:
    ///  import [module] // [url], [version], [product]
    ///  */
    /// import SDGControlFlow // https://github.com/SDGGiesbrecht/SDGCornerstone, 0.10.0, SDGControlFlow
    ///
    /// // Initialize the configuration with its defaults.
    /// let configuration = SampleConfiguration()
    ///
    /// // Change whatever options are available.
    /// configuration.option = "Configured"
    /// ```
    ///
    /// The above file could be loaded like this:
    ///
    /// ```swift
    /// // These refer to a real, working sample product.
    /// // See its source for more details:
    /// // https://github.com/SDGGiesbrecht/SDGSwift/tree/0.1.8/Sources/SampleConfiguration
    /// let product = "SampleConfiguration"
    /// let package = Package(url: URL(string: "https://github.com/SDGGiesbrecht/SDGSwift")!)
    /// let version = Version(0, 1, 8)
    /// let type = SampleConfiguration.self // Import it first if necessary.
    ///
    /// // Assuming the above file is called “SampleConfigurationFile.swift”...
    /// let name = UserFacing<StrictString, APILocalization>({ _ in return "SampleConfigurationFile"})
    ///
    /// // Change this to actually point at a directory containing the above file.
    /// let configuredDirectory: URL = wherever
    ///
    /// let loadedConfiguration = try SampleConfiguration.load(configuration: type, named: name, from: configuredDirectory, linkingAgainst: product, in: package, at: version)
    /// XCTAssertEqual(loadedConfiguration.option, "Configured")
    /// ```
    ///
    /// - Parameters:
    ///     - configuration: The subclass of `Configuration` to load. (This is equivalent to the package manager’s `Package` type.
    ///     - fileName: The localized file name (without “.swift”) of the configuration. Any of the localized names will be detected. If several are present, which one gets loaded is undefined. (This file name is equivalent to the package manager’s `Package.swift`.)
    ///     - directory: The directory in which to look for a configuration.
    ///     - product: The name of the product which defines the `Configuration` subclass. Users will directly import it in configuration files. (This is equivalent to the package manager’s `PackageDescription` module).
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
            if (try? url.checkResourceIsReachable()) == true {
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

        var dependencies: [(package: URL, version: Version, product: String)] = []
        for line in configurationContents.lines where line.line.hasPrefix("import ".scalars) {
            if let comment = line.line.suffix(after: "// ".scalars) {
                let components = String(comment.contents).components(separatedBy: ", ") as [String]
                if components.count == 3 {
                    if let url = URL(string: components[0]),
                        let version = Version(components[1]) {
                        dependencies.append((url, version, components[2]))
                    }
                }
            }
        }
        let packages = dependencies.map({
            return "        .package(url: \u{22}\($0.package.absoluteString)\u{22}, .exact(\u{22}\($0.version.string())\u{22})),"
        }).joined(separator: "\n")
        let products = dependencies.map({
            return "            \u{22}\($0.product)\u{22},"
        }).joined(separator: "\n")

        let manifestLocation = configurationRepository.location.appendingPathComponent("Package.swift")
        var manifest = String(data: Resources.package, encoding: .utf8)!
        manifest.replaceMatches(for: "[*URL*]", with: package.url.absoluteString)
        manifest.replaceMatches(for: "[*version*]", with: version.string())
        manifest.replaceMatches(for: "[*packages*]", with: packages)
        manifest.replaceMatches(for: "[*product*]", with: product)
        manifest.replaceMatches(for: "[*products*]", with: products)
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
            throw Configuration.Error.corruptConfiguration // [_Exempt from Test Coverage_]
        }
        guard let registered = registry else {
            throw Configuration.Error.emptyConfiguration
        }
        return registered
    }
}
