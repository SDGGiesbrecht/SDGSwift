
#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax
#endif

extension SyntaxProtocol {

  // MARK: - Source

  // #documentation(SyntaxNode.text())
  /// Returns the source code of this syntax node.
  public func text() -> String {
    var result = ""
    write(to: &result)
    return result
  }

  // MARK: - Ancestry

  /// All the node’s ancestors in order from its immediate parent to the root node.
  public func ancestors() -> AnySequence<Syntax> {
    if let parent = self.parent {
      return AnySequence(sequence(first: parent, next: { $0.parent }))
    } else {
      return AnySequence([])
    }
  }

  internal func isInIfConfigurationCondition() -> Bool {
    var previousAncestor: Syntax = Syntax(self)
    for ancestor in ancestors() {
      defer { previousAncestor = ancestor }
      if let ifConfigurationClause = ancestor.as(IfConfigClauseSyntax.self),
        let condition = Syntax(ifConfigurationClause.condition),
        condition == previousAncestor
      {
        return true
      }
    }
    return false
  }
}
