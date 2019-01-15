/// Does something with a string.
public func overloadedFunction(_ string: String) {}
/// Does something with a string.
public func overloadedFunction(_ string: Character) {}

/// Does something with a number.
public func overloadedFunction(_ number: Int) {}

extension Bool {
    public func overloadedMethod(_ specific: Int) {}
    /// Does something with a number.
    public func overloadedMethod<T>(_ general: T) where T : Numeric {}
    public func overloadedMethod<T>(_ general: T) where T : SignedNumeric {}
}
