
/// A remote Swift package.
public struct Package {

    // MARK: - Initialization

    /// Creates an instance describing the package at the specified url.
    public init(url: URL) {
        self.url = url
    }

    // MARK: - Properties

    /// The URL of the package.
    public let url: URL
}
