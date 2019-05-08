
import SDGLocalization

import SDGSwiftLocalizations

extension Xcode {

    public enum SchemeError : PresentableError {

        // MARK: - Cases

        /// The package has no Xcode project.
        case noXcodeProject

        // MARK: - PresentableError

        public func presentableDescription() -> StrictString {
            switch self {
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
