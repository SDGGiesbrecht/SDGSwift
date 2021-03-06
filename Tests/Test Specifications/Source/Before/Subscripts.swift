public struct Subscripted {

    public subscript(readOnly: Int) -> Int {
        return readOnly
    }

    public subscript(readWrite: String) -> String {
        get {
            return readWrite
        }
        set {
            something = readWrite
        }
    }

    public subscript(x x: Int, y y: Int) -> Int {
        return x × y
    }

    private subscript(private: UInt) -> UInt {
        return `private`
    }

    public subscript(inOutParameter: inout Bool) -> Bool {
        return false
    }

    public subscript(unlabelledIndex: Int) -> Int {
        return unlabelledIndex
    }
}

public struct AlsoSubscripted {
    public subscript(_ explicitlyUnlabelledIndex: Int) -> Int {
        return explicitlyUnlabelledIndex
    }
}
