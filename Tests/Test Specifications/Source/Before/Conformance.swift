public struct Conforming : CustomStringConvertible {

    public var description: String {
        return ""
    }
}

public protocol BaseProtocol {
    func baseProtocolMethod()
}
public protocol MoreSpecificProtocol : BaseProtocol {
    func moreSpecificProtocolMethod()
}
public struct Structure : MoreSpecificProtocol {
    public func baseProtocolMethod()
    public func moreSpecificProtocolMethod()
}
