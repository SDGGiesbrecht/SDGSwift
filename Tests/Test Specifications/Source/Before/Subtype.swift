extension String {

    public struct Subtype : CustomStringConvertible {

        internal init() {}

        public var description: String {
            return ""
        }
    }

    public typealias AliasedSubtype = Int
}
