
extension SourceKit {
    internal typealias UID /* sourcekitd_uid_t */ = UnsafeMutableRawPointer
}

extension SourceKit.UID {

    init(_ string: UnsafePointer<Int8>) throws {
        self = (try SourceKit.load(symbol: "sourcekitd_uid_get_from_cstr") as (@convention(c) (UnsafePointer<Int8>) -> SourceKit.UID?))(string)!
    }
}
