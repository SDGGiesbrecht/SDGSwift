public enum RootType {}

extension RootType {
    public enum IntermediateType {}
}

extension RootType.IntermediateType {
    public enum LeafType {}
}

extension RootType.IntermediateType.LeafType {
    public enum NestedAbsurdlyDeep {}
}
