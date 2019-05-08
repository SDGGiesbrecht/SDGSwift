
import SDGLocalization

import SDGSwiftLocalizations

extension Xcode {

    public enum SchemeError : PresentableError {

        // MARK: - Cases

        /// Foundation encountered an error.
        case foundationError(Swift.Error)

        /// The package has no Xcode project.
        case noXcodeProject

        // MARK: - PresentableError

        public func presentableDescription() -> StrictString {
            switch self {
            case .foundationError(let error):
                return StrictString(error.localizedDescription)
            case .noXcodeProject:
                return UserFacing<StrictString, InterfaceLocalization>({ localization in
                    switch localization {
                    case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                        return "The package has no Xcode project."
                    }
                }).resolved()
            }
        }
    }
}
