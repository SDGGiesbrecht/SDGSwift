
import SDGControlFlow

import SDGSourceKitShims

extension SourceKit {

    internal final class Object {

        // MARK: - Initialization

        internal init(_ uid: UID) throws {
            rawValue = (try load(symbol: "sourcekitd_request_uid_create") as (@convention(c) (sourcekitd_uid_t) -> sourcekitd_object_t?))(uid.rawValue)!
        }

        internal init(_ string: String) throws {
            rawValue = (try load(symbol: "sourcekitd_request_string_create") as (@convention(c) (UnsafePointer<Int8>) -> sourcekitd_object_t?))(string)!
        }

        internal init(_ array: [Object]) throws {
            let elements: [sourcekitd_object_t?] = array.map { $0.rawValue }
            rawValue = (try load(symbol: "sourcekitd_request_array_create") as (@convention(c) (UnsafePointer<sourcekitd_object_t?>?, Int) -> sourcekitd_object_t?))(elements, elements.count)!
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
            if let release = (try? load(symbol: "sourcekitd_request_release") as (@convention(c) (sourcekitd_object_t) -> Void)) {
                release(rawValue)
            } else {
                if BuildConfiguration.current == .debug {
                    print("Memory leak! Failed to link “sourcekitd_request_release”.")
                }
            }
        }

        // MARK: - Properties

        internal let rawValue: sourcekitd_object_t
    }
}
