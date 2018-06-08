
import SDGSwiftConfiguration

/// A sample configuration context.
public struct SampleContext : Context {

    // MARK: - Static Properties

    internal static let context: SampleContext? = SampleContext.accept()

    // MARK: - Initialization

    /// Creates the context.
    public init(information: String) {
        self.information = information
    }

    // MARK: - Properties

    /// Sample context information.
    internal var information: String
}
