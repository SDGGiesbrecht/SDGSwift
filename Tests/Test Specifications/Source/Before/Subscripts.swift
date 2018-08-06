
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
}
