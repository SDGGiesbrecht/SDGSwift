
extension SourceKit {

    internal typealias sourcekitd_object_t = UnsafeMutableRawPointer
    internal final class Object {

        // MARK: - Initialization

        internal init(_ uid: UID) throws {
            rawValue = try Object.retain((try load(symbol: "sourcekitd_request_uid_create") as (@convention(c) (sourcekitd_uid_t) -> sourcekitd_object_t?))(uid.rawValue)!)
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
