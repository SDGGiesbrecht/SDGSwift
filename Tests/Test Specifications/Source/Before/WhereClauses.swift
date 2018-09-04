extension Collection where Index == Element, Index : SignedNumeric, Index : CustomStringConvertible {
    public func requiresReorderedConstraints()
}

extension Collection : ConditionalConformance where Index == Element, Index == Int {}
