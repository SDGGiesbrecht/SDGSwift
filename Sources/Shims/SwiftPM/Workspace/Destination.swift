import Basic
import Build
import SPMUtility
import POSIX

public enum DestinationError: Swift.Error {
    /// Couldn't find the Xcode installation.
    case invalidInstallation(String)

    /// The schema version is invalid.
    case invalidSchemaVersion
}

extension DestinationError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidSchemaVersion:
            return "unsupported destination file schema version"
        case .invalidInstallation(let problem):
            return problem
        }
    }
}

/// The compilation destination, has information about everything that's required for a certain destination.
public struct Destination {

    /// The clang/LLVM triple describing the target OS and architecture.
    ///
    /// The triple has the general format <arch><sub>-<vendor>-<sys>-<abi>, where:
    ///  - arch = x86_64, i386, arm, thumb, mips, etc.
    ///  - sub = for ex. on ARM: v5, v6m, v7a, v7m, etc.
    ///  - vendor = pc, apple, nvidia, ibm, etc.
    ///  - sys = none, linux, win32, darwin, cuda, etc.
    ///  - abi = eabi, gnu, android, macho, elf, etc.
    ///
    /// for more information see //https://clang.llvm.org/docs/CrossCompilation.html
    public let target: Triple

    /// The SDK used to compile for the destination.
    public let sdk: AbsolutePath

    /// The binDir in the containing the compilers/linker to be used for the compilation.
    public let binDir: AbsolutePath

    /// Additional flags to be passed to the C compiler.
    public let extraCCFlags: [String]

    /// Additional flags to be passed to the Swift compiler.
    public let extraSwiftCFlags: [String]

    /// Additional flags to be passed when compiling with C++.
    public let extraCPPFlags: [String]

    /// Returns the bin directory for the host.
    ///
    /// - Parameter originalWorkingDirectory: The working directory when the program was launched.
    private static func hostBinDir(
        originalWorkingDirectory: AbsolutePath? = localFileSystem.currentWorkingDirectory
    ) -> AbsolutePath {
      #if Xcode
        // For Xcode, set bin directory to the build directory containing the fake
        // toolchain created during bootstraping. This is obviously not production ready
        // and only exists as a development utility right now.
        //
        // This also means that we should have bootstrapped with the same Swift toolchain
        // we're using inside Xcode otherwise we will not be able to load the runtime libraries.
        //
        // FIXME: We may want to allow overriding this using an env variable but that
        // doesn't seem urgent or extremely useful as of now.
        return AbsolutePath(#file).parentDirectory
            .parentDirectory.parentDirectory.appending(components: ".build", hostTargetTriple.tripleString, "debug")
      #else
        guard let cwd = originalWorkingDirectory else {
            return try! AbsolutePath(validating: CommandLine.arguments[0]).parentDirectory
        }
        return AbsolutePath(CommandLine.arguments[0], relativeTo: cwd).parentDirectory
      #endif
    }

    /// The destination describing the host OS.
    public static func hostDestination(
        _ binDir: AbsolutePath? = nil,
        originalWorkingDirectory: AbsolutePath? = localFileSystem.currentWorkingDirectory,
        environment: [String:String] = Process.env
    ) throws -> Destination {
        // Select the correct binDir.
        let binDir = binDir ?? Destination.hostBinDir(
            originalWorkingDirectory: originalWorkingDirectory)

      #if os(macOS)
        // Get the SDK.
        let sdkPath: AbsolutePath
        if let value = lookupExecutablePath(filename: getenv("SDKROOT")) {
            sdkPath = value
        } else {
            // No value in env, so search for it.
            let sdkPathStr = try Process.checkNonZeroExit(
                arguments: ["xcrun", "--sdk", "macosx", "--show-sdk-path"], environment: environment).spm_chomp()
            guard !sdkPathStr.isEmpty else {
                throw DestinationError.invalidInstallation("default SDK not found")
            }
            sdkPath = AbsolutePath(sdkPathStr)
        }

        // Compute common arguments for clang and swift.
        // This is currently just frameworks path.
        let commonArgs = Destination.sdkPlatformFrameworkPath(environment: environment).map({ ["-F", $0.pathString] }) ?? []

        return Destination(
            target: hostTargetTriple,
            sdk: sdkPath,
            binDir: binDir,
            extraCCFlags: commonArgs,
            extraSwiftCFlags: commonArgs,
            extraCPPFlags: ["-lc++"]
        )
      #else
        return Destination(
            target: hostTargetTriple,
            sdk: .root,
            binDir: binDir,
            extraCCFlags: ["-fPIC"],
            extraSwiftCFlags: [],
            extraCPPFlags: ["-lstdc++"]
        )
      #endif
    }

    /// Returns macosx sdk platform framework path.
    public static func sdkPlatformFrameworkPath(environment: [String:String] = Process.env) -> AbsolutePath? {
        if let path = _sdkPlatformFrameworkPath {
            return path
        }
        let platformPath = try? Process.checkNonZeroExit(
            arguments: ["xcrun", "--sdk", "macosx", "--show-sdk-platform-path"], environment: environment).spm_chomp()

        if let platformPath = platformPath, !platformPath.isEmpty {
           _sdkPlatformFrameworkPath = AbsolutePath(platformPath).appending(
                components: "Developer", "Library", "Frameworks")
        }
        return _sdkPlatformFrameworkPath
    }
    /// Cache storage for sdk platform path.
    private static var _sdkPlatformFrameworkPath: AbsolutePath? = nil

    /// Target triple for the host system.
    private static let hostTargetTriple = Triple.hostTriple
}

extension Destination {

    /// Load a Destination description from a JSON representation from disk.
    public init(fromFile path: AbsolutePath, fileSystem: FileSystem = localFileSystem) throws {
        let json = try JSON(bytes: fileSystem.readFileContents(path))
        try self.init(json: json)
    }
}

extension Destination: JSONMappable {

    /// The current schema version.
    static let schemaVersion = 1

    public init(json: JSON) throws {

        // Check schema version.
        guard try json.get("version") == Destination.schemaVersion else {
            throw DestinationError.invalidSchemaVersion
        }

        try self.init(
            target: Triple(json.get("target")),
            sdk: AbsolutePath(json.get("sdk")),
            binDir: AbsolutePath(json.get("toolchain-bin-dir")),
            extraCCFlags: json.get("extra-cc-flags"),
            extraSwiftCFlags: json.get("extra-swiftc-flags"),
            extraCPPFlags: json.get("extra-cpp-flags")
        )
    }
}
