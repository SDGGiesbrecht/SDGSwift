
extension SourceKit {

    internal typealias sourcekitd_object_t = UnsafeMutableRawPointer
    internal final class Object {

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
                keys.append(key.rawValue)
                values.append(value.rawValue)
            }

            rawValue = (try load(symbol: "sourcekitd_request_dictionary_create") as (@convention(c) (UnsafePointer<sourcekitd_uid_t?>?, UnsafePointer<sourcekitd_object_t?>?, Int) -> sourcekitd_object_t?))(keys, values, keys.count)!
        }

        deinit {
            try? Object.release(rawValue)
        }

        // MARK: - Properties

        internal let rawValue: sourcekitd_object_t

        // MARK: - Memory Management

        private static func retain(_ rawValue: sourcekitd_object_t) throws -> sourcekitd_object_t {
            return (try load(symbol: "sourcekitd_request_retain") as (@convention(c) (sourcekitd_object_t) -> (sourcekitd_object_t?)))(rawValue)!
        }

        private static func release(_ rawValue: sourcekitd_object_t) throws {
            (try load(symbol: "sourcekitd_request_release") as (@convention(c) (sourcekitd_object_t) -> Void))(rawValue)
        }
    }
}
