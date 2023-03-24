
/// A heading in source code.
public struct SourceHeadingSyntax: ExtendedSyntax {

  // MARK: - Static Properties

  /// The fullest form of delimiter.
  public static let fullDelimiter: String = "MARK: \u{2D} "
  internal static let minimalDelimiter: String = "MARK:"
  
  // MARK: - Initialization

  /// Creates a line comment syntax node.
  ///
  /// - Parameters:
  ///   - mark: The delimiter.
  ///   - heading: The heading.
  public init(
    mark: ExtendedTokenSyntax = ExtendedTokenSyntax(kind: .mark(SourceHeadingSyntax.fullDelimiter)),
    heading: ExtendedTokenSyntax
  ) {
    self.mark = mark
    self.heading = heading
  }

  // MARK: - Properties
  
  /// The delimiter.
  public let mark: ExtendedTokenSyntax

  /// The heading.
  public let heading: ExtendedTokenSyntax

  // MARK: - ExtendedSyntax

  public var children: [ExtendedSyntax] {
    return [mark, heading]
  }
}
