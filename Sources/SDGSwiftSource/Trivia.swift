
extension Trivia {

    public func source() -> String {
        return String(map({ $0.text }).joined())
    }
}
