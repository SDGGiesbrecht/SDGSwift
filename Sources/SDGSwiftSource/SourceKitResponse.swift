
extension SourceKit {

    internal typealias sourcekitd_response_t = UnsafeMutableRawPointer
    internal final class Response {

        // MARK: - Initialization

        internal init(toRequest request: Object) throws {
            self.rawValue = (try load(symbol: "sourcekitd_send_request_sync") as (@convention(c) (sourcekitd_object_t) -> sourcekitd_response_t?))(request.rawValue)!
        }

        deinit {
            if let dispose = (try? load(symbol: "sourcekitd_response_dispose") as (@convention(c) (sourcekitd_response_t) -> Void)) {
                dispose(rawValue)
            }
        }

        // MARK: - Properties

        internal let rawValue: sourcekitd_response_t
    }
}
