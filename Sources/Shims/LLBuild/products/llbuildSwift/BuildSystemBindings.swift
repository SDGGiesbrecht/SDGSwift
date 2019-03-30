// This source file is part of the Swift.org open source project
//
// Copyright 2017 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for Swift project authors

// This file contains Swift bindings for the llbuild C API.

#if os(Linux)
import Glibc
#else
import Darwin.C
#endif

import Foundation

// We don't need this import if we're building
// this file as part of the llbuild framework.
#if !LLBUILD_FRAMEWORK
import llbuild
#endif

private func bytesFromData(_ data: llb_data_t) -> [UInt8] {
    return Array(UnsafeBufferPointer(start: data.data, count: Int(data.length)))
}

/// Create a new `llb_data_t` instance containing an allocated copy of the given `bytes`.
private func copiedDataFromBytes(_ bytes: [UInt8]) -> llb_data_t {
    // Create the data.
    let buf = UnsafeMutableBufferPointer(start: UnsafeMutablePointer<UInt8>.allocate(capacity: bytes.count), count: bytes.count)

    // Copy the data.
    memcpy(buf.baseAddress!, UnsafePointer<UInt8>(bytes), buf.count)

    // Fill in the result structure.
    return llb_data_t(length: UInt64(buf.count), data: unsafeBitCast(buf.baseAddress, to: UnsafePointer<UInt8>.self))
}

// FIXME: We should eventually eliminate the need for this.
private func stringFromData(_ data: llb_data_t) -> String {
    return String(decoding: UnsafeBufferPointer(start: data.data, count: Int(data.length)), as: Unicode.UTF8.self)
}


public protocol Tool: class {
    /// Called to create a specific command instance of this tool.
    func createCommand(_ name: String) -> ExternalCommand
}

private final class ToolWrapper {
    let tool: Tool

    init(tool: Tool) {
        self.tool = tool
    }

    /// The owning list of all created commands.
    //
    // FIXME: This is lame, we should be able to destroy these naturally.
    private var commandWrappers: [CommandWrapper] = []
    func createCommand(_ name: UnsafePointer<llb_data_t>) -> OpaquePointer? {
        let command = tool.createCommand(stringFromData(name.pointee))
        let wrapper = CommandWrapper(command: command)
        self.commandWrappers.append(wrapper)
        var _delegate = llb_buildsystem_external_command_delegate_t()
        _delegate.context = Unmanaged.passUnretained(wrapper).toOpaque()
        _delegate.get_signature = { return BuildSystem.toCommandWrapper($0!).getSignature($1!, $2!) }
        _delegate.execute_command = { return BuildSystem.toCommandWrapper($0!).executeCommand($1!, $2!, $3!, $4!) }

        // Create the low-level command.
        wrapper._command = Command(llb_buildsystem_external_command_create(name, _delegate))

        return wrapper._command.handle
    }
}

public protocol ExternalCommand: class {
    /// Get a signature used to identify the internal state of the command.
    ///
    /// This is checked to determine if the command needs to rebuild versus the last time it was run.
    func getSignature(_ command: Command) -> [UInt8]

    /// Called to execute the given command.
    ///
    /// - command: A handle to the executing command.
    /// - returns: True on success.
    func execute(_ command: Command) -> Bool
}

// FIXME: The terminology is really confusing here, we have ExternalCommand which is divorced from the actual internal command implementation of the same name.
private final class CommandWrapper {
    let command: ExternalCommand
    var _command: Command

    init(command: ExternalCommand) {
        self.command = command
        self._command = Command(nil)
    }

    func getSignature(_: OpaquePointer, _ data: UnsafeMutablePointer<llb_data_t>) {
        data.pointee = copiedDataFromBytes(command.getSignature(_command))
    }

    func executeCommand(_: OpaquePointer, _ bsci: OpaquePointer, _ task: OpaquePointer, _ jobContext: OpaquePointer) -> Bool {
        return command.execute(_command)
    }
}

/// Encapsulates a diagnostic as reported by the build system.
public struct Diagnostic {
    public typealias Kind = DiagnosticKind

    /// The kind of diagnostic.
    public let kind: Kind

    /// The diagnostic location, if provided.
    public let location: (filename: String, line: Int, column: Int)?

    /// The diagnostic text.
    public let message: String
}

extension CommandStatusKind: CustomStringConvertible {
    public var description: String {
        switch self {
        case .isScanning:
            return "isScanning"
        case .isUpToDate:
            return "isUpToDate"
        case .isComplete:
            return "isComplete"
        @unknown default:
            return "unknown"
        }
    }
}

extension BuildKeyKind: CustomStringConvertible {
    public var description: String {
        switch self {
        case .command:
            return "command"
        case .customTask:
            return "customTask"
        case .directoryContents:
            return "directoryContents"
        case .directoryTreeSignature:
            return "directoryTreeSignature"
        case .node:
            return "node"
        case .target:
            return "target"
        case .unknown:
            return "unknown"
        case .directoryTreeStructureSignature:
            return "directoryTreeStructureSignature"
        case .filteredDirectoryContents:
            return "filteredDirectoryContents"
        case .stat:
            return "stat"
        @unknown default:
            return "unknown-\(rawValue)"
        }
    }
}

extension DiagnosticKind: CustomStringConvertible {
    public var description: String {
        switch self {
        case .note:
            return "note"
        case .warning:
            return "warning"
        case .error:
            return "error"
        @unknown default:
            return "unknown"
        }
    }
}

extension SchedulerAlgorithm {
    public init?(rawValue: String) {
        switch rawValue {
        case "commandNamePriority":
            self = .commandNamePriority
        case "fifo":
            self = .fifo
        default:
            return nil
        }
    }
}

/// Handle for a command as invoked by the low-level BuildSystem.
public struct Command: Hashable, CustomStringConvertible, CustomDebugStringConvertible {
    fileprivate let handle: OpaquePointer?

    fileprivate init(_ handle: OpaquePointer?) {
        self.handle = handle
    }

    /// The command name.
    //
    // FIXME: We shouldn't need to expose this to use for mapping purposes, we should be able to use something more efficient.
    public var name: String {
        var data = llb_data_t()
        withUnsafeMutablePointer(to: &data) { (ptr: UnsafeMutablePointer<llb_data_t>) in
            llb_buildsystem_command_get_name(handle, ptr)
        }
        return stringFromData(data)
    }

    /// Whether the default status reporting shows status for the command.
    public var shouldShowStatus: Bool {
        return llb_buildsystem_command_should_show_status(handle)
    }

    /// The description provided by the command.
    public var description: String {
        let name = llb_buildsystem_command_get_description(handle)!
        defer { free(name) }

        return String(cString: name)
    }

    /// The verbose description provided by the command.
    public var verboseDescription: String {
        let name = llb_buildsystem_command_get_verbose_description(handle)!
        defer { free(name) }

        return String(cString: name)
    }

    /// The debug description provides the verbose description.
    public var debugDescription: String {
        return verboseDescription
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(handle!)
    }

    public static func ==(lhs: Command, rhs: Command) -> Bool {
        return lhs.handle == rhs.handle
    }
}

/// Handle for a process which has been launched by a command.
//
// FIXME: We would like to call this Process, but then it conflicts with Swift's builtin Process. Maybe there is another name?
public struct ProcessHandle: Hashable {
    fileprivate let handle: OpaquePointer

    fileprivate init(_ handle: OpaquePointer) {
        self.handle = handle
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(handle.hashValue)
    }

    public static func ==(lhs: ProcessHandle, rhs: ProcessHandle) -> Bool {
        return lhs.handle == rhs.handle
    }
}

public struct CommandMetrics {
    public let utime: UInt64         /// User time (in us)
    public let stime: UInt64         /// Sys time (in us)
    public let maxRSS: UInt64        /// Max RSS (in bytes)

    public init(utime: UInt64, stime: UInt64, maxRSS: UInt64) {
        self.utime = utime
        self.stime = stime
        self.maxRSS = maxRSS
    }
}

/// Result of a command execution.
public struct CommandExtendedResult {
    public let result: CommandResult    /// The result of a command execution
    public let exitStatus: Int32        /// The exit code
    public let pid: llbuild_pid_t?      /// The process identifier (nil if failed to create a process)
    public let metrics: CommandMetrics? /// Metrics about the executed command

    init(_ result: UnsafePointer<llb_buildsystem_command_extended_result_t>) {
        self.result = result.pointee.result
        self.exitStatus = result.pointee.exit_status
        if result.pointee.pid >= 0 {
            self.pid = result.pointee.pid
        } else {
            self.pid = nil
        }
        switch self.result {
        case .succeeded, .failed:
            self.metrics = CommandMetrics(utime: result.pointee.utime, stime: result.pointee.stime, maxRSS: result.pointee.maxrss)
        default:
            self.metrics = nil
        }
    }

    public init(result: CommandResult, exitStatus: Int32, pid: llbuild_pid_t?, metrics: CommandMetrics? = nil) {
        self.result = result
        self.exitStatus = exitStatus
        self.pid = pid
        self.metrics = metrics
    }

}

/// The BuildKey encodes the key space used by the BuildSystem when using the
/// core BuildEngine.
public struct BuildKey {
    public typealias Kind = BuildKeyKind

    /// The kind of key
    public let kind: Kind

    /// The actual key data
    public let key: String

    public init(kind: Kind, key: String) {
        self.kind = kind
        self.key = key
    }

    init(key: llb_build_key_t) {
        self.init(kind: key.kind, key: String(cString: key.key))
    }
}

/// File system information for a particular file.
///
/// This is a simple wrapper for stat() information.
public protocol FileInfo {
    /// Creates a new `FileInfo` object.
    init(_ statBuf: stat)

    var statBuf: stat { get }
}

/// Abstracted access to file system operations.
// FIXME: We want to remove this protocol eventually and use the FileSystem
// protocol from SwiftPM's Basic target.
public protocol FileSystem {
    /// Get the contents of a file.
    func read(_ path: String) throws -> [UInt8]

    /// Returns the stat of a file at `path`.
    func getFileInfo(_ path: String) throws -> FileInfo
}

/// Delegate interface for use with the build system.
public protocol BuildSystemDelegate {

    /// The FileSystem to use, if any.
    ///
    /// This is currently very limited.
    var fs: FileSystem? { get }

    /// Called in response to requests for new tools.
    ///
    /// The client should return an appropriate tool implementation if recognized.
    func lookupTool(_ name: String) -> Tool?

    /// Called to report any form of command failure.
    ///
    /// This can may be called to report the failure of a command which has
    /// executed, but may also be used to report the inability of a command to
    /// run. It is expected to be used by the client in making decisions with
    /// regard to cancelling the build.
    func hadCommandFailure()

    /// Called to report an unassociated diagnostic from the build system.
    func handleDiagnostic(_ diagnostic: Diagnostic)

    /// Called when a command has changed state.
    ///
    /// The system guarantees that any commandStart() call will be paired with
    /// exactly one \see commandFinished() call.
    func commandStatusChanged(_ command: Command, kind: CommandStatusKind)

    /// Called when a command is preparing to start.
    ///
    /// The system guarantees that any commandStart() call will be paired with
    /// exactly one \see commandFinished() call.
    func commandPreparing(_ command: Command)

    /// Called when a command has been started.
    ///
    /// The system guarantees that any commandStart() call will be paired with
    /// exactly one \see commandFinished() call.
    func commandStarted(_ command: Command)

    /// Called to allow the delegate to skip commands without cancelling their
    /// dependents. See llbuild's should_command_start.
    func shouldCommandStart(_ command: Command) -> Bool

    /// Called when a command has been finished.
    func commandFinished(_ command: Command, result: CommandResult)

    /// Called to report an error during the execution of a command.
    func commandHadError(_ command: Command, message: String)

    /// Called to report a note during the execution of a command.
    func commandHadNote(_ command: Command, message: String)

    /// Called to report a warning during the execution of a command.
    func commandHadWarning(_ command: Command, message: String)

    /// Called by the build system to report a command could not build due to
    /// missing inputs.
    func commandCannotBuildOutputDueToMissingInputs(_ command: Command, output: BuildKey, inputs: [BuildKey])

    /// Called by the build system to report a node could not be built
    /// because multiple commands are producing it.
    func cannotBuildNodeDueToMultipleProducers(output: BuildKey, commands: [Command])

    /// Called when a command's job has started executing an external process.
    ///
    /// The system guarantees that any commandProcessStarted() call will be paired
    /// with exactly one \see commandProcessFinished() call.
    ///
    /// - parameter process: A unique handle used in subsequent delegate calls
    /// to identify the process. This handle should only be used to associate
    /// different status calls relating to the same process. It is only
    /// guaranteed to be unique from when it has been provided here to when it
    /// has been provided to the \see commandProcessFinished() call.
    func commandProcessStarted(_ command: Command, process: ProcessHandle)

    /// Called to report an error in the management of a command process.
    ///
    /// - parameter process: The process handle.
    /// - parameter message: The error message.
    func commandProcessHadError(_ command: Command, process: ProcessHandle, message: String)

    /// Called to report a command processes' (merged) standard output and error.
    ///
    /// - parameter process: The process handle.
    /// - parameter data: The process output.
    func commandProcessHadOutput(_ command: Command, process: ProcessHandle, data: [UInt8])

    /// Called when a command's job has finished executing an external process.
    ///
    /// - parameter process: The handle used to identify the process. This
    /// handle will become invalid as soon as the client returns from this API
    /// call.
    ///
    /// - parameter result: Whether the process suceeded, failed or was cancelled.
    /// - parameter exitStatus: The raw exit status of the process.
    func commandProcessFinished(_ command: Command, process: ProcessHandle, result: CommandExtendedResult)

    /// Called when a cycle is detected by the build engine and it cannot make
    /// forward progress.
    func cycleDetected(rules: [BuildKey])

    /// Called when a cycle is detected by the build engine to check if it should
    /// attempt to resolve the cycle and continue
    ///
    /// - parameter rules: The ordered list of items comprising the cycle,
    /// starting from the node which was requested to build and ending with the
    /// first node in the cycle (i.e., the node participating in the cycle will
    /// appear twice).
    /// - parameter candidate: The rule the engine will use to attempt to break the
    /// cycle.
    /// - parameter action: The action the engine will take on the candidateRule.
    ///
    /// Returns true if the engine should attempt to resolve the cycle, false
    /// otherwise. Resolution is attempted by either forcing items to be built, or
    /// supplying a previously built result to a node in the cycle. The latter
    /// action may yield unexpected results and thus this should be opted into
    /// with care.
    func shouldResolveCycle(rules: [BuildKey], candidate: BuildKey, action: CycleAction) -> Bool
}

/// Utility class for constructing a C-style environment.
private final class CStyleEnvironment {
    /// The list of individual bindings, which must be deallocated.
    private let bindings: [UnsafeMutablePointer<CChar>]

    /// The environment array, which will be a valid C-style environment pointer
    /// for the lifetime of the instance.
    let envp: [UnsafePointer<CChar>?]

    init(_ environment: [String: String]) {
        // Allocate the individual binding strings.
        self.bindings = environment.map{ "\($0.0)=\($0.1)".withCString(strdup)! }

        // Allocate the envp array.
        self.envp = self.bindings.map{ UnsafePointer($0) } + [nil]
    }

    deinit {
        bindings.forEach{ free($0) }
    }
}

/// This class allows building using llbuild's native BuildSystem component.
public final class BuildSystem {
    /// The build file that the system is configured with.
    public let buildFile: String

    /// The delegate used by the system.
    public let delegate: BuildSystemDelegate

    /// The internal llbuild build system.
    private var _system: OpaquePointer? = nil

    /// The C environment, if used.
    private let _cEnvironment: CStyleEnvironment?

    /// The current scheduler algorithm
    private static var schedulerAlgorithm : SchedulerAlgorithm = .commandNamePriority

    /// The number of scheduler lanes
    private static var schedulerLanes : UInt32 = 0

    public init(buildFile: String, databaseFile: String, delegate: BuildSystemDelegate, environment: [String: String]? = nil, serial: Bool = false, traceFile: String? = nil) {

        // Safety check that we have linked against a compatibile llbuild framework version
        if llb_get_api_version() != LLBUILD_C_API_VERSION {
            fatalError("llbuild C API version mismatch, found \(llb_get_api_version()), expect \(LLBUILD_C_API_VERSION)")
        }

        self.buildFile = buildFile
        self.delegate = delegate

        // Create a stable C string path.
        let pathPtr = strdup(buildFile)
        defer { free(pathPtr) }

        let dbPathPtr = strdup(databaseFile)
        defer { free(dbPathPtr) }

        let tracePathPtr = strdup(traceFile ?? "")
        defer { free(tracePathPtr) }

        // Allocate a C style environment, if necessary.
        _cEnvironment = environment.map{ CStyleEnvironment($0) }

        var _invocation = llb_buildsystem_invocation_t()
        _invocation.buildFilePath = UnsafePointer(pathPtr)
        _invocation.dbPath = UnsafePointer(dbPathPtr)
        _invocation.traceFilePath = UnsafePointer(tracePathPtr)
        _invocation.environment = _cEnvironment.map{ UnsafePointer($0.envp) }
        _invocation.showVerboseStatus = true
        _invocation.useSerialBuild = serial
        _invocation.schedulerAlgorithm = BuildSystem.schedulerAlgorithm
        _invocation.schedulerLanes = BuildSystem.schedulerLanes

        // Construct the system delegate.
        var _delegate = llb_buildsystem_delegate_t()
        _delegate.context = Unmanaged.passUnretained(self).toOpaque()
        if delegate.fs != nil {
            _delegate.fs_get_file_contents = { BuildSystem.toSystem($0!).fsGetFileContents(String(cString: $1!), $2!) }
            _delegate.fs_get_file_info = { BuildSystem.toSystem($0!).fsGetFileInfo(String(cString: $1!), $2!) }
            // FIXME: This should be a separate callback, not shared with getFileInfo (or get FileInfo should take a parameter).
            _delegate.fs_get_link_info = { BuildSystem.toSystem($0!).fsGetFileInfo(String(cString: $1!), $2!) }
        }
        _delegate.lookup_tool = { return BuildSystem.toSystem($0!).lookupTool($1!) }
        _delegate.had_command_failure = { BuildSystem.toSystem($0!).hadCommandFailure() }
        _delegate.handle_diagnostic = { BuildSystem.toSystem($0!).handleDiagnostic($1, String(cString: $2!), Int($3), Int($4), String(cString: $5!)) }
        _delegate.command_status_changed = { BuildSystem.toSystem($0!).commandStatusChanged(Command($1), $2) }
        _delegate.command_preparing = { BuildSystem.toSystem($0!).commandPreparing(Command($1)) }
        _delegate.command_started = { BuildSystem.toSystem($0!).commandStarted(Command($1)) }
        _delegate.should_command_start = { BuildSystem.toSystem($0!).shouldCommandStart(Command($1)) }
        _delegate.command_finished = { BuildSystem.toSystem($0!).commandFinished(Command($1), $2) }
        _delegate.command_had_error = { BuildSystem.toSystem($0!).commandHadError(Command($1), $2!) }
        _delegate.command_had_note = { BuildSystem.toSystem($0!).commandHadNote(Command($1), $2!) }
        _delegate.command_had_warning = { BuildSystem.toSystem($0!).commandHadWarning(Command($1), $2!) }
        _delegate.command_cannot_build_output_due_to_missing_inputs = {
            let inputsPtr = $3!
            let inputs = (0..<Int($4)).map { BuildKey(key: inputsPtr[$0]) }
            BuildSystem.toSystem($0!).commandCannotBuildOutputDueToMissingInputs(Command($1), BuildKey(key: $2!.pointee), inputs)
        }
        _delegate.cannot_build_node_due_to_multiple_producers = {
            let commandsPtr = $2!
            let commands = (0..<Int($3)).map { Command(commandsPtr[$0]) }
            BuildSystem.toSystem($0!).cannotBuildNodeDueToMultipleProducers(BuildKey(key: $1!.pointee), commands)
        }
        _delegate.command_process_started = { BuildSystem.toSystem($0!).commandProcessStarted(Command($1), ProcessHandle($2!)) }
        _delegate.command_process_had_error = { BuildSystem.toSystem($0!).commandProcessHadError(Command($1), ProcessHandle($2!), $3!) }
        _delegate.command_process_had_output = { BuildSystem.toSystem($0!).commandProcessHadOutput(Command($1), ProcessHandle($2!), $3!) }
        _delegate.command_process_finished = { BuildSystem.toSystem($0!).commandProcessFinished(Command($1), ProcessHandle($2!), CommandExtendedResult($3!)) }
        _delegate.cycle_detected = {
            var rules = [BuildKey]()
            UnsafeBufferPointer(start: $1, count: Int($2)).forEach {
                rules.append(BuildKey(key: $0))
            }
            BuildSystem.toSystem($0!).cycleDetected(rules)
        }
        _delegate.should_resolve_cycle = {
            var rules = [BuildKey]()
            UnsafeBufferPointer(start: $1, count: Int($2)).forEach {
                rules.append(BuildKey(kind: $0.kind, key: String(cString: $0.key)))
            }
            let candidate = BuildKey(kind: $3.kind, key: String(cString: $3.key))

            let result = BuildSystem.toSystem($0!).shouldResolveCycle(rules, candidate, $4)

            return (result) ? 1 : 0;
        }

        // Create the system.
        _system = llb_buildsystem_create(_delegate, _invocation)
    }

    deinit {
        assert(_system != nil)
        llb_buildsystem_destroy(_system)
    }

    /// Build a single node.
    ///
    /// The client is responsible for ensuring only one build is ever executing concurrently.
    ///
    /// - parameter node: Path to a single node to build.
    /// - returns: True if the build was successful, false otherwise.
    public func build(node: String) -> Bool {
        var data = copiedDataFromBytes([UInt8](node.utf8))
        return llb_buildsystem_build_node(_system, &data)
    }

    /// Build the default target, or optionally a specific target.
    ///
    /// The client is responsible for ensuring only one build is ever executing concurrently.
    ///
    /// - parameter target: Optional name of the target to build.
    /// - returns: True if the build was successful, false otherwise.
    public func build(target: String? = nil) -> Bool {
        var data = target.map({ copiedDataFromBytes([UInt8]($0.utf8)) }) ?? llb_data_t(length: 0, data: nil)
        return llb_buildsystem_build(_system, &data)
    }

    /// Cancel any running build.
    public func cancel() {
        llb_buildsystem_cancel(_system)
    }

    /// MARK: Internal Delegate Implementation

    /// Helper function for getting the system from the delegate context.
    static private func toSystem(_ context: UnsafeMutableRawPointer) -> BuildSystem {
        return Unmanaged<BuildSystem>.fromOpaque(UnsafeRawPointer(context)).takeUnretainedValue()
    }

    /// Helper function for getting the tool wrapper from the delegate context.
    static private func toToolWrapper(_ context: UnsafeMutableRawPointer) -> ToolWrapper {
        return Unmanaged<ToolWrapper>.fromOpaque(UnsafeRawPointer(context)).takeUnretainedValue()
    }

    /// Helper function for getting the command wrapper from the delegate context.
    static fileprivate func toCommandWrapper(_ context: UnsafeMutableRawPointer) -> CommandWrapper {
        return Unmanaged<CommandWrapper>.fromOpaque(UnsafeRawPointer(context)).takeUnretainedValue()
    }

    private func fsGetFileContents(_ path: String, _ data: UnsafeMutablePointer<llb_data_t>) -> Bool {
        let fs = delegate.fs!

        // Get the contents for the file.
        guard let contents = try? fs.read(path) else {
            return false
        }

        data.pointee = copiedDataFromBytes(contents)

        return true
    }

    private func fsGetFileInfo(_ path: String, _ info: UnsafeMutablePointer<llb_fs_file_info_t>) {
        // Ignore invalid paths.
        guard path.first == "/" else {
            info.pointee = llb_fs_file_info_t()
            return
        }

        // If the path doesn't exist, it is missing.
        let fs = delegate.fs!
        guard let s = try? fs.getFileInfo(path).statBuf else {
            info.pointee = llb_fs_file_info_t()
            return
        }

        // Otherwise, we have some kind of file.
        info.pointee.device = UInt64(s.st_dev)
        info.pointee.inode = UInt64(s.st_ino)
        info.pointee.mode = UInt64(s.st_mode)
        info.pointee.size = UInt64(s.st_size)
        #if os(macOS)
        info.pointee.mod_time.seconds = UInt64(s.st_mtimespec.tv_sec)
        info.pointee.mod_time.nanoseconds = UInt64(s.st_mtimespec.tv_nsec)
        #else
        info.pointee.mod_time.seconds = UInt64(s.st_mtim.tv_sec)
        info.pointee.mod_time.nanoseconds = UInt64(s.st_mtim.tv_nsec)
        #endif
    }

    private func fsGetLinkInfo(_ path: String, _ info: UnsafeMutablePointer<llb_fs_file_info_t>) {
        // FIXME: We do not support this natively, yet.
        return fsGetFileInfo(path, info)
    }

    /// The owning list of all created tools.
    //
    // FIXME: This is lame, we should be able to destroy these naturally.
    private var toolWrappers: [ToolWrapper] = []
    private func lookupTool(_ name: UnsafePointer<llb_data_t>) -> OpaquePointer? {
        // Look up the named tool.
        guard let tool = delegate.lookupTool(stringFromData(name.pointee)) else {
            return nil
        }

        // If we got a tool, save it and create an appropriate low-level instance.
        let wrapper = ToolWrapper(tool: tool)
        self.toolWrappers.append(wrapper)
        var _delegate = llb_buildsystem_tool_delegate_t()
        _delegate.context = Unmanaged.passUnretained(wrapper).toOpaque()
        _delegate.create_command = { return BuildSystem.toToolWrapper($0!).createCommand($1!) }

        // Create the tool.
        return llb_buildsystem_tool_create(name, _delegate)
    }

    private func hadCommandFailure() {
        delegate.hadCommandFailure()
    }

    private func handleDiagnostic(_ kind: DiagnosticKind, _ filename: String, _ line: Int, _ column: Int, _ message: String) {
        // Clean up the location.
        let location: (filename: String, line: Int, column: Int)?
        if filename == "<unknown>" || (line == -1 && column == -1) {
            location = nil
        } else {
            location = (filename: filename, line: line, column: column)
        }

        delegate.handleDiagnostic(Diagnostic(kind: kind, location: location, message: message))
    }

    private func commandStatusChanged(_ command: Command, _ kind: CommandStatusKind) {
        delegate.commandStatusChanged(command, kind: kind)
    }

    private func commandPreparing(_ command: Command) {
        delegate.commandPreparing(command)
    }

    private func commandStarted(_ command: Command) {
        delegate.commandStarted(command)
    }

    private func shouldCommandStart(_ command: Command) -> Bool {
        return delegate.shouldCommandStart(command)
    }

    private func commandFinished(_ command: Command, _ result: CommandResult) {
        delegate.commandFinished(command, result: result)
    }

    private func commandHadError(_ command: Command, _ data: UnsafePointer<llb_data_t>) {
        delegate.commandHadError(command, message: stringFromData(data.pointee))
    }

    private func commandHadNote(_ command: Command, _ data: UnsafePointer<llb_data_t>) {
        delegate.commandHadNote(command, message: stringFromData(data.pointee))
    }

    private func commandHadWarning(_ command: Command, _ data: UnsafePointer<llb_data_t>) {
        delegate.commandHadWarning(command, message: stringFromData(data.pointee))
    }

    private func commandCannotBuildOutputDueToMissingInputs(_ command: Command, _ output: BuildKey, _ inputs: [BuildKey]) {
        delegate.commandCannotBuildOutputDueToMissingInputs(command, output: output, inputs: inputs)
    }

    private func cannotBuildNodeDueToMultipleProducers(_ output: BuildKey, _ commands: [Command]) {
        delegate.cannotBuildNodeDueToMultipleProducers(output: output, commands: commands)
    }

    private func commandProcessStarted(_ command: Command, _ process: ProcessHandle) {
        delegate.commandProcessStarted(command, process: process)
    }

    private func commandProcessHadError(_ command: Command, _ process: ProcessHandle, _ data: UnsafePointer<llb_data_t>) {
        delegate.commandProcessHadError(command, process: process, message: stringFromData(data.pointee))
    }

    private func commandProcessHadOutput(_ command: Command, _ process: ProcessHandle, _ data: UnsafePointer<llb_data_t>) {
        delegate.commandProcessHadOutput(command, process: process, data: bytesFromData(data.pointee))
    }

    private func commandProcessFinished(_ command: Command, _ process: ProcessHandle, _ result: CommandExtendedResult) {
        delegate.commandProcessFinished(command, process: process, result: result)
    }

    private func cycleDetected(_ rules: [BuildKey]) {
        delegate.cycleDetected(rules: rules)
    }

    private func shouldResolveCycle(_ rules: [BuildKey], _ candidate: BuildKey, _ action: CycleAction) -> Bool {
        return delegate.shouldResolveCycle(rules: rules, candidate: candidate, action: action)
    }


    /// Toggle tracing
    public static func setTracing(enabled: Bool) {
        if (enabled) {
            llb_enable_tracing()
        } else {
            llb_disable_tracing()
        }
    }

    public typealias SchedulerAlgorithm = llbuild.SchedulerAlgorithm

    /// Get the scheduler algorithm
    public static func getSchedulerAlgorithm() -> SchedulerAlgorithm {
        return schedulerAlgorithm
    }

    /// Set scheduler algorithm
    public static func setSchedulerAlgorithm(_ algorithm: SchedulerAlgorithm) {
        schedulerAlgorithm = algorithm
    }

    /// Get scheduler lane width
    public static func getSchedulerLaneWidth() -> UInt32 {
        return schedulerLanes
    }

    /// Set scheduler lane width
    public static func setSchedulerLaneWidth(width: UInt32) {
        schedulerLanes = width
    }
}

