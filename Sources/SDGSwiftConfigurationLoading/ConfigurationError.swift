
import SDGSwiftLocalizations

extension Configuration {

    /// An error encountered while loading a configuration.
    public enum Error : PresentableError {

        // MARK: - Cases

        /// The configuration is empty.
        case emptyConfiguration

        /// The configuration is corrupt.
        case corruptConfiguration

        // MARK: - PresentableError

        // [_Inherit Documentation: SDGCornerstone.PresentableError.presentableDescription()_]
        /// Returns a localized description of the error.
        public func presentableDescription() -> StrictString {
            switch self {
            case .emptyConfiguration:
                return UserFacing<StrictString, InterfaceLocalization>({ localization in
                    switch localization {
                    case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                        return "The configuration is empty."
                    }
                }).resolved()
            case .corruptConfiguration:
                return UserFacing<StrictString, InterfaceLocalization>({ localization in
                    switch localization {
                    case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                        return "The configuration is corrupt."
                    }
                }).resolved()
            }
        }
    }
}
