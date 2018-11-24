import Foundation

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
