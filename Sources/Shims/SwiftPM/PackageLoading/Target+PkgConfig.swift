/*
 This source file is part of the Swift.org open source project

 Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
 Licensed under Apache License v2.0 with Runtime Library Exception

 See http://swift.org/LICENSE.txt for license information
 See http://swift.org/CONTRIBUTORS.txt for Swift project authors
*/

import Basic
import PackageModel
import SPMUtility

/// Wrapper struct containing result of a pkgConfig query.
public struct PkgConfigResult {

    /// The name of the pkgConfig file.
    public let pkgConfigName: String

    /// The cFlags from pkgConfig.
    public let cFlags: [String]

    /// The library flags from pkgConfig.
    public let libs: [String]

    /// Available provider, if any.
    public let provider: SystemPackageProviderDescription?

    /// Any error encountered during operation.
    public let error: Swift.Error?

    /// If the pc file was not found.
    public var couldNotFindConfigFile: Bool {
        switch error {
            case PkgConfigError.couldNotFindConfigFile?: return true
            default: return false
        }
    }

    /// Create a result.
    fileprivate init(
        pkgConfigName: String,
        cFlags: [String] = [],
        libs: [String] = [],
        error: Swift.Error? = nil,
        provider: SystemPackageProviderDescription? = nil
    ) {
        self.cFlags = cFlags
        self.libs = libs
        self.error = error
        self.provider = provider
        self.pkgConfigName = pkgConfigName
    }
}

/// Get pkgConfig result for a system library target.
public func pkgConfigArgs(for target: SystemLibraryTarget, diagnostics: DiagnosticsEngine, fileSystem: FileSystem = localFileSystem, brewPrefix: AbsolutePath? = nil) -> PkgConfigResult? {
    // If there is no pkg config name defined, we're done.
    guard let pkgConfigName = target.pkgConfig else { return nil }

    // Compute additional search paths for the provider, if any.
    let provider = target.providers?.first { $0.isAvailable }
    let additionalSearchPaths = provider?.pkgConfigSearchPath(brewPrefixOverride: brewPrefix) ?? []

    // Get the pkg config flags.
    do {
        let pkgConfig = try PkgConfig(
            name: pkgConfigName,
            additionalSearchPaths: additionalSearchPaths,
            diagnostics: diagnostics,
            fileSystem: fileSystem,
            brewPrefix: brewPrefix)

        // Run the whitelist checker.
        let filtered = whitelist(pcFile: pkgConfigName, flags: (pkgConfig.cFlags, pkgConfig.libs))

        // Remove any default flags which compiler adds automatically.
        let (cFlags, libs) = removeDefaultFlags(cFlags: filtered.cFlags, libs: filtered.libs)

        // Set the error if there are any unallowed flags.
        var error: Swift.Error?
        if !filtered.unallowed.isEmpty {
            error = PkgConfigError.nonWhitelistedFlags(filtered.unallowed.joined(separator: ", "))
        }

        return PkgConfigResult(
            pkgConfigName: pkgConfigName,
            cFlags: cFlags,
            libs: libs,
            error: error,
            provider: provider
        )
    } catch {
        return PkgConfigResult(pkgConfigName: pkgConfigName, error: error, provider: provider)
    }
}

extension SystemPackageProviderDescription {
    public var installText: String {
        switch self {
        case .brew(let packages):
            return "    brew install \(packages.joined(separator: " "))\n"
        case .apt(let packages):
            return "    apt-get install \(packages.joined(separator: " "))\n"
        }
    }

    /// Check if the provider is available for the current platform.
    var isAvailable: Bool {
        guard let platform = Platform.currentPlatform else { return false }
        switch self {
        case .brew:
            if case .darwin = platform {
                return true
            }
        case .apt:
            if case .linux(.debian) = platform {
                return true
            }
        }
        return false
    }

    func pkgConfigSearchPath(brewPrefixOverride: AbsolutePath?) -> [AbsolutePath] {
        switch self {
        case .brew(let packages):
            let brewPrefix: String
            if let brewPrefixOverride = brewPrefixOverride {
                brewPrefix = brewPrefixOverride.pathString
            } else {
                // Homebrew can have multiple versions of the same package. The
                // user can choose another version than the latest by running
                // ``brew switch NAME VERSION``, so we shouldn't assume to link
                // to the latest version. Instead use the version as symlinked
                // in /usr/local/opt/(NAME)/lib/pkgconfig.
                struct Static {
                    static let value = { try? Process.checkNonZeroExit(args: "brew", "--prefix").spm_chomp() }()
                }
                if let value = Static.value {
                    brewPrefix = value
                } else {
                    return []
                }
            }
            return packages.map({ AbsolutePath(brewPrefix).appending(components: "opt", $0, "lib", "pkgconfig") })
        case .apt:
            return []
        }
    }

    // FIXME: Get rid of this method once we move on to new Build code.
    static func providerForCurrentPlatform(providers: [SystemPackageProviderDescription]) -> SystemPackageProviderDescription? {
        return providers.first(where: { $0.isAvailable })
    }
}

/// Filters the flags with allowed arguments so unexpected arguments are not passed to
/// compiler/linker. List of allowed flags:
/// cFlags: -I, -F
/// libs: -L, -l, -F, -framework, -w
func whitelist(
    pcFile: String,
    flags: (cFlags: [String], libs: [String])
) -> (cFlags: [String], libs: [String], unallowed: [String]) {
    // Returns a tuple with the array of allowed flag and the array of unallowed flags.
    func filter(flags: [String], filters: [String]) -> (allowed: [String], unallowed: [String]) {
        var allowed = [String]()
        var unallowed = [String]()
        var it = flags.makeIterator()
        while let flag = it.next() {
            guard let filter = filters.filter({ flag.hasPrefix($0) }).first else {
                unallowed += [flag]
                continue
            }

          // Warning suppression flag has no arguments and is not suffixed.
          guard !flag.hasPrefix("-w") || flag == "-w" else {
            unallowed += [flag]
            continue
          }

            // If the flag and its value are separated, skip next flag.
            if flag == filter && flag != "-w" {
                guard it.next() != nil else {
                   fatalError("Expected associated value")
                }
            }
            allowed += [flag]
        }
        return (allowed, unallowed)
    }

    let filteredCFlags = filter(flags: flags.cFlags, filters: ["-I", "-F"])
    let filteredLibs = filter(flags: flags.libs, filters: ["-L", "-l", "-F", "-framework", "-w"])

    return (filteredCFlags.allowed, filteredLibs.allowed, filteredCFlags.unallowed + filteredLibs.unallowed)
}

/// Remove the default flags which are already added by the compiler.
///
/// This behavior is similar to pkg-config cli tool and helps avoid conflicts between
/// sdk and default search paths in macOS.
func removeDefaultFlags(cFlags: [String], libs: [String]) -> ([String], [String]) {
    /// removes a flag from given array of flags.
    func remove(flag: (String, String), from flags: [String]) -> [String] {
        var result = [String]()
        var it = flags.makeIterator()
        while let curr = it.next() {
            switch curr {
            case flag.0:
                // Check for <flag><space><value> style.
                guard let val = it.next() else {
                    fatalError("Expected associated value")
                }
                // If we found a match, don't add these flags and just skip.
                if val == flag.1 { continue }
                // Otherwise add both the flags.
                result.append(curr)
                result.append(val)

            case flag.0 + flag.1:
                // Check for <flag><value> style.
                continue

            default:
                // Otherwise just append this flag.
                result.append(curr)
            }
        }
        return result
    }
    return (remove(flag: ("-I", "/usr/include"), from: cFlags), remove(flag: ("-L", "/usr/lib"), from: libs))
}

public struct PkgConfigDiagnosticLocation: DiagnosticLocation {
    public let pcFile: String
    public let target: String

    public init(pcFile: String, target: String) {
        self.pcFile = pcFile
        self.target = target
    }

    public var localizedDescription: String {
        return "'\(target)' \(pcFile).pc"
    }
}

public struct PkgConfigGenericDiagnostic: DiagnosticData {
    public static let id = DiagnosticID(
        type: PkgConfigGenericDiagnostic.self,
        name: "org.swift.diags.pkg-config-generic",
        defaultBehavior: .warning,
        description: {
            $0 <<< { $0.error }
        }
    )

    public let error: String

    public init(error: String) {
        self.error = error
    }
}

public struct PkgConfigHintDiagnostic: DiagnosticData {
    public static let id = DiagnosticID(
        type: PkgConfigHintDiagnostic.self,
        name: "org.swift.diags.pkg-config-hint",
        defaultBehavior: .warning,
        description: {
            $0 <<< "you may be able to install" <<< { $0.pkgConfigName } <<< "using your system-packager:\n"
            $0 <<< { $0.installText }
        }
    )

    public let pkgConfigName: String
    public let installText: String

    public init(pkgConfigName: String, installText: String) {
        self.pkgConfigName = pkgConfigName
        self.installText = installText
    }
}
