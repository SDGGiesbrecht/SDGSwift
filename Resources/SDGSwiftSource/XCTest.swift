open class XCTNSNotificationExpectation {
public init(name notificationName: Notification.Name, object: Any? = default, notificationCenter: NotificationCenter = default, file: StaticString = default, line: Int = default) {}
public open var handler: Handler? { get set }
public open var notificationCenter: NotificationCenter { get }
public open var notificationName: Notification.Name { get }
public open var observedObject: Any? { get }
}
open class XCTNSPredicateExpectation {
public init(predicate: NSPredicate, object: Any? = default, file: StaticString = default, line: Int = default) {}
public open var handler: Handler? { get set }
public open var object: Any? { get }
public open var predicate: NSPredicate { get }
}
open class XCTWaiter {
public open class func wait(for expectations: [XCTestExpectation], timeout: TimeInterval, enforceOrder: Bool = default, file: StaticString = default, line: Int = default) -> Result {}
public init(delegate: XCTWaiterDelegate? = default) {}
public open var delegate: XCTWaiterDelegate? { get set }
public var description: String { get }
public open var fulfilledExpectations: [XCTestExpectation] { get }
public func ==(lhs: XCTWaiter, rhs: XCTWaiter) -> Bool {}
@discardableResult public open func wait(for expectations: [XCTestExpectation], timeout: TimeInterval, enforceOrder: Bool = default, file: StaticString = default, line: Int = default) -> Result {}
}
open class XCTest {
public init() {}
public open var name: String { get }
public open var testCaseCount: Int { get }
public open var testRun: XCTestRun? { get }
public open var testRunClass: AnyClass? { get }
public open func perform(_ run: XCTestRun) {}
public open func run() {}
public open func setUp() {}
public open func tearDown() {}
}
open class XCTestCase {
public open class func setUp() {}
public open class func tearDown() {}
public required init(name: String, testClosure: @escaping XCTestCaseClosure) {}
public open var continueAfterFailure: Bool { get set }
public open var name: String { get }
public open var testCaseCount: Int { get }
public open var testRunClass: AnyClass? { get }
public open func invokeTest() {}
public open func perform(_ run: XCTestRun) {}
public open func recordFailure(withDescription description: String, inFile filePath: String, atLine lineNumber: Int, expected: Bool) {}
}
open class XCTestCaseRun {
public open func recordFailure(withDescription description: String, inFile filePath: String?, atLine lineNumber: Int, expected: Bool) {}
public open func start() {}
public open func stop() {}
}
open class XCTestExpectation {
public init(description: String = default, file: StaticString = default, line: Int = default) {}
public open var assertForOverFulfill: Bool { get set }
public var description: String { get }
public open var expectationDescription: String { get set }
public open var expectedFulfillmentCount: Int { get set }
public open var isInverted: Bool { get set }
public func ==(lhs: XCTestExpectation, rhs: XCTestExpectation) -> Bool {}
public open func fulfill(_ file: StaticString = default, line: Int = default) {}
public func hash(into hasher: inout Hasher) {}
}
open class XCTestRun {
public required init(test: XCTest) {}
public open var executionCount: Int { get }
public open var failureCount: Int { get }
public open var hasSucceeded: Bool { get }
public open var startDate: Date? { get }
public open var stopDate: Date? { get }
public var test: XCTest { get }
public open var testCaseCount: Int { get }
public open var testDuration: TimeInterval { get }
public open var totalDuration: TimeInterval { get }
public open var totalFailureCount: Int { get }
public open var unexpectedExceptionCount: Int { get }
public open func start() {}
public open func stop() {}
}
open class XCTestSuite {
public init(name: String) {}
public open var name: String { get }
public open var testCaseCount: Int { get }
public open var testRunClass: AnyClass? { get }
public open var tests { get }
public open func addTest(_ test: XCTest) {}
public open func perform(_ run: XCTestRun) {}
}
open class XCTestSuiteRun {
public open var executionCount: Int { get }
public open var failureCount: Int { get }
public open var testRuns { get }
public open var totalDuration: TimeInterval { get }
public open var unexpectedExceptionCount: Int { get }
public open func addTestRun(_ testRun: XCTestRun) {}
public open func start() {}
public open func stop() {}
}
public protocol XCTWaiterDelegate {
public func nestedWaiter(_ waiter: XCTWaiter, wasInterruptedByTimedOutWaiter outerWaiter: XCTWaiter) {}
public func waiter(_ waiter: XCTWaiter, didFulfillInvertedExpectation expectation: XCTestExpectation) {}
public func waiter(_ waiter: XCTWaiter, didTimeoutWithUnfulfilledExpectations unfulfilledExpectations: [XCTestExpectation]) {}
public func waiter(_ waiter: XCTWaiter, fulfillmentDidViolateOrderingConstraintsFor expectation: XCTestExpectation, requiredExpectation: XCTestExpectation) {}
}
public protocol XCTestObservation {
public func testBundleDidFinish(_ testBundle: Bundle) {}
public func testBundleWillStart(_ testBundle: Bundle) {}
public func testCase(_ testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: Int) {}
public func testCaseDidFinish(_ testCase: XCTestCase) {}
public func testCaseWillStart(_ testCase: XCTestCase) {}
public func testSuiteDidFinish(_ testSuite: XCTestSuite) {}
public func testSuiteWillStart(_ testSuite: XCTestSuite) {}
}
extension XCTestCase {
public func nestedWaiter(_ waiter: XCTWaiter, wasInterruptedByTimedOutWaiter outerWaiter: XCTWaiter) {}
public func waiter(_ waiter: XCTWaiter, didFulfillInvertedExpectation expectation: XCTestExpectation) {}
public func waiter(_ waiter: XCTWaiter, didTimeoutWithUnfulfilledExpectations unfulfilledExpectations: [XCTestExpectation]) {}
public func waiter(_ waiter: XCTWaiter, fulfillmentDidViolateOrderingConstraintsFor expectation: XCTestExpectation, requiredExpectation: XCTestExpectation) {}
}
extension XCTestCase {
}
