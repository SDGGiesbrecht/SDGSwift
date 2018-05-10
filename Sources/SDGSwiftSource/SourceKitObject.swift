
extension SourceKit {

    internal typealias sourcekitd_object_t = UnsafeMutableRawPointer
    internal final class Object {

        // MARK: - Initialization

        internal init(_ uid: UID) throws {
            rawValue = (try load(symbol: "sourcekitd_request_uid_create") as (@convention(c) (sourcekitd_uid_t) -> sourcekitd_object_t?))(uid.rawValue)!
        }

        // MARK: - Properties

        internal let rawValue: sourcekitd_object_t
    }
}
