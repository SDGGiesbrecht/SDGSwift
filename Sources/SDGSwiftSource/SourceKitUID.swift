
import SDGSourceKitShims

extension SourceKit {

    internal struct UID : ExpressibleByStringLiteral, Hashable {

        // MARK: - Initialization

        internal init(_ string: UnsafePointer<Int8>) throws {
            rawValue = (try SourceKit.load(symbol: "sourcekitd_uid_get_from_cstr") as (@convention(c) (UnsafePointer<Int8>) -> sourcekitd_uid_t?))(string)!
        }

        // MARK: - Properties

        internal let rawValue: sourcekitd_uid_t
        private func string() throws -> String {
            return String(cString: (try SourceKit.load(symbol: "sourcekitd_uid_get_string_ptr") as (@convention(c) (sourcekitd_uid_t) -> (UnsafePointer<Int8>?)))(rawValue)!)
        }

        // MARK: - Equatable

        internal static func == (precedingValue: UID, followingValue: UID) -> Bool {
            return precedingValue.rawValue == followingValue.rawValue
        }

        // MARK: - ExpressibleByStringLiteral

        internal init(stringLiteral: String) {
            try! self.init(stringLiteral)
        }

        // MARK: - Hashable

        internal var hashValue: Int {
            return rawValue.hashValue
        }
    }
}
