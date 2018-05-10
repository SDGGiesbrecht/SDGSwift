
extension SourceKit {

    internal typealias sourcekitd_uid_t = UnsafeMutableRawPointer
    internal struct UID {

        // MARK: - Initialization

        internal init(_ string: UnsafePointer<Int8>) throws {
            rawValue = (try SourceKit.load(symbol: "sourcekitd_uid_get_from_cstr") as (@convention(c) (UnsafePointer<Int8>) -> sourcekitd_uid_t?))(string)!
        }

        // MARK: - Properties

        internal let rawValue: sourcekitd_uid_t
    }
}
