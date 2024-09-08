/*
 Configuration.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic
import SDGCollections
import SDGText
import SDGLocalization
import SDGVersioning

import SDGSwift
import SDGSwiftConfiguration

import SDGSwiftLocalizations

extension Configuration {

  private static let minimumMacOSVersion: Version = Version(10, 13)

  #if !PLATFORM_LACKS_FOUNDATION_PROCESS
    private static let cache = FileManager.default.url(in: .cache, at: "Configurations")

    // #example(1, configurationFile) #example(2, configurationLoading)
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
    ///  import [module] // [package name], [url], [version], [product]
    ///  */
    /// import SDGControlFlow
    /// // SDGCornerstone, https://github.com/SDGGiesbrecht/SDGCornerstone, 10.0.0, SDGControlFlow
    ///
    /// // Initialize the configuration with its defaults.
    /// let configuration = SampleConfiguration()
    ///
    /// // Change whatever options are available.
    /// configuration.option = "Configured"
    ///
    /// // The configuration loader may provide context information.
    /// assert(SampleContext.context?.information == "Information")
    /// ```
    ///
    /// The above file could be loaded like this:
    ///
    /// ```swift
    /// // These refer to a real, working sample product.
    /// // See its source for more details:
    /// // https://github.com/SDGGiesbrecht/SDGSwift/tree/13.0.0/Sources/SampleConfiguration
    /// let product = "SampleConfiguration"
    /// let packageName = "SDGSwift"
    /// let packageURL = URL(string: "https://github.com/SDGGiesbrecht/SDGSwift")!
    /// let minimumMacOSVersion = Version(10, 13)
    /// let version = Version(13, 0, 0)
    /// let type = SampleConfiguration.self  // Import it first if necessary.
    ///
    /// // Assuming the above file is called “SampleConfigurationFile.swift”...
    /// let name = UserFacing<StrictString, APILocalization>(
    ///   { _ in "SampleConfigurationFile" }
    /// )
    ///
    /// // Change this to actually point at a directory containing the above file.
    /// let configuredDirectory: URL = wherever
    ///
    /// // Context information can be provided. (Optional.)
    /// let context = SampleContext(information: "Information")
    ///
    /// // A log to collect progress reports while loading. (Optional.)
    /// var log = String()
    ///
    /// let loadedConfiguration = try SampleConfiguration.load(
    ///   configuration: type,
    ///   named: name,
    ///   from: configuredDirectory,
    ///   linkingAgainst: product,
    ///   in: packageName,
    ///   from: packageURL,
    ///   at: version,
    ///   minimumMacOSVersion: minimumMacOSVersion,
    ///   context: context,
    ///   reportProgress: { print($0, to: &log) }
    /// ).get()
    /// XCTAssertEqual(loadedConfiguration.option, "Configured")
    /// ```
    ///
    /// - Parameters:
    ///     - configuration: The subclass of `Configuration` to load. (This is equivalent to the package manager’s `Package` type.
    ///     - fileName: The localized file name (without “.swift”) of the configuration. Any of the localized names will be detected. If several are present, which one gets loaded is undefined. (This file name is equivalent to the package manager’s `Package.swift`.)
    ///     - directory: The directory in which to look for a configuration.
    ///     - product: The name of the product which defines the `Configuration` subclass. Users will directly import it in configuration files. (This is equivalent to the package manager’s `PackageDescription` module).
    ///     - packageName: The name of the package where the module is defined.
    ///     - packageURL: The URL of the package were the module is defined.
    ///     - releaseVersion: The version of the package to link against.
    ///     - minimumMacOSVersion: The minimum version of macOS required by the package. This restriction must be narrower than any indirectly imported package.
    ///     - reportProgress: Optional. A closure to execute for each line of compiler output.
    ///
    /// - Returns: The loaded configuration if one is present, otherwise the default configuration.
    public class func load<C, L>(
      configuration: C.Type,
      named fileName: UserFacing<StrictString, L>,
      from directory: URL,
      linkingAgainst product: String,
      in packageName: String,
      from packageURL: URL,
      at releaseVersion: Version,
      minimumMacOSVersion: Version,
      reportProgress: (_ progressReport: String) -> Void = { _ in }
    ) -> Result<C, Configuration.Error> where C: Configuration, L: InputLocalization {

      let nullContext: NullContext? = nil
      return load(
        configuration: configuration,
        named: fileName,
        from: directory,
        linkingAgainst: product,
        in: packageName,
        from: packageURL,
        at: releaseVersion,
        minimumMacOSVersion: minimumMacOSVersion,
        context: nullContext,
        reportProgress: reportProgress
      )
    }
  #endif
  private struct NullContext: Context {}

  #if !PLATFORM_LACKS_FOUNDATION_PROCESS
    /// Loads the configuration, providing it with additional context information.
    ///
    /// This method has the additional ability to supply context to the configuration file as it loads. See the simpler version  (`load(configuration:named:from:linkingAgainst:in:at:reportProgress:)`) for general information about loading configurations.
    ///
    /// - Parameters:
    ///     - configuration: The subclass of `Configuration` to load.
    ///     - fileName: The localized file name of the configuration.
    ///     - directory: The directory in which to look for a configuration.
    ///     - product: The name of the product which defines the `Configuration` subclass.
    ///     - packageName: The name of the package where the module is defined.
    ///     - packageURL: The URL of the package were the module is defined.
    ///     - releaseVersion: The version of the package to link against.
    ///     - minimumMacOSVersion: The minimum version of macOS required by the package. This restriction must be narrower than any indirectly imported package.
    ///     - context: The context to provide to the configuration file.
    ///     - reportProgress: Optional. A closure to execute for each line of compiler output.
    public class func load<C, L, E>(
      configuration: C.Type,
      named fileName: UserFacing<StrictString, L>,
      from directory: URL,
      linkingAgainst product: String,
      in packageName: String,
      from packageURL: URL,
      at releaseVersion: Version,
      minimumMacOSVersion: Version,
      context: E?,
      reportProgress: (_ progressReport: String) -> Void = { _ in }
    ) -> Result<C, Configuration.Error> where C: Configuration, L: InputLocalization, E: Context {

      let have5_2 =
        SwiftCompiler.version(forConstraints: Version(5, 2)..<Version(Int.max)) ≠ nil
        ∧ ¬legacyMode

      var jsonData: Data
      if let mock = Configuration.mockQueue.first {
        configuration.mockQueue.removeFirst()
        do {
          jsonData = try JSONEncoder().encode([mock])
        } catch {
          return .failure(.foundationError(error))
        }
      } else {

        var possibleConfigurationFile: URL?
        for localization in L.allCases {
          let resolvedFileName = fileName.resolved(for: localization)
          let url = directory.appendingPathComponent("\(resolvedFileName).swift")
          if (try? url.checkResourceIsReachable()) == true {
            possibleConfigurationFile = url
            break
          }
        }

        guard let configurationFile = possibleConfigurationFile else {
          reportProgress(String(reportForNoConfigurationFound().resolved()))
          return .success(C())
        }
        reportProgress(String(reportForLoading(file: configurationFile).resolved()))

        let extensionRemoved = configurationFile.deletingPathExtension()
        let fileNameOnly = configurationFile.lastPathComponent
        let parentDirectory = extensionRemoved.deletingLastPathComponent()
        let parentDirectoryNameOnly = parentDirectory.lastPathComponent

        let configurationRepository = PackageRepository(
          at: cache.appendingPathComponent(parentDirectoryNameOnly).appendingPathComponent(
            fileNameOnly
          )
        )

        let mainLocation = configurationRepository.location.appendingPathComponent(
          "Sources/configure/main.swift"
        )
        var configurationContents: String
        do {
          configurationContents = try String(from: configurationFile)
        } catch {
          return .failure(.foundationError(error))
        }
        configurationContents.append("\nimport SDGSwiftConfiguration\n_exportConfiguration()\n")
        if let existingMain = try? String(from: mainLocation),
          existingMain == configurationContents
        {
          // Already there.
        } else {
          do {
            try configurationContents.save(to: mainLocation)
          } catch {
            return .failure(.foundationError(error))
          }
        }

        var dependencies:
          [(packageName: String, packageURL: URL, version: Version, product: String)] = []
        importSearch: for lineIndex in configurationContents.lines.indices
        where configurationContents.lines[lineIndex].line.hasPrefix(
          "import ".scalars.literal(for: String.ScalarView.SubSequence.self)
        ) {
          let comment:
            ExclusiveSuffixMatch<
              LiteralPattern<String.ScalarView, String.ScalarView.SubSequence>.Match
            >
          if let sameLineComment = configurationContents.lines[lineIndex].line
            .suffix(after: "/\u{2F} ".scalars.literal(for: String.ScalarView.SubSequence.self))
          {
            comment = sameLineComment
          } else if let nextLine = configurationContents.lines[lineIndex...].dropFirst().first,
            let nextLineComment = nextLine.line
              .suffix(after: "/\u{2F} ".scalars.literal(for: String.ScalarView.SubSequence.self))
          {
            comment = nextLineComment
          } else {
            continue importSearch
          }
          let components = String(comment.contents).components(separatedBy: ", ") as [String]
          if components.count == 4 {
            if let url = URL(string: components[1]),
              let version = Version(components[2])
            {
              dependencies.append((components[0], url, version, components[3]))
            }
          } else if components.count == 3 {
            // Legacy declaration without package name.
            if let url = URL(string: components[0]),
              let version = Version(components[1])
            {
              dependencies.append((url.lastPathComponent, url, version, components[2]))
            }
          }
        }

        let packages = dependencies.map({ dependency in
          let packageName = have5_2 ? "name: \u{22}\(dependency.packageName)\u{22}, " : ""
          return
            "        .package(\(packageName)url: \u{22}\(dependency.packageURL.absoluteString)\u{22}, .exact(\u{22}\(dependency.version.string())\u{22})),"
        }).joined(separator: "\n")
        let products = dependencies.map({ dependency in
          if have5_2 {
            return
              "            .product(name: \u{22}\(dependency.product)\u{22}, package: \u{22}\(dependency.packageName)\u{22}),"
          } else {
            return "            \u{22}\(dependency.product)\u{22},"
          }
        }).joined(separator: "\n")

        let resolvedMacOS = max(minimumMacOSVersion, Configuration.minimumMacOSVersion)
        var macOS = resolvedMacOS.string(droppingEmptyPatch: true)
        macOS.replaceMatches(for: ".", with: "_")

        let packageNameDeclaration = have5_2 ? "name: \u{22}\(packageName)\u{22}, " : ""
        let productDependency =
          have5_2
          ? ".product(name: \u{22}\(product)\u{22}, package: \u{22}\(packageName)\u{22})"
          : "\u{22}\(product)\u{22}"

        var manifest = Resources.packageSwift
        manifest.replaceMatches(for: "[*tools version*]", with: have5_2 ? "5.2" : "5.0")
        manifest.replaceMatches(for: "[*macOS*]", with: macOS)
        manifest.replaceMatches(for: "[*package name*]", with: packageNameDeclaration)
        manifest.replaceMatches(for: "[*URL*]", with: packageURL.absoluteString)
        manifest.replaceMatches(for: "[*version*]", with: releaseVersion.string())
        manifest.replaceMatches(for: "[*packages*],", with: packages)
        manifest.replaceMatches(for: "[*product*]", with: productDependency)
        manifest.replaceMatches(for: "[*products*],", with: products)

        let manifestLocation = configurationRepository.location
          .appendingPathComponent("Package.swift")
        if let existingManifest = try? String(from: manifestLocation),
          existingManifest == manifest
        {
          // Already there.
        } else {
          do {
            try manifest.save(to: manifestLocation)
          } catch {
            return .failure(.foundationError(error))
          }
        }

        switch configurationRepository.build(reportProgress: { report in
          if ¬report.hasPrefix("$") {
            reportProgress(report)
          }
        }) {
        case .failure(let error):
          return .failure(.swiftError(error))
        case .success:
          break
        }

        var arguments: [String] = []
        if let information = context {
          do {
            let json = try JSONEncoder().encode([information])
            arguments.append(String(data: json, encoding: .utf8)!)
          } catch {
            return .failure(.foundationError(error))
          }
        }

        var json: String
        switch configurationRepository.run(
          "configure",
          arguments: arguments,
          ignoreStandardError: true
        ) {
        case .failure(let error):
          return .failure(.swiftError(error))
        case .success(let output):
          json = output
        }
        jsonData = json.file
      }

      let decoded: [C?]
      do {
        decoded = try JSONDecoder().decode([C?].self, from: jsonData)
      } catch {
        return .failure(.foundationError(error))
      }
      guard let registry = decoded.first else {
        return .failure(.corruptConfiguration)  // @exempt(from: tests)
      }
      guard let registered = registry else {
        return .failure(.emptyConfiguration)
      }
      return .success(registered)
    }
  #endif

  internal static func reportForNoConfigurationFound() -> UserFacing<
    StrictString, InterfaceLocalization
  > {
    return UserFacing<StrictString, InterfaceLocalization>({ localization in
      switch localization {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "No configuration found. Using defaults..."
      case .deutschDeutschland:
        return "Keine Konfiguration gefunden. Standardeinstellungen werden verwendet ..."
      }
    })
  }

  internal static func reportForLoading(
    file: URL
  ) -> UserFacing<StrictString, InterfaceLocalization> {
    return UserFacing<StrictString, InterfaceLocalization>({ localization in
      let file = StrictString(file.lastPathComponent)
      switch localization {
      case .englishUnitedKingdom:
        return "Loading ‘\(file)’..."
      case .englishUnitedStates, .englishCanada:
        return "Loading “\(file)”..."
      case .deutschDeutschland:
        return "„\(file)“ wird geladen ..."
      }
    })
  }

  private static var mockQueue: [Configuration] = []
  /// Queues a mock configuration.
  ///
  /// If there is a mock configuration in the queue, it will be used instead at the next attempt to load a configuration from the disk. This allows tests to bypass the need for a published release of the configuration definition module.
  ///
  /// - Parameters:
  ///     - mock: The configuration to add to the queue.
  public static func queue(mock: Configuration) {
    mockQueue.append(mock)
  }
}
