
import Foundation
import SDGSwiftConfiguration

/// A sample configuration context.
public struct SampleContext : Context {

    // MARK: - Static Properties

    internal static let context: SampleContext? = SampleContext.accept()

    // MARK: - Initialization

    /// Creates the context.
    public init(location: URL) {
        self.location = location
    }

    // MARK: - Properties

    /// The location of the configuration file.
    internal var location: URL
}
