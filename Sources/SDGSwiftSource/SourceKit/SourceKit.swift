/*
 SourceKit.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic
import SDGControlFlow

import SDGSwift
import SDGSourceKitShims

/// SourceKit.
public enum SourceKit {

    // MARK: - Locating

    private static var located: UnsafeMutableRawPointer?
    private static func library() throws -> UnsafeMutableRawPointer {
        return try cached(in: &located) {
            guard let library = dlopen(try SwiftCompiler._sourceKitLocation().path, RTLD_LAZY) else {
                throw SourceKit.Error.currentDynamicLinkerError()
            }

            return library
        }
    }

    private static var loaded: [String: Any] = [:]
    private static func uninitializedLoad<Symbol>(symbol name: String) throws -> Symbol {
        let loadedSymbol = try cached(in: &loaded[name]) {
            guard let loaded = dlsym(try library(), name) else {
                throw SourceKit.Error.currentDynamicLinkerError()
            }
            return unsafeBitCast(loaded, to: Symbol.self)
        }
        return loadedSymbol as! Symbol
    }

    private static var initialized: Bool = false
    internal static func load<Symbol>(symbol name: String) throws -> Symbol {
        if ¬initialized {
            (try uninitializedLoad(symbol: "sourcekitd_initialize") as (@convention(c) () -> Void))()
            initialized = true
        }
        return try uninitializedLoad(symbol: name)
    }

    // MARK: - Usage

    internal static func query(withRequest request: Object) throws -> Variant? {
        let response = (try load(symbol: "sourcekitd_send_request_sync") as (@convention(c) (sourcekitd_object_t) -> sourcekitd_response_t?))(request.rawValue)!
        defer {
            if let dispose = try? load(symbol: "sourcekitd_response_dispose") as (@convention(c) (sourcekitd_response_t) -> Void) {
                dispose(response)
            } else {
                if BuildConfiguration.current == .debug {
                    print("Memory leak! Failed to link “sourcekitd_response_dispose”.")
                }
            }
        }

        guard ¬(try load(symbol: "sourcekitd_response_is_error") as (@convention(c) (sourcekitd_response_t) -> Bool))(response) else {
            let cString = (try load(symbol: "sourcekitd_response_error_get_description") as (@convention(c) (sourcekitd_response_t) -> UnsafePointer<Int8>?))(response)!
            throw SourceKit.Error.sourceKitError(description: String(cString: cString))
        }

        return try Variant((try load(symbol: "sourcekitd_response_get_value") as (@convention(c) (sourcekitd_response_t) -> sourcekitd_variant_t))(response))
    }

    internal static func parse(file: URL) throws -> SourceKit.Variant {
        let response = try SourceKit.query(withRequest: try Object([
            try UID("key.request"): try Object(UID("source.request.editor.open")),
            try UID("key.name"): try Object(file.path),
            try UID("key.sourcefile"): try Object(file.path)
            ]))
        guard let variant = response else {
            throw SourceKit.Error.unknownResponse(contents: Variant?.none as Any)
        }
        return variant
    }
}
