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

import SDGControlFlow

import SDGSwift

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
    private static func load<Symbol>(symbol name: String) throws -> Symbol {
        let loadedSymbol = try cached(in: &loaded[name]) {
            guard let loaded = dlsym(try library(), name) else {
                throw SourceKit.Error.currentDynamicLinkerError()
            }
            return unsafeBitCast(loaded, to: Symbol.self)
        }
        return loadedSymbol as! Symbol
    }

    // MARK: - Symbols

    // Spread these out into their own types.

    // From https://github.com/apple/swift/blob/master/tools/SourceKit/tools/sourcekitd/include/sourcekitd/sourcekitd.h

    // SourceKit

    private static func sourcekitd_initialize() throws {
        (try load(symbol: "sourcekitd_initialize") as (@convention(c) () -> Void))()
    }

    // UID

    private typealias sourcekitd_uid_t = UnsafeMutableRawPointer
    private static func sourcekitd_uid_get_from_cstr(_ string: UnsafePointer<Int8>) throws -> sourcekitd_uid_t? {
        return (try load(symbol: "sourcekitd_uid_get_from_cstr") as (@convention(c) (UnsafePointer<Int8>) -> sourcekitd_uid_t?))(string)
    }

    // Object

    private typealias sourcekitd_object_t = UnsafeMutableRawPointer
    private static func sourcekitd_request_release(_ object: sourcekitd_object_t) throws {
        (try load(symbol: "sourcekitd_request_release") as (@convention(c) (sourcekitd_object_t) -> Void))(object)
    }

    private static func sourcekitd_request_dictionary_create(_ keys: UnsafePointer<sourcekitd_uid_t?>?, _ values: UnsafePointer<sourcekitd_object_t?>?, _ count: Int) throws -> sourcekitd_object_t? {
        return (try load(symbol: "sourcekitd_request_dictionary_create") as (@convention(c) (UnsafePointer<sourcekitd_uid_t?>?, UnsafePointer<sourcekitd_object_t?>?, Int) -> sourcekitd_object_t?))(keys, values, count)
    }

    private static func sourcekitd_request_array_create(_ objects: UnsafePointer<sourcekitd_object_t?>?, count: Int) throws -> sourcekitd_object_t? {
        return (try load(symbol: "sourcekitd_request_array_create") as (@convention(c) (UnsafePointer<sourcekitd_object_t?>?, Int) -> sourcekitd_object_t?))(objects, count)
    }

    private static func sourcekitd_request_uid_create(_ uid: sourcekitd_uid_t) throws -> sourcekitd_object_t? {
        return (try load(symbol: "sourcekitd_request_uid_create") as (@convention(c) (sourcekitd_uid_t) -> sourcekitd_object_t?))(uid)
    }

    private static func sourcekitd_request_string_create(_ string: UnsafePointer<Int8>) throws -> sourcekitd_object_t? {
        return (try load(symbol: "sourcekitd_request_string_create") as (@convention(c) (UnsafePointer<Int8>) -> sourcekitd_object_t?))(string)
    }

    // Response

    private typealias sourcekitd_response_t = UnsafeMutableRawPointer
    private static func sourcekitd_response_dispose(_ object: sourcekitd_response_t) throws {
        (try load(symbol: "sourcekitd_response_dispose") as (@convention(c) (sourcekitd_response_t) -> Void))(object)
    }

    private static func sourcekitd_send_request_sync(_ request: sourcekitd_object_t) throws -> sourcekitd_response_t? {
        return (try load(symbol: "sourcekitd_send_request_sync") as (@convention(c) (sourcekitd_object_t) -> sourcekitd_response_t?))(request)
    }

    private static func sourcekitd_response_is_error(_ object: sourcekitd_response_t) throws -> Bool {
        return (try load(symbol: "sourcekitd_response_is_error") as (@convention(c) (sourcekitd_response_t) -> Bool))(object)
    }

    private static func sourcekitd_response_error_get_description(_ error: sourcekitd_response_t) throws -> UnsafePointer<Int8>? {
        return (try load(symbol: "sourcekitd_response_error_get_description") as (@convention(c) (sourcekitd_response_t) -> UnsafePointer<Int8>?))(error)
    }

    // MARK: - Usage

    public static func test() throws {
        // [_Warning: Temporary._]
        _ = try SourceKit.sourcekitd_initialize()
        let keys: [sourcekitd_uid_t?] = [
            try sourcekitd_uid_get_from_cstr("key.request"),
            try sourcekitd_uid_get_from_cstr("key.sourcetext"),
        ]
        let values: [sourcekitd_object_t?] = [
            try sourcekitd_request_uid_create(sourcekitd_uid_get_from_cstr("source.request.indexsource")!),
            try sourcekitd_request_string_create("print(\"Hello, world!\")"),
        ]
        let request = try sourcekitd_request_dictionary_create(keys, values, keys.count)
        let result = try sourcekitd_send_request_sync(request!)!
        if try sourcekitd_response_is_error(result) {
            let description = try sourcekitd_response_error_get_description(result)!
            print(String(validatingUTF8: description)!)
        } else {
            print("No error.")
        }
    }
}
