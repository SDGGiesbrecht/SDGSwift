public struct Conforming : CustomStringConvertible {

    public var description: String {
        return ""
    }
}

public protocol BaseProtocol {}
public protocol MoreSpecificProtocol {}
public struct Structure : MoreSpecificProtocol {}
