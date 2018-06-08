
import Foundation
import SDGSwiftConfiguration

/// A sample configuration context.
public struct SampleContext : Context {

    // MARK: - Static Properties

    internal static let context: SampleContext? = SampleContext.accept()

    // MARK: - Initialization

    /// Creates the context.
    public init(path: String) {
        self.path = path
    }

    // MARK: - Properties

    /// The path of the configuration file.
    internal var path: String
}
