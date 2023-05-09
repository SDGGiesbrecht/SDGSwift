internal protocol FragmentProtocol {

  func localAncestorsOfChild(
    at index: Int,
    cache: inout ParserCache
  ) -> [ParentRelationship]
}
