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
    private static func uninitializedLoad<Symbol>(symbol name: String) throws -> Symbol {
        // This loads symbols from https://github.com/apple/swift/blob/master/tools/SourceKit/tools/sourcekitd/include/sourcekitd/sourcekitd.h
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

    // MARK: - Symbols

    // Response

    private static func sourcekitd_response_is_error(_ object: sourcekitd_response_t) throws -> Bool {
        return (try load(symbol: "sourcekitd_response_is_error") as (@convention(c) (sourcekitd_response_t) -> Bool))(object)
    }

    private static func sourcekitd_response_error_get_description(_ error: sourcekitd_response_t) throws -> UnsafePointer<Int8>? {
        return (try load(symbol: "sourcekitd_response_error_get_description") as (@convention(c) (sourcekitd_response_t) -> UnsafePointer<Int8>?))(error)
    }

    // MARK: - Usage

    public static func test() throws {
        // [_Warning: Temporary._]
        let response = try Response(toRequest: try Object([
            try UID("key.request"): try Object(UID("source.request.indexsource")),
            try UID("key.sourcetext"): try Object("print(\"Hello, world!\")")
            ]))
        if try sourcekitd_response_is_error(response.rawValue) {
            let description = try sourcekitd_response_error_get_description(response.rawValue)!
            print(String(validatingUTF8: description)!)
        } else {
            print("No error.")
        }
    }
}
