
extension SourceKit {

    internal typealias sourcekitd_variant_t = UnsafeMutableRawPointer
    internal enum Variant {

        // MARK: - Initialization

        internal init?(_ rawValue: sourcekitd_variant_t) throws {
            // [_Warning: Cannot extract value._]
            print("Cannot extract value.")
            return nil
        }

        // MARK: - Properties

        case unknown
    }
}
