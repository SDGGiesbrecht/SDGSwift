import Foundation

/// Documentation before hidden attribute.
@_specialize(kind: full, where T == Int) public func withHiddenAttribute<T>(_ parameter: T) {}

@available(*, unavailable) public func unavailable() {}
@available(*, introduced: 4.2.1) public func introduced() {}
@available(*, deprecated: 4.2.1) public func deprecated() {}
@available(*, obsoleted: 4.2.1) public func obsoleted() {}

public class ObjectiveCObject : NSObject {
    @objc public func objectiveCMethod() {}
    @nonobjc public func swiftOnlyMethod() {}
}

@inlinable public func inlineable() {}

public func escaping(closure: @escaping () -> Void) {}
public func auto(closure: @autoclosure () -> Void) {}
@discardableResult public func discardableResult() -> Bool

extension ObjectiveCObject {
    @available(*, introduced: 4.2.1) @objc @discardableResult public func everything(_ closure: @escaping @autoclosure () -> Void) {}
}

@available(swift, introduced: 4.0, message: "Message.") public func introductionMessage() {}
