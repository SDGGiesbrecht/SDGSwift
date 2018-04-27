
import SDGLocalization

import SDGSwiftLocalizations

extension Package {

    /// An error that occurs while trying to use a remote package.
    public enum Error : PresentableError {

        // MARK: - Cases

        /// The package did not produce an executable with any of the requested names.
        case noSuchExecutable(requested: Set<StrictString>)

        // MARK: - PresentableError

        // [_Inherit Documentation: SDGCornerstone.PresentableError.presentableDescription()_]
        /// Returns a localized description of the error.
        public func presentableDescription() -> StrictString {
            switch self {
            case .noSuchExecutable(requested: let requested):
                var details: StrictString = "\n"
                details += StrictString(requested.sorted().joined(separator: "\n".scalars))

                return UserFacing<StrictString, InterfaceLocalization>({ localization in
                    switch localization {
                    case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                        return "The package did not produce an executable with any of the requested names:" + StrictString(details)
                    }
                }).resolved()
            }
        }
    }
}
