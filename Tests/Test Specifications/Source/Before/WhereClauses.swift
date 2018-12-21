extension Collection where Index == Element, Index : SignedNumeric, Index : CustomStringConvertible {
    public func requiresReorderedConstraints()
}

extension Collection : ConditionalConformance where Index == Element, Index == Int {}

extension BidirectionalCollection {
    public func forward<R>(_ range: R) -> Range<Self.Index> where R.Bound == ReversedCollection<Self>.Index {
        fatalError()
    }
}
