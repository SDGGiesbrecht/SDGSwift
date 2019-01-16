open class ManagedBuffer<Header, Element> {
    public var header: Header { get set }
}
public protocol AdditiveArithmetic {
    public static var zero: Self { get }
    public prefix func +(x: Self) -> Self {}
    public func +(lhs: Self, rhs: Self) -> Self {}
    public func +=(lhs: inout Self, rhs: Self) {}
    public func -(lhs: Self, rhs: Self) -> Self {}
    public func -=(lhs: inout Self, rhs: Self) {}
}
public protocol BidirectionalCollection {
    public var last: Element? { get }
    public subscript(position: Index) -> Element { get } {}
    public func formIndex(before i: inout Index) {}
    public func index(before i: Index) -> Index {}
    public func joined(separator: String = x) -> String  where Element == String {}
    public func last(where predicate: (Element) throws -> Bool) rethrows -> Element? {}
    public func lastIndex(of element: Element) -> Index?  where Element : Equatable {}
    public func lastIndex(where predicate: (Element) throws -> Bool) rethrows -> Index? {}
    public mutating func popLast() -> Element?  where Self == SubSequence {}
    @discardableResult public mutating func removeLast() -> Element  where Self == SubSequence {}
    public mutating func removeLast(_ k: Int)  where Self == SubSequence {}
}
public protocol BinaryFloatingPoint {
    public static var exponentBitCount: Int { get }
    public static var significandBitCount: Int { get }
    public static func random(in range: ClosedRange<Self>) -> Self  where RawSignificand : FixedWidthInteger {}
    public static func random(in range: Range<Self>) -> Self  where RawSignificand : FixedWidthInteger {}
    public static func random<T>(in range: ClosedRange<Self>, using generator: inout T) -> Self  where RawSignificand : FixedWidthInteger, T : RandomNumberGenerator {}
    public static func random<T>(in range: Range<Self>, using generator: inout T) -> Self  where RawSignificand : FixedWidthInteger, T : RandomNumberGenerator {}
    public init(sign: FloatingPointSign, exponentBitPattern: RawExponent, significandBitPattern: RawSignificand) {}
    public var binade: Self { get }
    public var exponentBitPattern: RawExponent { get }
    public var significandBitPattern: RawSignificand { get }
    public var significandWidth: Int { get }
}
public protocol BinaryInteger {
    public static var isSigned: Bool { get }
    public init() {}
    public init<T>(_ source: T)  where T : BinaryFloatingPoint {}
    public init<T>(_ source: T)  where T : BinaryInteger {}
    public init<T>(clamping source: T)  where T : BinaryInteger {}
    public init<T>(truncatingIfNeeded source: T)  where T : BinaryInteger {}
    public var bitWidth: Int { get }
    public var trailingZeroBitCount: Int { get }
    public var words: Words { get }
    public func %(lhs: Self, rhs: Self) -> Self {}
    public func %=(lhs: inout Self, rhs: Self) {}
    public func &(lhs: Self, rhs: Self) -> Self {}
    public func &=(lhs: inout Self, rhs: Self) {}
    public func /(lhs: Self, rhs: Self) -> Self {}
    public func /=(lhs: inout Self, rhs: Self) {}
    public func <<<RHS>(lhs: Self, rhs: RHS) -> Self  where RHS : BinaryInteger {}
    public func <<=<RHS>(lhs: inout Self, rhs: RHS)  where RHS : BinaryInteger {}
    public func <=<Other>(lhs: Self, rhs: Other) -> Bool  where Other : BinaryInteger {}
    public func ><Other>(lhs: Self, rhs: Other) -> Bool  where Other : BinaryInteger {}
    public func >=<Other>(lhs: Self, rhs: Other) -> Bool  where Other : BinaryInteger {}
    public func >><RHS>(lhs: Self, rhs: RHS) -> Self  where RHS : BinaryInteger {}
    public func >>=<RHS>(lhs: inout Self, rhs: RHS)  where RHS : BinaryInteger {}
    public func ^(lhs: Self, rhs: Self) -> Self {}
    public func ^=(lhs: inout Self, rhs: Self) {}
    public func isMultiple(of other: Self) -> Bool {}
    public func quotientAndRemainder(dividingBy rhs: Self) -> (quotient : Self, remainder : Self) {}
    public func quotientAndRemainder(dividingBy rhs: Self) -> (quotient : Self, remainder : Self) {}
    public func signum() -> Self {}
    public func |(lhs: Self, rhs: Self) -> Self {}
    public func |=(lhs: inout Self, rhs: Self) {}
    public prefix func ~(x: Self) -> Self {}
}
public protocol CVarArg {
}
public protocol CaseIterable {
    public static var allCases: AllCases { get }
}
public protocol Collection {
    public var count: Int { get }
    public var endIndex: Index { get }
    public var first: Element? { get }
    public var indices: DefaultIndices<Self> { get }  where DefaultIndices<Self> == Indices
    public var indices: Indices { get }
    public var isEmpty: Bool { get }
    public var isEmpty: Bool { get }
    public var startIndex: Index { get }
    public subscript(bounds: Range<Index>) -> Slice<Self> { get }  where Slice<Self> == SubSequence {}
    public subscript(bounds: Range<Index>) -> SubSequence { get } {}
    public subscript(x: UnboundedRange) -> SubSequence { get } {}
    public subscript<R>(r: R) -> SubSequence { get }  where R : RangeExpression, Index == R.Bound {}
    public func distance(from start: Index, to end: Index) -> Int {}
    public func firstIndex(of element: Element) -> Index?  where Element : Equatable {}
    public func firstIndex(where predicate: (Element) throws -> Bool) rethrows -> Index? {}
    public func formIndex(_ i: inout Index, offsetBy distance: Int) {}
    public func formIndex(_ i: inout Index, offsetBy distance: Int, limitedBy limit: Index) -> Bool {}
    public func formIndex(after i: inout Index) {}
    public func index(_ i: Index, offsetBy distance: Int) -> Index {}
    public func index(_ i: Index, offsetBy distance: Int, limitedBy limit: Index) -> Index? {}
    public func index(after i: Index) -> Index {}
    public func makeIterator() -> Iterator {}
    public mutating func popFirst() -> Element?  where Self == SubSequence {}
    public func randomElement() -> Element? {}
    public func randomElement<T>(using generator: inout T) -> Element?  where T : RandomNumberGenerator {}
    @discardableResult public mutating func removeFirst() -> Element  where Self == SubSequence {}
    public mutating func removeFirst(_ k: Int)  where Self == SubSequence {}
}
public protocol Comparable {
    public postfix func ...(minimum: Self) -> PartialRangeFrom<Self> {}
    public prefix func ...(maximum: Self) -> PartialRangeThrough<Self> {}
    public func ...(minimum: Self, maximum: Self) -> ClosedRange<Self> {}
    public prefix func ..<(maximum: Self) -> PartialRangeUpTo<Self> {}
    public func ..<(minimum: Self, maximum: Self) -> Range<Self> {}
    public func <(lhs: Self, rhs: Self) -> Bool {}
    public func <=(lhs: Self, rhs: Self) -> Bool {}
    public func <=(lhs: Self, rhs: Self) -> Bool {}
    public func >(lhs: Self, rhs: Self) -> Bool {}
    public func >(lhs: Self, rhs: Self) -> Bool {}
    public func >=(lhs: Self, rhs: Self) -> Bool {}
    public func >=(lhs: Self, rhs: Self) -> Bool {}
}
public protocol CustomDebugStringConvertible {
    public var debugDescription: String { get }
}
public protocol CustomLeafReflectable {
}
public protocol CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any { get }
}
public protocol CustomReflectable {
    public var customMirror: Mirror { get }
}
public protocol CustomStringConvertible {
    public var description: String { get }
}
public protocol Equatable {
    public func !=(lhs: Self, rhs: Self) -> Bool {}
    public func ==(lhs: Self, rhs: Self) -> Bool {}
}
public protocol Error {
}
public protocol ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: ArrayLiteralElement...) {}
}
public protocol ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: BooleanLiteralType) {}
}
public protocol ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (Key, Value)...) {}
}
public protocol ExpressibleByExtendedGraphemeClusterLiteral {
    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {}
}
public protocol ExpressibleByFloatLiteral {
    public init(floatLiteral value: FloatLiteralType) {}
}
public protocol ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {}
}
public protocol ExpressibleByNilLiteral {
    public init(nilLiteral: Void) {}
}
public protocol ExpressibleByStringInterpolation {
    public init(stringInterpolation: DefaultStringInterpolation)  where DefaultStringInterpolation == StringInterpolation {}
    public init(stringInterpolation: StringInterpolation) {}
}
public protocol ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {}
}
public protocol ExpressibleByUnicodeScalarLiteral {
    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {}
}
public protocol FixedWidthInteger {
    public static var bitWidth: Int { get }
    public static var max: Self { get }
    public static var min: Self { get }
    public static func random(in range: ClosedRange<Self>) -> Self {}
    public static func random(in range: Range<Self>) -> Self {}
    public static func random<T>(in range: ClosedRange<Self>, using generator: inout T) -> Self  where T : RandomNumberGenerator {}
    public static func random<T>(in range: Range<Self>, using generator: inout T) -> Self  where T : RandomNumberGenerator {}
    public init?<S>(_ text: S, radix: Int = x)  where S : StringProtocol {}
    public init(bigEndian value: Self) {}
    public init(littleEndian value: Self) {}
    public var bigEndian: Self { get }
    public var byteSwapped: Self { get }
    public var leadingZeroBitCount: Int { get }
    public var littleEndian: Self { get }
    public var nonzeroBitCount: Int { get }
    public func &*(lhs: Self, rhs: Self) -> Self {}
    public func &*=(lhs: inout Self, rhs: Self) {}
    public func &+(lhs: Self, rhs: Self) -> Self {}
    public func &+=(lhs: inout Self, rhs: Self) {}
    public func &-(lhs: Self, rhs: Self) -> Self {}
    public func &-=(lhs: inout Self, rhs: Self) {}
    public func &<<(lhs: Self, rhs: Self) -> Self {}
    public func &<<=(lhs: inout Self, rhs: Self) {}
    public func &>>(lhs: Self, rhs: Self) -> Self {}
    public func &>>=(lhs: inout Self, rhs: Self) {}
    public func addingReportingOverflow(_ rhs: Self) -> (partialValue : Self, overflow : Bool) {}
    public func dividedReportingOverflow(by rhs: Self) -> (partialValue : Self, overflow : Bool) {}
    public func dividingFullWidth(_ dividend: (high : Self, low : Magnitude)) -> (quotient : Self, remainder : Self) {}
    public func multipliedFullWidth(by other: Self) -> (high : Self, low : Magnitude) {}
    public func multipliedReportingOverflow(by rhs: Self) -> (partialValue : Self, overflow : Bool) {}
    public func remainderReportingOverflow(dividingBy rhs: Self) -> (partialValue : Self, overflow : Bool) {}
    public func subtractingReportingOverflow(_ rhs: Self) -> (partialValue : Self, overflow : Bool) {}
}
public protocol FloatingPoint {
    public static var greatestFiniteMagnitude: Self { get }
    public static var infinity: Self { get }
    public static var leastNonzeroMagnitude: Self { get }
    public static var leastNormalMagnitude: Self { get }
    public static var nan: Self { get }
    public static var pi: Self { get }
    public static var radix: Int { get }
    public static var signalingNaN: Self { get }
    public static var ulpOfOne: Self { get }
    public static func maximum(_ x: Self, _ y: Self) -> Self {}
    public static func maximumMagnitude(_ x: Self, _ y: Self) -> Self {}
    public static func minimum(_ x: Self, _ y: Self) -> Self {}
    public static func minimumMagnitude(_ x: Self, _ y: Self) -> Self {}
    public init(_ value: Int) {}
    public init(sign: FloatingPointSign, exponent: Exponent, significand: Self) {}
    public init(signOf: Self, magnitudeOf: Self) {}
    public var exponent: Exponent { get }
    public var floatingPointClass: FloatingPointClassification { get }
    public var isCanonical: Bool { get }
    public var isFinite: Bool { get }
    public var isInfinite: Bool { get }
    public var isNaN: Bool { get }
    public var isNormal: Bool { get }
    public var isSignalingNaN: Bool { get }
    public var isSubnormal: Bool { get }
    public var isZero: Bool { get }
    public var nextDown: Self { get }
    public var nextUp: Self { get }
    public var sign: FloatingPointSign { get }
    public var significand: Self { get }
    public var ulp: Self { get }
    public func /(lhs: Self, rhs: Self) -> Self {}
    public func /=(lhs: inout Self, rhs: Self) {}
    public func <=(lhs: Self, rhs: Self) -> Bool {}
    public func >(lhs: Self, rhs: Self) -> Bool {}
    public func >=(lhs: Self, rhs: Self) -> Bool {}
    public mutating func addProduct(_ lhs: Self, _ rhs: Self) {}
    public func addingProduct(_ lhs: Self, _ rhs: Self) -> Self {}
    public mutating func formRemainder(dividingBy other: Self) {}
    public mutating func formSquareRoot() {}
    public mutating func formTruncatingRemainder(dividingBy other: Self) {}
    public func isEqual(to other: Self) -> Bool {}
    public func isLess(than other: Self) -> Bool {}
    public func isLessThanOrEqualTo(_ other: Self) -> Bool {}
    public func isTotallyOrdered(belowOrEqualTo other: Self) -> Bool {}
    public func remainder(dividingBy other: Self) -> Self {}
    public mutating func round() {}
    public mutating func round(_ rule: FloatingPointRoundingRule) {}
    public func rounded() -> Self {}
    public func rounded(_ rule: FloatingPointRoundingRule) -> Self {}
    public func squareRoot() -> Self {}
    public func truncatingRemainder(dividingBy other: Self) -> Self {}
}
public protocol Hashable {
    public var hashValue: Int { get }
    public func hash(into hasher: inout Hasher) {}
}
public protocol IteratorProtocol {
    public mutating func next() -> Element? {}
}
public protocol LazyCollectionProtocol {
}
public protocol LazySequenceProtocol {
    public var elements: Elements { get }
    public var elements: Self { get }  where Elements == Self
}
public protocol LosslessStringConvertible {
    public init?(_ description: String) {}
}
public protocol MirrorPath {
}
public protocol MutableCollection {
    public mutating func partition(by belongsInSecondPartition: (Element) throws -> Bool) rethrows -> Index {}
    public mutating func reverse()  where Self : BidirectionalCollection {}
    public mutating func shuffle()  where Self : RandomAccessCollection {}
    public mutating func shuffle<T>(using generator: inout T)  where Self : RandomAccessCollection, T : RandomNumberGenerator {}
    public mutating func sort()  where Element : Comparable, Self : RandomAccessCollection {}
    public mutating func sort(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows  where Self : RandomAccessCollection {}
    public mutating func swapAt(_ i: Index, _ j: Index) {}
    public mutating func swapAt(_ i: Index, _ j: Index) {}
    public mutating func withContiguousMutableStorageIfAvailable<R>(_ body: (inout UnsafeMutableBufferPointer<Element>) throws -> R) rethrows -> R? {}
}
public protocol Numeric {
    public init?<T>(exactly source: T)  where T : BinaryInteger {}
    public var magnitude: Magnitude { get }
    public func *(lhs: Self, rhs: Self) -> Self {}
    public func *=(lhs: inout Self, rhs: Self) {}
}
public protocol OptionSet {
    public func intersection(_ other: Self) -> Self {}
    public func symmetricDifference(_ other: Self) -> Self {}
    public func union(_ other: Self) -> Self {}
}
public protocol RandomAccessCollection {
}
public protocol RandomNumberGenerator {
    public mutating func next() -> UInt64 {}
    public mutating func next<T>() -> T  where T : FixedWidthInteger & UnsignedInteger {}
    public mutating func next<T>(upperBound: T) -> T  where T : FixedWidthInteger & UnsignedInteger {}
}
public protocol RangeExpression {
    public func contains(_ element: Bound) -> Bool {}
    public func relative<C>(to collection: C) -> Range<Bound>  where C : Collection, Bound == C.Index {}
    public func ~=(pattern: Self, value: Bound) -> Bool {}
}
public protocol RangeReplaceableCollection {
    public init() {}
    public init<S>(_ elements: S)  where S : Sequence, Element == S.Element {}
    public init<S>(_ elements: S)  where S : Sequence, Element == S.Element {}
    public init(repeating repeatedValue: Element, count: Int) {}
    public init(repeating repeatedValue: Element, count: Int) {}
    public func +<Other>(lhs: Other, rhs: Self) -> Self  where Other : Sequence, Element == Other.Element {}
    public func +<Other>(lhs: Self, rhs: Other) -> Self  where Other : RangeReplaceableCollection, Element == Other.Element {}
    public func +<Other>(lhs: Self, rhs: Other) -> Self  where Other : Sequence, Element == Other.Element {}
    public func +=<Other>(lhs: inout Self, rhs: Other)  where Other : Sequence, Element == Other.Element {}
    public mutating func append(_ newElement: __owned Element) {}
    public mutating func append<S>(contentsOf newElements: __owned S)  where S : Sequence, Element == S.Element {}
    public mutating func insert(_ newElement: __owned Element, at i: Index) {}
    public mutating func insert<C>(contentsOf newElements: __owned C, at i: Index)  where C : Collection, C.Element == Element {}
    public mutating func popLast() -> Element?  where Self : BidirectionalCollection {}
    @discardableResult public mutating func remove(at i: Index) -> Element {}
    @discardableResult public mutating func remove(at position: Index) -> Element {}
    public mutating func removeAll(keepingCapacity keepCapacity: Bool = x) {}
    public mutating func removeAll(where shouldBeRemoved: (Element) throws -> Bool) rethrows {}
    public mutating func removeAll(where shouldBeRemoved: (Element) throws -> Bool) rethrows {}
    @discardableResult public mutating func removeLast() -> Element  where Self : BidirectionalCollection {}
    public mutating func removeLast(_ k: Int)  where Self : BidirectionalCollection {}
    public mutating func removeSubrange(_ bounds: Range<Index>) {}
    public mutating func removeSubrange(_ bounds: Range<Index>) {}
    public mutating func replaceSubrange<C, R>(_ subrange: R, with newElements: __owned C)  where C : Collection, R : RangeExpression, C.Element == Element, Index == R.Bound {}
    public mutating func replaceSubrange<C>(_ subrange: Range<Index>, with newElements: __owned C)  where C : Collection, C.Element == Element {}
    public mutating func reserveCapacity(_ n: Int) {}
    public mutating func reserveCapacity(_ n: Int) {}
}
public protocol RawRepresentable {
    public init?(rawValue: RawValue) {}
    public var hashValue: Int { get }  where RawValue : Hashable, Self : Hashable
    public var rawValue: RawValue { get }
    public func hash(into hasher: inout Hasher)  where RawValue : Hashable, Self : Hashable {}
}
public protocol SIMD {
}
public protocol SIMDScalar {
}
public protocol SIMDStorage {
    public init() {}
    public var scalarCount: Int { get }
    public subscript(index: Int) -> Scalar { get set } {}
}
public protocol Sequence {
    public var lazy: LazySequence<Self> { get }
    public var underestimatedCount: Int { get }
    public func allSatisfy(_ predicate: (Element) throws -> Bool) rethrows -> Bool {}
    public func compactMap<ElementOfResult>(_ transform: (Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult] {}
    public func contains(_ element: Element) -> Bool  where Element : Equatable {}
    public func contains(where predicate: (Element) throws -> Bool) rethrows -> Bool {}
    public func count(where predicate: (Element) throws -> Bool) rethrows -> Int {}
    public func elementsEqual<OtherSequence>(_ other: OtherSequence) -> Bool  where Element : Equatable, OtherSequence : Sequence, Element == OtherSequence.Element {}
    public func elementsEqual<OtherSequence>(_ other: OtherSequence, by areEquivalent: (Element, OtherSequence.Element) throws -> Bool) rethrows -> Bool  where OtherSequence : Sequence {}
    public func enumerated() -> EnumeratedSequence<Self> {}
    public func first(where predicate: (Element) throws -> Bool) rethrows -> Element? {}
    public func flatMap<SegmentOfResult>(_ transform: (Element) throws -> SegmentOfResult) rethrows -> [SegmentOfResult.Element]  where SegmentOfResult : Sequence {}
    public func forEach(_ body: (Element) throws -> Void) rethrows {}
    public func joined(separator: String = x) -> String  where Element : StringProtocol {}
    public func lexicographicallyPrecedes<OtherSequence>(_ other: OtherSequence) -> Bool  where Element : Comparable, OtherSequence : Sequence, Element == OtherSequence.Element {}
    public func lexicographicallyPrecedes<OtherSequence>(_ other: OtherSequence, by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Bool  where OtherSequence : Sequence, Element == OtherSequence.Element {}
    public func map<T>(_ transform: (Element) throws -> T) rethrows -> [T] {}
    public func max() -> Element?  where Element : Comparable {}
    public func max(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Element? {}
    public func min() -> Element?  where Element : Comparable {}
    public func min(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Element? {}
    public func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (_ partialResult: Result, Element) throws -> Result) rethrows -> Result {}
    public func reduce<Result>(into initialResult: __owned Result, _ updateAccumulatingResult: (_ partialResult: inout Result, Element) throws -> Void) rethrows -> Result {}
    public func shuffled() -> [Element] {}
    public func shuffled<T>(using generator: inout T) -> [Element]  where T : RandomNumberGenerator {}
    public func sorted() -> [Element]  where Element : Comparable {}
    public func sorted(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> [Element] {}
    public func starts<PossiblePrefix>(with possiblePrefix: PossiblePrefix) -> Bool  where Element : Equatable, PossiblePrefix : Sequence, Element == PossiblePrefix.Element {}
    public func starts<PossiblePrefix>(with possiblePrefix: PossiblePrefix, by areEquivalent: (Element, PossiblePrefix.Element) throws -> Bool) rethrows -> Bool  where PossiblePrefix : Sequence {}
    public func withContiguousStorageIfAvailable<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R? {}
}
public protocol SetAlgebra {
    public init() {}
    public init<S>(_ sequence: __owned S)  where S : Sequence, Element == S.Element {}
    public var isEmpty: Bool { get }
    public func contains(_ member: Element) -> Bool {}
    public mutating func formIntersection(_ other: Self) {}
    public mutating func formSymmetricDifference(_ other: __owned Self) {}
    public mutating func formUnion(_ other: __owned Self) {}
    @discardableResult public mutating func insert(_ newMember: __owned Element) -> (inserted : Bool, memberAfterInsert : Element) {}
    public func isDisjoint(with other: Self) -> Bool {}
    public func isStrictSubset(of other: Self) -> Bool {}
    public func isStrictSuperset(of other: Self) -> Bool {}
    public func isSubset(of other: Self) -> Bool {}
    public func isSuperset(of other: Self) -> Bool {}
    public func isSuperset(of other: Self) -> Bool {}
    @discardableResult public mutating func remove(_ member: Element) -> Element? {}
    public mutating func subtract(_ other: Self) {}
    public func subtracting(_ other: Self) -> Self {}
    @discardableResult public mutating func update(with newMember: __owned Element) -> Element? {}
}
public protocol SignedInteger {
    public static var max: Self { get }  where Self : FixedWidthInteger
    public static var min: Self { get }  where Self : FixedWidthInteger
    public func &+(lhs: Self, rhs: Self) -> Self  where Self : FixedWidthInteger {}
    public func &-(lhs: Self, rhs: Self) -> Self  where Self : FixedWidthInteger {}
}
public protocol SignedNumeric {
    public prefix func -(operand: Self) -> Self {}
    public prefix func -(operand: Self) -> Self {}
    public mutating func negate() {}
}
public protocol Strideable {
    public func +(lhs: Self, rhs: Stride) -> Self  where Self : _Pointer {}
    public func +=(lhs: inout Self, rhs: Stride)  where Self : _Pointer {}
    public func -(lhs: Self, rhs: Self) -> Stride  where Self : _Pointer {}
    public func -=(lhs: inout Self, rhs: Stride)  where Self : _Pointer {}
    public func advanced(by n: Stride) -> Self {}
    public func distance(to other: Self) -> Stride {}
}
public protocol StringInterpolationProtocol {
    public init(literalCapacity: Int, interpolationCount: Int) {}
    public mutating func appendLiteral(_ literal: StringLiteralType) {}
}
public protocol StringProtocol {
    public init(cString nullTerminatedUTF8: UnsafePointer<CChar>) {}
    public init<C, Encoding>(decoding codeUnits: C, as sourceEncoding: Encoding.Type)  where C : Collection, Encoding : Unicode.Encoding, C.Iterator.Element == Encoding.CodeUnit {}
    public init<Encoding>(decodingCString nullTerminatedCodeUnits: UnsafePointer<Encoding.CodeUnit>, as sourceEncoding: Encoding.Type)  where Encoding : Unicode.Encoding {}
    public var unicodeScalars: UnicodeScalarView { get }
    public var utf16: UTF16View { get }
    public var utf8: UTF8View { get }
    public func hasPrefix<Prefix>(_ prefix: Prefix) -> Bool  where Prefix : StringProtocol {}
    public func hasSuffix<Suffix>(_ suffix: Suffix) -> Bool  where Suffix : StringProtocol {}
    public func lowercased() -> String {}
    public func uppercased() -> String {}
    public func withCString<Result>(_ body: (UnsafePointer<CChar>) throws -> Result) rethrows -> Result {}
    public func withCString<Result, Encoding>(encodedAs targetEncoding: Encoding.Type, _ body: (UnsafePointer<Encoding.CodeUnit>) throws -> Result) rethrows -> Result  where Encoding : Unicode.Encoding {}
}
public protocol TextOutputStream {
    public mutating func write(_ string: String) {}
}
public protocol TextOutputStreamable {
    public func write<Target>(to target: inout Target)  where Target : TextOutputStream {}
}
public protocol UnicodeCodec {
    public static func encode(_ input: Unicode.Scalar, into processCodeUnit: (CodeUnit) -> Void) {}
    public init() {}
    public mutating func decode<I>(_ input: inout I) -> UnicodeDecodingResult  where I : IteratorProtocol, CodeUnit == I.Element {}
}
public protocol UnsignedInteger {
    public static var max: Self { get }  where Self : FixedWidthInteger
    public static var min: Self { get }  where Self : FixedWidthInteger
}
extension Array {
    public var capacity: Int { get }
    public var count: Int { get }
    public func withContiguousStorageIfAvailable<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R? {}
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R {}
    public func withUnsafeBytes<R>(_ body: (UnsafeRawBufferPointer) throws -> R) rethrows -> R {}
    public mutating func withUnsafeMutableBufferPointer<R>(_ body: (inout UnsafeMutableBufferPointer<Element>) throws -> R) rethrows -> R {}
    public mutating func withUnsafeMutableBytes<R>(_ body: (UnsafeMutableRawBufferPointer) throws -> R) rethrows -> R {}
}
extension ArraySlice {
    public var capacity: Int { get }
    public var count: Int { get }
    public func withContiguousStorageIfAvailable<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R? {}
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R {}
    public func withUnsafeBytes<R>(_ body: (UnsafeRawBufferPointer) throws -> R) rethrows -> R {}
    public mutating func withUnsafeMutableBufferPointer<R>(_ body: (inout UnsafeMutableBufferPointer<Element>) throws -> R) rethrows -> R {}
    public mutating func withUnsafeMutableBytes<R>(_ body: (UnsafeMutableRawBufferPointer) throws -> R) rethrows -> R {}
}
extension AutoreleasingUnsafeMutablePointer {
}
extension ClosedRange {
    public init(_ other: Range<Bound>)  where Bound : Strideable, Bound.Stride : SignedInteger {}
    public init(from decoder: Decoder) throws  where Bound : Decodable {}
    public func clamped(to limits: ClosedRange) -> ClosedRange {}
    public func encode(to encoder: Encoder) throws  where Bound : Encodable {}
    public func overlaps(_ other: ClosedRange<Bound>) -> Bool {}
}
extension ClosedRange.Index {
    public func ==(lhs: ClosedRange<Bound>.Index, rhs: ClosedRange<Bound>.Index) -> Bool {}
}
extension CollectionOfOne {
    public var count: Int { get }
}
extension CollectionOfOne.Iterator {
}
extension ContiguousArray {
    public var capacity: Int { get }
    public var count: Int { get }
    public func withContiguousStorageIfAvailable<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R? {}
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R {}
    public func withUnsafeBytes<R>(_ body: (UnsafeRawBufferPointer) throws -> R) rethrows -> R {}
    public mutating func withUnsafeMutableBufferPointer<R>(_ body: (inout UnsafeMutableBufferPointer<Element>) throws -> R) rethrows -> R {}
    public mutating func withUnsafeMutableBytes<R>(_ body: (UnsafeMutableRawBufferPointer) throws -> R) rethrows -> R {}
}
extension DefaultIndices {
    public subscript(i: Index) -> Elements.Index { get } {}
}
extension Dictionary {
    public var capacity: Int { get }
    @available(swift, introduced: 4.0) public var keys: Keys { get }
    public subscript(position: Index) -> Element { get } {}
    public func compactMapValues<T>(_ transform: (Value) throws -> T?) rethrows -> [Key: T] {}
    public func index(forKey key: Key) -> Index? {}
    public func mapValues<T>(_ transform: (Value) throws -> T) rethrows -> [Key: T] {}
    public mutating func merge(_ other: __owned [Key: Value], uniquingKeysWith combine: (Value, Value) throws -> Value) rethrows {}
    public mutating func merge<S>(_ other: __owned S, uniquingKeysWith combine: (Value, Value) throws -> Value) rethrows  where S : Sequence, (Key, Value) == S.Element {}
    @discardableResult public mutating func remove(at index: Index) -> Element {}
    public mutating func removeAll(keepingCapacity keepCapacity: Bool = x) {}
    @discardableResult public mutating func removeValue(forKey key: Key) -> Value? {}
    public mutating func reserveCapacity(_ minimumCapacity: Int) {}
    @discardableResult public mutating func updateValue(_ value: __owned Value, forKey key: Key) -> Value? {}
}
extension Dictionary.Index {
}
extension Dictionary.Iterator {
}
extension Dictionary.Keys {
}
extension Dictionary.Values {
}
extension Dictionary._Variant {
}
extension Double {
}
extension DropFirstSequence {
}
extension DropWhileSequence {
    public func makeIterator() -> Iterator {}
}
extension DropWhileSequence.Iterator {
}
extension EmptyCollection {
    public var count: Int { get }
    public func makeIterator() -> Iterator {}
}
extension EmptyCollection.Iterator {
}
extension EnumeratedSequence {
}
extension EnumeratedSequence.Iterator {
}
extension FlattenCollection {
}
extension FlattenSequence {
}
extension FlattenSequence.Index {
}
extension FlattenSequence.Iterator {
}
extension Float {
}
extension Float80 {
}
extension IndexingIterator {
}
extension Int {
    public init(bitPattern objectID: ObjectIdentifier) {}
    public init(bitPattern pointer: OpaquePointer?) {}
}
extension Int16 {
}
extension Int32 {
}
extension Int64 {
}
extension Int8 {
}
extension IteratorSequence {
}
extension JoinedSequence {
}
extension JoinedSequence.Iterator {
}
extension KeyValuePairs {
}
extension LazyCollection {
}
extension LazyDropWhileCollection {
}
extension LazyDropWhileSequence {
}
extension LazyDropWhileSequence.Iterator {
}
extension LazyFilterCollection {
}
extension LazyFilterSequence {
}
extension LazyFilterSequence.Iterator {
}
extension LazyMapCollection {
}
extension LazyMapSequence {
    public var underestimatedCount: Int { get }
}
extension LazyMapSequence.Iterator {
}
extension LazyPrefixWhileCollection {
}
extension LazyPrefixWhileSequence {
}
extension LazyPrefixWhileSequence.Index {
    public func ==(lhs: LazyPrefixWhileCollection<Base>.Index, rhs: LazyPrefixWhileCollection<Base>.Index) -> Bool  where Base : Collection {}
}
extension LazyPrefixWhileSequence.Iterator {
}
extension LazySequence {
}
extension ManagedBuffer {
    public class func create(minimumCapacity: Int, makingHeaderWith factory: (ManagedBuffer<Header, Element>) throws -> Header) rethrows -> ManagedBuffer<Header, Element> {}
    public var capacity: Int { get }
    public func withUnsafeMutablePointerToElements<R>(_ body: (UnsafeMutablePointer<Element>) throws -> R) rethrows -> R {}
    public func withUnsafeMutablePointerToHeader<R>(_ body: (UnsafeMutablePointer<Header>) throws -> R) rethrows -> R {}
    public func withUnsafeMutablePointers<R>(_ body: (UnsafeMutablePointer<Header>, UnsafeMutablePointer<Element>) throws -> R) rethrows -> R {}
}
extension ManagedBufferPointer {
    public var buffer: AnyObject { get }
    public var capacity: Int { get }
    public var header: Header { get }
    public mutating func isUniqueReference() -> Bool {}
    public func withUnsafeMutablePointerToElements<R>(_ body: (UnsafeMutablePointer<Element>) throws -> R) rethrows -> R {}
    public func withUnsafeMutablePointerToHeader<R>(_ body: (UnsafeMutablePointer<Header>) throws -> R) rethrows -> R {}
    public func withUnsafeMutablePointers<R>(_ body: (UnsafeMutablePointer<Header>, UnsafeMutablePointer<Element>) throws -> R) rethrows -> R {}
}
extension MemoryLayout {
    public static func alignment(ofValue value: T) -> Int {}
    public static func offset(of key: PartialKeyPath<T>) -> Int? {}
    public static func size(ofValue value: T) -> Int {}
    public static func stride(ofValue value: T) -> Int {}
}
extension Optional {
    public func ~=(lhs: _OptionalNilComparisonType, rhs: Wrapped?) -> Bool {}
}
extension PartialRangeFrom {
    public init(from decoder: Decoder) throws  where Bound : Decodable {}
    public func encode(to encoder: Encoder) throws  where Bound : Encodable {}
}
extension PartialRangeThrough {
    public init(from decoder: Decoder) throws  where Bound : Decodable {}
    public func encode(to encoder: Encoder) throws  where Bound : Encodable {}
}
extension PartialRangeUpTo {
    public init(from decoder: Decoder) throws  where Bound : Decodable {}
    public func encode(to encoder: Encoder) throws  where Bound : Encodable {}
}
extension PrefixSequence {
}
extension PrefixSequence.Iterator {
}
extension Range {
    public init(_ other: ClosedRange<Bound>)  where Bound : Strideable, Bound.Stride : SignedInteger {}
    public init(from decoder: Decoder) throws  where Bound : Decodable {}
    public func clamped(to limits: Range) -> Range {}
    public func encode(to encoder: Encoder) throws  where Bound : Encodable {}
    public func overlaps(_ other: Range<Bound>) -> Bool {}
}
extension Repeated {
}
extension Result {
    public init(catching body: () throws -> Success)  where Failure == Swift.Error {}
}
extension ReversedCollection {
}
extension ReversedCollection.Index {
    public func ==(lhs: ReversedCollection<Base>.Index, rhs: ReversedCollection<Base>.Index) -> Bool {}
}
extension ReversedCollection.Iterator {
}
extension Set {
    public var capacity: Int { get }
    public subscript(position: Index) -> Element { get } {}
    @discardableResult public mutating func remove(at position: Index) -> Element {}
    public mutating func removeAll(keepingCapacity keepCapacity: Bool = x) {}
    public mutating func reserveCapacity(_ minimumCapacity: Int) {}
}
extension Set.Index {
}
extension Set.Iterator {
}
extension Set._Variant {
}
extension Slice {
    public subscript(index: Index) -> Base.Element { get set }  where Base : MutableCollection {}
}
extension StrideThrough {
#if false
    public var count: Int { get }  where Element.Stride : BinaryInteger
#endif
}
extension StrideThroughIterator {
}
extension StrideTo {
#if false
    public var count: Int { get }  where Element.Stride : BinaryInteger
#endif
}
extension StrideToIterator {
}
extension String.UTF16View {
}
extension String.UTF16View.Index {
    public init?(_ idx: String.Index, within target: String.UTF16View) {}
    public func samePosition(in unicodeScalars: String.UnicodeScalarView) -> String.UnicodeScalarIndex? {}
}
extension String.UTF8View {
}
extension String.UTF8View.Index {
    public init?(_ idx: String.Index, within target: String.UTF8View) {}
}
extension String.UnicodeScalarIndex {
    public init?(_ sourcePosition: String.Index, within unicodeScalars: String.UnicodeScalarView) {}
    public func samePosition(in characters: String) -> String.Index? {}
}
extension String.UnicodeScalarView {
    @available(swift, introduced: 4) public subscript(r: Range<Index>) -> String.UnicodeScalarView.SubSequence { get } {}
}
extension UInt {
    public init(bitPattern objectID: ObjectIdentifier) {}
    public init(bitPattern pointer: OpaquePointer?) {}
}
extension UInt16 {
}
extension UInt32 {
    public init(_ v: Unicode.Scalar) {}
}
extension UInt64 {
    public init(_ v: Unicode.Scalar) {}
}
extension UInt8 {
    public init(ascii v: Unicode.Scalar) {}
}
extension UTF16.CodeUnit {
}
extension UTF16.ReverseParser {
}
extension UTF32.Parser {
    public mutating func parseScalar<I>(from input: inout I) -> Unicode.ParseResult<Encoding.EncodedScalar>  where I : IteratorProtocol, Encoding.CodeUnit == I.Element {}
}
extension UTF8.CodeUnit {
}
extension UTF8.ReverseParser {
}
extension UTF8ValidationResult {
}
extension Unicode.Scalar {
}
extension Unicode.UTF16.ForwardParser {
}
extension UnsafeBufferPointer {
}
extension UnsafeMutableBufferPointer {
}
extension UnsafeMutablePointer {
}
extension UnsafeMutableRawBufferPointer {
}
extension UnsafePointer {
}
extension UnsafeRawBufferPointer {
}
extension Zip2Sequence {
}
extension Zip2Sequence.Iterator {
}