/*
 This source file is part of the Swift.org open source project
 
 Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
 Licensed under Apache License v2.0 with Runtime Library Exception
 
 See http://swift.org/LICENSE.txt for license information
 See http://swift.org/CONTRIBUTORS.txt for Swift project authors 
*/

import Basic
import Foundation
import func POSIX.getenv

public enum PkgConfigError: Swift.Error, CustomStringConvertible {
    case couldNotFindConfigFile
    case parsingError(String)
    case nonWhitelistedFlags(String)

    public var description: String {
        switch self {
        case .couldNotFindConfigFile:
            return "couldn't find pc file"
        case .parsingError(let error):
            return "parsing error(s): \(error)"
        case .nonWhitelistedFlags(let flags):
            return "non whitelisted flag(s): \(flags)"
        }
    }
}

public struct PkgConfigExecutionDiagnostic: DiagnosticData {
    public static let id = DiagnosticID(
        type: PkgConfigExecutionDiagnostic.self,
        name: "org.swift.diags.pkg-config-execution",
        defaultBehavior: .warning,
        description: {
            $0 <<< "failed to retrieve search paths with pkg-config; maybe pkg-config is not installed"
        }
    )
}

struct PCFileFinder {
    /// DiagnosticsEngine to emit warnings
    let diagnostics: DiagnosticsEngine

    /// Cached results of locations `pkg-config` will search for `.pc` files
    private(set) static var pkgConfigPaths: [AbsolutePath]? // FIXME: @testable(internal)

    /// The built-in search path list.
    ///
    /// By default, this is combined with the search paths inferred from
    /// `pkg-config` itself.
    static let searchPaths = [
        AbsolutePath("/usr/local/lib/pkgconfig"),
        AbsolutePath("/usr/local/share/pkgconfig"),
        AbsolutePath("/usr/lib/pkgconfig"),
        AbsolutePath("/usr/share/pkgconfig"),
    ]

    /// Get search paths from `pkg-config` itself to locate `.pc` files.
    ///
    /// This is needed because on Linux machines, the search paths can be different
    /// from the standard locations that we are currently searching.
    public init (diagnostics: DiagnosticsEngine, brewPrefix: AbsolutePath?) {
        self.diagnostics = diagnostics
        if PCFileFinder.pkgConfigPaths == nil {
            do {
                let pkgConfigPath: String
                if let brewPrefix = brewPrefix {
                    pkgConfigPath = brewPrefix.appending(components: "bin", "pkg-config").pathString
                } else {
                    pkgConfigPath = "pkg-config"
                }
                let searchPaths = try Process.checkNonZeroExit(
                args: pkgConfigPath, "--variable", "pc_path", "pkg-config").spm_chomp()
                PCFileFinder.pkgConfigPaths = searchPaths.split(separator: ":").map({ AbsolutePath(String($0)) })
            } catch {
                diagnostics.emit(data: PkgConfigExecutionDiagnostic())
                PCFileFinder.pkgConfigPaths = []
            }
        }
    }

    public func locatePCFile(
        name: String,
        customSearchPaths: [AbsolutePath],
        fileSystem: FileSystem
    ) throws -> AbsolutePath {
        // FIXME: We should consider building a registry for all items in the
        // search paths, which is likely to be substantially more efficient if
        // we end up searching for a reasonably sized number of packages.
        for path in OrderedSet(customSearchPaths + PCFileFinder.pkgConfigPaths! + PCFileFinder.searchPaths) {
            let pcFile = path.appending(component: name + ".pc")
            if fileSystem.isFile(pcFile) {
                return pcFile
            }
        }
        throw PkgConfigError.couldNotFindConfigFile
    }
}

/// Information on an individual `pkg-config` supported package.
public struct PkgConfig {
    /// The name of the package.
    public let name: String

    /// The path to the definition file.
    public let pcFile: AbsolutePath

    /// The list of C compiler flags in the definition.
    public let cFlags: [String]

    /// The list of libraries to link.
    public let libs: [String]

    /// DiagnosticsEngine to emit diagnostics
    let diagnostics: DiagnosticsEngine

    /// Helper to query `pkg-config` for library locations
    private let pkgFileFinder: PCFileFinder

    /// Load the information for the named package.
    ///
    /// It will search `fileSystem` for the pkg config file in the following order:
    /// * Paths defined in `PKG_CONFIG_PATH` environment variable
    /// * Paths defined in `additionalSearchPaths` argument
    /// * Built-in search paths (see `PCFileFinder.searchPaths`)
    ///
    /// - parameter name: Name of the pkg config file (without file extension).
    /// - parameter additionalSearchPaths: Additional paths to search for pkg config file.
    /// - parameter fileSystem: The file system to use, defaults to local file system.
    ///
    /// - throws: PkgConfigError
    public init(
        name: String,
        additionalSearchPaths: [AbsolutePath] = [],
        diagnostics: DiagnosticsEngine,
        fileSystem: FileSystem = localFileSystem,
        brewPrefix: AbsolutePath?
    ) throws {
        self.name = name
        self.pkgFileFinder = PCFileFinder(diagnostics: diagnostics, brewPrefix: brewPrefix)
        self.pcFile = try pkgFileFinder.locatePCFile(
            name: name,
            customSearchPaths: PkgConfig.envSearchPaths + additionalSearchPaths,
            fileSystem: fileSystem)

        self.diagnostics = diagnostics
        var parser = PkgConfigParser(pcFile: pcFile, fileSystem: fileSystem)
        try parser.parse()

        var cFlags = parser.cFlags
        var libs = parser.libs

        // If parser found dependencies in pc file, get their flags too.
        if !parser.dependencies.isEmpty {
            for dep in parser.dependencies {
                // FIXME: This is wasteful, we should be caching the PkgConfig result.
                let pkg = try PkgConfig(
                    name: dep, 
                    additionalSearchPaths: additionalSearchPaths,
                    diagnostics: self.diagnostics,
                    brewPrefix: brewPrefix
                )
                cFlags += pkg.cFlags
                libs += pkg.libs
            }
        }

        self.cFlags = cFlags
        self.libs = libs
    }

    private static var envSearchPaths: [AbsolutePath] {
        if let configPath = POSIX.getenv("PKG_CONFIG_PATH") {
            return configPath.split(separator: ":").map({ AbsolutePath(String($0)) })
        }
        return []
    }
}

// FIXME: This is only internal so it can be unit tested.
//
/// Parser for the `pkg-config` `.pc` file format.
///
/// See: https://www.freedesktop.org/wiki/Software/pkg-config/
struct PkgConfigParser {
    let pcFile: AbsolutePath
    private let fileSystem: FileSystem
    private(set) var variables = [String: String]()
    var dependencies = [String]()
    var cFlags = [String]()
    var libs = [String]()

    init(pcFile: AbsolutePath, fileSystem: FileSystem) {
        precondition(fileSystem.isFile(pcFile))
        self.pcFile = pcFile
        self.fileSystem = fileSystem
    }

    mutating func parse() throws {
        func removeComment(line: String) -> String {
            if let commentIndex = line.index(of: "#") {
                return String(line[line.startIndex..<commentIndex])
            }
            return line
        }

        // Add pcfiledir variable. This is path to the directory containing the pc file.
        variables["pcfiledir"] = pcFile.parentDirectory.pathString

        let fileContents = try fileSystem.readFileContents(pcFile)
        // FIXME: Should we error out instead if content is not UTF8 representable?
        for line in fileContents.validDescription?.components(separatedBy: "\n") ?? [] {
            // Remove commented or any trailing comment from the line.
            let uncommentedLine = removeComment(line: line)
            // Ignore any empty or whitespace line.
            guard let line = uncommentedLine.spm_chuzzle() else { continue }

            if line.contains(":") {
                // Found a key-value pair.
                try parseKeyValue(line: line)
            } else if line.contains("=") {
                // Found a variable.
                let (name, maybeValue) = line.spm_split(around: "=")
                let value = maybeValue?.spm_chuzzle() ?? ""
                variables[name.spm_chuzzle() ?? ""] = try resolveVariables(value)
            } else {
                // Unexpected thing in the pc file, abort.
                throw PkgConfigError.parsingError("Unexpected line: \(line) in \(pcFile.pathString)")
            }
        }
    }

    private mutating func parseKeyValue(line: String) throws {
        precondition(line.contains(":"))
        let (key, maybeValue) = line.spm_split(around: ":")
        let value = try resolveVariables(maybeValue?.spm_chuzzle() ?? "")
        switch key {
        case "Requires":
            dependencies = try parseDependencies(value)
        case "Libs":
            libs = try splitEscapingSpace(value)
        case "Cflags":
            cFlags = try splitEscapingSpace(value)
        default:
            break
        }
    }

    /// Parses `Requires: ` string into array of dependencies.
    ///
    /// The dependency string has seperator which can be (multiple) space or a
    /// comma.  Additionally each there can be an optional version constaint to
    /// a dependency.
    private func parseDependencies(_ depString: String) throws -> [String] {
        let operators = ["=", "<", ">", "<=", ">="]
        let separators = [" ", ","]

        // Look at a char at an index if present.
        func peek(idx: Int) -> Character? {
            guard idx <= depString.count - 1 else { return nil }
            return depString[depString.index(depString.startIndex, offsetBy: idx)]
        }

        // This converts the string which can be separated by comma or spaces
        // into an array of string.
        func tokenize() -> [String] {
            var tokens = [String]()
            var token = ""
            for (idx, char) in depString.enumerated() {
                // Encountered a seperator, use the token.
                if separators.contains(String(char)) {
                    // If next character is a space skip.
                    if let peeked = peek(idx: idx+1), peeked == " " { continue }
                    // Append to array of tokens and reset token variable.
                    tokens.append(token)
                    token = ""
                } else {
                    token += String(char)
                }
            }
            // Append the last collected token if present.
            if !token.isEmpty { tokens += [token] }
            return tokens
        }

        var deps = [String]()
        var it = tokenize().makeIterator()
        while let arg = it.next() {
            // If we encounter an operator then we need to skip the next token.
            if operators.contains(arg) {
                // We should have a version number next, skip.
                guard it.next() != nil else {
                    throw PkgConfigError.parsingError("""
                        Expected version number after \(deps.last.debugDescription) \(arg) in \"\(depString)\" in \
                        \(pcFile.pathString)
                        """)
                }
            } else {
                // Otherwise it is a dependency.
                deps.append(arg)
            }
        }
        return deps
    }

    /// Perform variable expansion on the line by processing the each fragment
    /// of the string until complete.
    ///
    /// Variables occur in form of ${variableName}, we search for a variable
    /// linearly in the string and if found, lookup the value of the variable in
    /// our dictionary and replace the variable name with its value.
    private func resolveVariables(_ line: String) throws -> String {
        // Returns variable name, start index and end index of a variable in a string if present.
        // We make sure it of form ${name} otherwise it is not a variable.
        func findVariable(_ fragment: String)
            -> (name: String, startIndex: String.Index, endIndex: String.Index)? {
            guard let dollar = fragment.index(of: "$"),
                  dollar != fragment.endIndex && fragment[fragment.index(after: dollar)] == "{",
                  let variableEndIndex = fragment.index(of: "}")
            else { return nil }
            return (String(fragment[fragment.index(dollar, offsetBy: 2)..<variableEndIndex]), dollar, variableEndIndex)
        }

        var result = ""
        var fragment = line
        while !fragment.isEmpty {
            // Look for a variable in our current fragment.
            if let variable = findVariable(fragment) {
                // Append the contents before the variable.
                result += fragment[fragment.startIndex..<variable.startIndex]
                guard let variableValue = variables[variable.name] else {
                    throw PkgConfigError.parsingError(
                        "Expected a value for variable '\(variable.name)' in \(pcFile). Variables: \(variables)")
                }
                // Append the value of the variable.
                result += variableValue
                // Update the fragment with post variable string.
                fragment = String(fragment[fragment.index(after: variable.endIndex)...])
            } else {
                // No variable found, just append rest of the fragment to result.
                result += fragment
                fragment = ""
            }
        }
        return String(result)
    }

    /// Split line on unescaped spaces.
    ///
    /// Will break on space in "abc def" and "abc\\ def" but not in "abc\ def"
    /// and ignore multiple spaces such that "abc def" will split into ["abc",
    /// "def"].
    private func splitEscapingSpace(_ line: String) throws -> [String] {
        var splits = [String]()
        var fragment = [Character]()

        func saveFragment() {
            if !fragment.isEmpty {
                splits.append(String(fragment))
                fragment.removeAll()
            }
        }

        var it = line.makeIterator()
        // Indicates if we're in a quoted fragment, we shouldn't append quote.
        var inQuotes = false
        while let char = it.next() {
            if char == "\"" {
                inQuotes = !inQuotes
            } else if char == "\\" {
                if let next = it.next() {
                    fragment.append(next)
                }
            } else if char == " " && !inQuotes {
                saveFragment()
            } else {
                fragment.append(char)
            }
        }
        guard !inQuotes else {
            throw PkgConfigError.parsingError(
                "Text ended before matching quote was found in line: \(line) file: \(pcFile)")
        }
        saveFragment()
        return splits
    }
}
