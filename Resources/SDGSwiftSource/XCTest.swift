open class XCTNSNotificationExpectation {
public init(name notificationName: Notification.Name, object: Any? = x, notificationCenter: NotificationCenter = x, file: StaticString = x, line: Int = x) {}
open var handler: Handler? { get set }
open var notificationCenter: NotificationCenter { get }
open var notificationName: Notification.Name { get }
open var observedObject: Any? { get }
}
open class XCTNSPredicateExpectation {
public init(predicate: NSPredicate, object: Any? = x, file: StaticString = x, line: Int = x) {}
open var handler: Handler? { get set }
open var object: Any? { get }
open var predicate: NSPredicate { get }
}
open class XCTWaiter {
open class func wait(for expectations: [XCTestExpectation], timeout: TimeInterval, enforceOrder: Bool = x, file: StaticString = x, line: Int = x) -> Result {}
public init(delegate: XCTWaiterDelegate? = x) {}
open var delegate: XCTWaiterDelegate? { get set }
public var description: String { get }
open var fulfilledExpectations: [XCTestExpectation] { get }
public func ==(lhs: XCTWaiter, rhs: XCTWaiter) -> Bool {}
@discardableResult open func wait(for expectations: [XCTestExpectation], timeout: TimeInterval, enforceOrder: Bool = x, file: StaticString = x, line: Int = x) -> Result {}
}
open class XCTest {
public init() {}
open var name: String { get }
open var testCaseCount: Int { get }
open var testRun: XCTestRun? { get }
open var testRunClass: AnyClass? { get }
open func perform(_ run: XCTestRun) {}
open func run() {}
open func setUp() {}
open func tearDown() {}
}
open class XCTestCase {
open class func setUp() {}
open class func tearDown() {}
public required init(name: String, testClosure: @escaping XCTestCaseClosure) {}
open var continueAfterFailure: Bool { get set }
open func invokeTest() {}
open func recordFailure(withDescription description: String, inFile filePath: String, atLine lineNumber: Int, expected: Bool) {}
}
open class XCTestCaseRun {
open func recordFailure(withDescription description: String, inFile filePath: String?, atLine lineNumber: Int, expected: Bool) {}
}
open class XCTestExpectation {
public init(description: String = x, file: StaticString = x, line: Int = x) {}
open var assertForOverFulfill: Bool { get set }
public var description: String { get }
open var expectationDescription: String { get set }
open var expectedFulfillmentCount: Int { get set }
open var isInverted: Bool { get set }
public func ==(lhs: XCTestExpectation, rhs: XCTestExpectation) -> Bool {}
open func fulfill(_ file: StaticString = x, line: Int = x) {}
public func hash(into hasher: inout Hasher) {}
}
open class XCTestRun {
public required init(test: XCTest) {}
open var executionCount: Int { get }
open var failureCount: Int { get }
open var hasSucceeded: Bool { get }
open var startDate: Date? { get }
open var stopDate: Date? { get }
public var test: XCTest { get }
open var testCaseCount: Int { get }
open var testDuration: TimeInterval { get }
open var totalDuration: TimeInterval { get }
open var totalFailureCount: Int { get }
open var unexpectedExceptionCount: Int { get }
open func start() {}
open func stop() {}
}
open class XCTestSuite {
public init(name: String) {}
open var tests { get }
open func addTest(_ test: XCTest) {}
}
open class XCTestSuiteRun {
open var testRuns { get }
open func addTestRun(_ testRun: XCTestRun) {}
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