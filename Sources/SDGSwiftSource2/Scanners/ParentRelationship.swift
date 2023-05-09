/// A relationship between a parent node and one of its child nodes.
public struct ParentRelationship {

  /// The parent node.
  let node: SyntaxNode

  /// The index of the child among the parent’s children.
  let childIndex: Int
}
