/*
 SourceKitObject.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

import SDGSourceKitShims

extension SourceKit {

    internal class Object {

        // MARK: - Initialization

        internal init(_ uid: UID) throws {
            rawValue = (try load(symbol: "sourcekitd_request_uid_create") as (@convention(c) (sourcekitd_uid_t) -> sourcekitd_object_t?))(uid.rawValue)!
        }

        internal init(_ string: String) throws {
            rawValue = (try load(symbol: "sourcekitd_request_string_create") as (@convention(c) (UnsafePointer<Int8>) -> sourcekitd_object_t?))(string)!
        }

        internal init(_ dictionary: [UID: Object]) throws {
            var keys: [sourcekitd_uid_t?] = []
            var values: [sourcekitd_object_t?] = []
            for (key, value) in dictionary {
                keys.append(key.rawValue) // [_Exempt from Test Coverage_] False coverage result in Xcode 9.3
                values.append(value.rawValue)
            }
            rawValue = (try load(symbol: "sourcekitd_request_dictionary_create") as (@convention(c) (UnsafePointer<sourcekitd_uid_t?>?, UnsafePointer<sourcekitd_object_t?>?, Int) -> sourcekitd_object_t?))(keys, values, keys.count)!
        }

        deinit {
            if let release = (try? load(symbol: "sourcekitd_request_release") as (@convention(c) (sourcekitd_object_t) -> Void)) {
                release(rawValue) // [_Exempt from Test Coverage_] False coverage result in Xcode 9.3
            } else {
                if BuildConfiguration.current == .debug {
                    print("Memory leak! Failed to link “sourcekitd_request_release”.") // [_Exempt from Test Coverage_]
                }
            }
        }

        // MARK: - Properties

        internal let rawValue: sourcekitd_object_t
    }
}
