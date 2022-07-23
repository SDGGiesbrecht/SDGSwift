import SymbolKit

/// The API of a module.
public struct ModuleAPI {

  /// Creates a module API.
  ///
  /// - Parameters:
  ///   - name: The name of the module.
  public init(name: String, symbolGraphs: [SymbolGraph]) {
    self.name = name
    self.symbolGraphs = symbolGraphs
  }

  /// The name of the module.
  public var name: String

  /// The module’s symbol graphs.
  public var symbolGraphs: [SymbolGraph]

  /// The module’s declaration.
  public var declaration: [SymbolGraph.Symbol.DeclarationFragments.Fragment] {
    return [
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .text,
        spelling: ".",
        preciseIdentifier: nil
      ),
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .identifier,
        spelling: "target",
        preciseIdentifier: nil
      ),
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .text,
        spelling: "(",
        preciseIdentifier: nil
      ),
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .externalParameter,
        spelling: "name",
        preciseIdentifier: nil
      ),
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .text,
        spelling: ":",
        preciseIdentifier: nil
      ),
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .text,
        spelling: " ",
        preciseIdentifier: nil
      ),
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .stringLiteral,
        spelling: "\u{22}\(name)\u{22}",
        preciseIdentifier: nil
      ),
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .text,
        spelling: ")",
        preciseIdentifier: nil
      ),
    ]
  }
}
