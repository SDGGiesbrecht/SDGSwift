extension Int {

    public let constantWithInferredType = 0

    // Escaped
    public let `var`: Int = 0

    public static let staticProperty: Int = 0

    public weak var optional: SomeType?

    public let (groupedInteger, groupedString) : (Int, String) = (0, "")
}

public class ObjectiveCClass : NSObject {
    @available(*, introduced: 4.2.1) @IBOutlet public weak static var delegate: NSObject?
    @NSCopying public var copyingProperty: NSString
}
