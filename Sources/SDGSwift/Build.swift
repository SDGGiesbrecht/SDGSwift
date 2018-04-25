

/// A package build.
public enum Build : Equatable {

    // MARK: - Cases

    case version(Version)
    case development

    // MARK: - Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
    public static func == (lhs: Build, rhs: Build) -> Bool {
        switch lhs {
        case .development:
            switch rhs {
            case .development:
                return true
            case .version:
                return false
            }
        case .version(let lhsVersion):
            switch rhs {
            case .development:
                return false
            case .version(let rhsVersion):
                return lhsVersion == rhsVersion
            }
        }
    }
}
