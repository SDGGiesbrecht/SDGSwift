
import SDGLogic

extension SyntaxChildren {

    public var isEmpty: Bool {
        return self.first(where: { _ in true }) ≠ nil
    }
}
