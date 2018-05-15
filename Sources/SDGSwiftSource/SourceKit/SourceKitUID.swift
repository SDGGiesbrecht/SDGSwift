/*
 SourceKitUID.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSourceKitShims

extension SourceKit {

    internal struct UID : Hashable {

        // MARK: - Initialization

        internal init(_ string: UnsafePointer<Int8>) throws {
            rawValue = (try SourceKit.load(symbol: "sourcekitd_uid_get_from_cstr") as (@convention(c) (UnsafePointer<Int8>) -> sourcekitd_uid_t?))(string)!
        }

        internal init(_ rawValue: sourcekitd_uid_t) {
            self.rawValue = rawValue
        }

        // MARK: - Properties

        internal let rawValue: sourcekitd_uid_t
        internal func string() throws -> String {
            return String(cString: (try SourceKit.load(symbol: "sourcekitd_uid_get_string_ptr") as (@convention(c) (sourcekitd_uid_t) -> (UnsafePointer<Int8>?)))(rawValue)!)
        }

        // MARK: - Equatable

        internal static func == (precedingValue: UID, followingValue: UID) -> Bool {
            return precedingValue.rawValue == followingValue.rawValue
        }

        // MARK: - Hashable

        internal var hashValue: Int {
            return rawValue.hashValue
        }
    }
}
