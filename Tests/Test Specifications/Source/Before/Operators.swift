extension Bool {

    public static func += (precedingValue: inout Bool, followingValue: Bool) {}
    public static func − (_ explicitlyUnlabelledParameters: Int, _ b: Int) -> Int {
        return b
    }
}

extension Int {
    public static prefix func − (operand: Int) -> Int {
        return operand
    }
    public static postfix func ! (operand: Int) -> Int {
        return operand
    }
}

infix operator ≠: ComparisonPrecedence

precedencegroup LotsOfAttributes {
    associativity: right
    higherThan: DoneAfter, AlsoDoneAfter
    lowerThan: DoneFirst, AlsoDoneFirst
    assignment: true
}

precedencegroup NoAttributes {}

@available(*, unavailable) infix operator ≠≠
@available(*, unavailable) precedencegroup UnavailablePrecedence {}
