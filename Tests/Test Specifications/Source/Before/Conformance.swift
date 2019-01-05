public struct Conforming : CustomStringConvertible {

    public var description: String {
        return ""
    }
}

public protocol BaseProtocol {
    func baseProtocolMethod()
    associatedtype AssociatedType
    init()
    var protocolVariable: Int
    subscript(protocolSubscript: Int) -> Int
}
public protocol MoreSpecificProtocol : BaseProtocol {
    func moreSpecificProtocolMethod()
}
public struct Structure : MoreSpecificProtocol {
    public func baseProtocolMethod()
    public func moreSpecificProtocolMethod()
    public typealias AssociatedType = Int
    public init() {}
    public var protocolVariable: Int = 0
    public subscript(protocolSubscript: Int) -> Int { return 0 }
}
