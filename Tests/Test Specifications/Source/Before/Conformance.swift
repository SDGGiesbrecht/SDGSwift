public struct Conforming : CustomStringConvertible {

    public var description: String {
        return ""
    }
}

public protocol BaseProtocol {}
public protocol MoreSpecificProtocol : BaseProtocol {}
public struct Structure : MoreSpecificProtocol {}
