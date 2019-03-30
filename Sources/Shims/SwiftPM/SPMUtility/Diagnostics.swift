/*
 This source file is part of the Swift.org open source project

 Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
 Licensed under Apache License v2.0 with Runtime Library Exception

 See http://swift.org/LICENSE.txt for license information
 See http://swift.org/CONTRIBUTORS.txt for Swift project authors
*/

import Basic

/// Represents an object which can be converted into a diagnostic data.
public protocol DiagnosticDataConvertible {

    /// Diagnostic data representation of this instance.
    var diagnosticData: DiagnosticData { get }
}

/// DiagnosticData wrapper for Swift errors.
public struct AnyDiagnostic: DiagnosticData {
    public static let id = DiagnosticID(
        type: AnyDiagnostic.self,
        name: "org.swift.diags.anyerror",
        description: {
            $0 <<< { "\($0.anyError)" }
        }
    )

    public let anyError: Swift.Error

    public init(_ error: Swift.Error) {
        self.anyError = error
    }
}

/// Represents unknown diagnostic location.
public final class UnknownLocation: DiagnosticLocation {

    /// The singleton instance.
    public static let location = UnknownLocation()

    private init() {}

    public var localizedDescription: String {
        return "<unknown>"
    }
}

extension DiagnosticsEngine {

    /// Emit a diagnostic with an unknown location.
    public func emit(data: DiagnosticData) {
        emit(data: data, location: UnknownLocation.location)
    }

    /// Emit a Swift error.
    ///
    /// Errors will be converted into diagnostic data if possible.
    /// Otherwise, they will be emitted as AnyDiagnostic.
    public func emit(
        _ error: Swift.Error,
        location: DiagnosticLocation = UnknownLocation.location
    ) {
        if let diagnosticData = error as? DiagnosticData {
            emit(data: diagnosticData, location: location)
        } else if case let convertible as DiagnosticDataConvertible = error {
            emit(convertible, location: location)
        } else {
            emit(data: AnyDiagnostic(error), location: location)
        }
    }

    /// Emit a diagnostic data convertible instance.
    public func emit(
        _ convertible: DiagnosticDataConvertible,
        location: DiagnosticLocation = UnknownLocation.location
     ) {
        emit(data: convertible.diagnosticData, location: location)
    }

    /// Wrap a throwing closure, returning an optional value and
    /// emitting any thrown errors.
    ///
    /// - Parameters:
    ///     - closure: Closure to wrap.
    /// - Returns: Returns the return value of the closure wrapped
    ///   into an optional. If the closure throws, nil is returned.
    public func wrap<T>(
        with constuctLocation: @autoclosure () -> (DiagnosticLocation) = UnknownLocation.location,
        _ closure: () throws -> T
    ) -> T? {
        do {
            return try closure()
        } catch {
            emit(error, location: constuctLocation())
            return nil
        }
    }
    
    /// Wrap a throwing closure, returning a success boolean and
    /// emitting any thrown errors.
    ///
    /// - Parameters:
    ///     - closure: Closure to wrap.
    /// - Returns: Returns true if the wrapped closure did not throw
    ///   and false otherwise.
    @discardableResult
    public func wrap(
        with constuctLocation: @autoclosure () -> (DiagnosticLocation) = UnknownLocation.location,
        _ closure: () throws -> Void
    ) -> Bool {
        do {
            try closure()
            return true
        } catch {
            emit(error, location: constuctLocation())
            return false
        }
    }
}

/// Namespace for representing diagnostic location of a package.
public enum PackageLocation {

    /// Represents location of a locally available package. This could be root
    /// package, edited dependency or checked out dependency.
    public struct Local: DiagnosticLocation {

        /// The name of the package, if known.
        public let name: String?

        /// The path to the package.
        public let packagePath: AbsolutePath

        public init(name: String? = nil, packagePath: AbsolutePath) {
            self.name = name
            self.packagePath = packagePath
        }

        public var localizedDescription: String {
            let stream = BufferedOutputByteStream()
            if let name = name {
                stream <<< "'\(name)' "
            }
            stream <<< packagePath.pathString
            return stream.bytes.description
        }
    }

    /// Represents location a remote package with no checkout on disk.
    public struct Remote: DiagnosticLocation {

        /// The URL of the package.
        public let url: String

        /// The source control reference of the package. It could be version, branch, revision etc.
        public let reference: String

        public init(url: String, reference: String) {
            self.url = url
            self.reference = reference
        }

        public var localizedDescription: String {
            return url + " @ " + reference
        }
    }
}

/// An Swift error enum that can be used as a stub to early exit from a method.
///
/// It is not expected for this enum to contain any payload or information about the
/// error. The actual errors and warnings are supposed to be added using the Diagnostics
/// engine.
public enum Diagnostics: Swift.Error {
    case fatalError
}

/// Diagnostic for the process execution failure.
public struct ProcessExecutionError: DiagnosticData {
    public static let id = DiagnosticID(
        type: ProcessExecutionError.self,
        name: "org.swift.diags.process.execution",
        description: {
            $0 <<< { "The '" + $0.result.arguments[0] + "' subprocess exited with" }
            $0 <<< .substitution({
                let `self` = $0 as! ProcessExecutionError
                switch self.result.exitStatus {
                case .terminated(let code):
                    return "termination code \(code)"
                case .signalled(let signal):
                    return "signal \(signal)"
                }
            })
            $0 <<< ".\n"

            $0 <<< "stdout: " <<< .substitution({
                (try? ($0 as! ProcessExecutionError).result.utf8Output()) ?? ""
            }) <<< "\n"
            $0 <<< "stderr: " <<< .substitution({
                (try? ($0 as! ProcessExecutionError).result.utf8stderrOutput()) ?? ""
            }) <<< "\n"
        }
    )

    /// The process result.
    public let result: ProcessResult

    public init(_ result: ProcessResult) {
        self.result = result
    }
}
