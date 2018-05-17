

@testable import SDGSwiftSource

import SDGLogicTestUtilities
import SDGXCTestUtilities

class SDGSwiftSourceInternalTests : TestCase {
    
    func testSourceKitUID() {
        do {
            testEquatableConformance(differingInstances: (try SourceKit.UID("A"), try SourceKit.UID("B")))
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testSourceKitVariant() {
        XCTAssertNotNil(SourceKit.Variant.dictionary([:]).asAny() as? [String: Any])
        XCTAssertNotNil(SourceKit.Variant.array([]).asAny() as? [Any])
        XCTAssertNotNil(SourceKit.Variant.integer(0).asAny() as? Int)
        XCTAssertNotNil(SourceKit.Variant.string("").asAny() as? String)
        XCTAssertNotNil(SourceKit.Variant.boolean(false).asAny() as? Bool)
    }
}
