open class ManagedBuffer<Header, Element> {
    public var header: Header { get set }
}
public protocol AdditiveArithmetic {
    static var zero: Self { get }
    prefix func +(x: Self) -> Self
    func +(lhs: Self, rhs: Self) -> Self
    func +=(lhs: inout Self, rhs: Self)
    func -(lhs: Self, rhs: Self) -> Self
    func -=(lhs: inout Self, rhs: Self)
}
public protocol BidirectionalCollection {
    var last: Element? { get }
    subscript(position: Index) -> Element { get }
    func formIndex(before i: inout Index)
    func index(before i: Index) -> Index
    func joined(separator: String = x) -> String where Element == String
    func last(where predicate: (Element) throws -> Bool) rethrows -> Element?
    func lastIndex(of element: Element) -> Index? where Element : Equatable
    func lastIndex(where predicate: (Element) throws -> Bool) rethrows -> Index?
    mutating func popLast() -> Element? where Self == SubSequence
    @discardableResult mutating func removeLast() -> Element where Self == SubSequence
    mutating func removeLast(_ k: Int) where Self == SubSequence
}
public protocol BinaryFloatingPoint {
    static var exponentBitCount: Int { get }
    static var significandBitCount: Int { get }
    static func random(in range: ClosedRange<Self>) -> Self where RawSignificand : FixedWidthInteger
    static func random(in range: Range<Self>) -> Self where RawSignificand : FixedWidthInteger
    static func random<T>(in range: ClosedRange<Self>, using generator: inout T) -> Self where RawSignificand : FixedWidthInteger, T : RandomNumberGenerator
    static func random<T>(in range: Range<Self>, using generator: inout T) -> Self where RawSignificand : FixedWidthInteger, T : RandomNumberGenerator
    init(sign: FloatingPointSign, exponentBitPattern: RawExponent, significandBitPattern: RawSignificand)
    var binade: Self { get }
    var exponentBitPattern: RawExponent { get }
    var significandBitPattern: RawSignificand { get }
    var significandWidth: Int { get }
}
public protocol BinaryInteger {
    static var isSigned: Bool { get }
    init()
    init<T>(_ source: T) where T : BinaryFloatingPoint
    init<T>(_ source: T) where T : BinaryInteger
    init<T>(clamping source: T) where T : BinaryInteger
    init<T>(truncatingIfNeeded source: T) where T : BinaryInteger
    var bitWidth: Int { get }
    var trailingZeroBitCount: Int { get }
    var words: Words { get }
    func %(lhs: Self, rhs: Self) -> Self
    func %=(lhs: inout Self, rhs: Self)
    func &(lhs: Self, rhs: Self) -> Self
    func &=(lhs: inout Self, rhs: Self)
    func /(lhs: Self, rhs: Self) -> Self
    func /=(lhs: inout Self, rhs: Self)
    func <<<RHS>(lhs: Self, rhs: RHS) -> Self where RHS : BinaryInteger
    func <<=<RHS>(lhs: inout Self, rhs: RHS) where RHS : BinaryInteger
    func <=<Other>(lhs: Self, rhs: Other) -> Bool where Other : BinaryInteger
    func ><Other>(lhs: Self, rhs: Other) -> Bool where Other : BinaryInteger
    func >=<Other>(lhs: Self, rhs: Other) -> Bool where Other : BinaryInteger
    func >><RHS>(lhs: Self, rhs: RHS) -> Self where RHS : BinaryInteger
    func >>=<RHS>(lhs: inout Self, rhs: RHS) where RHS : BinaryInteger
    func ^(lhs: Self, rhs: Self) -> Self
    func ^=(lhs: inout Self, rhs: Self)
    func isMultiple(of other: Self) -> Bool
    func quotientAndRemainder(dividingBy rhs: Self) -> (quotient : Self, remainder : Self)
    func quotientAndRemainder(dividingBy rhs: Self) -> (quotient : Self, remainder : Self)
    func signum() -> Self
    func |(lhs: Self, rhs: Self) -> Self
    func |=(lhs: inout Self, rhs: Self)
    prefix func ~(x: Self) -> Self
}
public protocol CVarArg {
}
public protocol CaseIterable {
    static var allCases: AllCases { get }
}
public protocol Collection {
    var count: Int { get }
    var endIndex: Index { get }
    var first: Element? { get }
    var indices: DefaultIndices<Self> { get } where DefaultIndices<Self> == Indices
    var indices: Indices { get }
    var isEmpty: Bool { get }
    var isEmpty: Bool { get }
    var startIndex: Index { get }
    subscript(bounds: Range<Index>) -> Slice<Self> { get } where Slice<Self> == SubSequence
    subscript(bounds: Range<Index>) -> SubSequence { get }
    subscript(x: UnboundedRange) -> SubSequence { get }
    subscript<R>(r: R) -> SubSequence { get } where R : RangeExpression, Index == R.Bound
    func distance(from start: Index, to end: Index) -> Int
    func firstIndex(of element: Element) -> Index? where Element : Equatable
    func firstIndex(where predicate: (Element) throws -> Bool) rethrows -> Index?
    func formIndex(_ i: inout Index, offsetBy distance: Int)
    func formIndex(_ i: inout Index, offsetBy distance: Int, limitedBy limit: Index) -> Bool
    func formIndex(after i: inout Index)
    func index(_ i: Index, offsetBy distance: Int) -> Index
    func index(_ i: Index, offsetBy distance: Int, limitedBy limit: Index) -> Index?
    func index(after i: Index) -> Index
    func makeIterator() -> Iterator
    mutating func popFirst() -> Element? where Self == SubSequence
    func randomElement() -> Element?
    func randomElement<T>(using generator: inout T) -> Element? where T : RandomNumberGenerator
    @discardableResult mutating func removeFirst() -> Element where Self == SubSequence
    mutating func removeFirst(_ k: Int) where Self == SubSequence
}
public protocol Comparable {
    postfix func ...(minimum: Self) -> PartialRangeFrom<Self>
    prefix func ...(maximum: Self) -> PartialRangeThrough<Self>
    func ...(minimum: Self, maximum: Self) -> ClosedRange<Self>
    prefix func ..<(maximum: Self) -> PartialRangeUpTo<Self>
    func ..<(minimum: Self, maximum: Self) -> Range<Self>
    func <(lhs: Self, rhs: Self) -> Bool
    func <=(lhs: Self, rhs: Self) -> Bool
    func <=(lhs: Self, rhs: Self) -> Bool
    func >(lhs: Self, rhs: Self) -> Bool
    func >(lhs: Self, rhs: Self) -> Bool
    func >=(lhs: Self, rhs: Self) -> Bool
    func >=(lhs: Self, rhs: Self) -> Bool
}
public protocol CustomDebugStringConvertible {
    var debugDescription: String { get }
}
public protocol CustomLeafReflectable {
}
public protocol CustomPlaygroundDisplayConvertible {
    var playgroundDescription: Any { get }
}
public protocol CustomReflectable {
    var customMirror: Mirror { get }
}
public protocol CustomStringConvertible {
    var description: String { get }
}
public protocol Equatable {
    func !=(lhs: Self, rhs: Self) -> Bool
    func ==(lhs: Self, rhs: Self) -> Bool
}
public protocol Error {
}
public protocol ExpressibleByArrayLiteral {
    init(arrayLiteral elements: ArrayLiteralElement...)
}
public protocol ExpressibleByBooleanLiteral {
    init(booleanLiteral value: BooleanLiteralType)
}
public protocol ExpressibleByDictionaryLiteral {
    init(dictionaryLiteral elements: (Key, Value)...)
}
public protocol ExpressibleByExtendedGraphemeClusterLiteral {
    init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType)
}
public protocol ExpressibleByFloatLiteral {
    init(floatLiteral value: FloatLiteralType)
}
public protocol ExpressibleByIntegerLiteral {
    init(integerLiteral value: IntegerLiteralType)
}
public protocol ExpressibleByNilLiteral {
    init(nilLiteral: Void)
}
public protocol ExpressibleByStringInterpolation {
    init(stringInterpolation: DefaultStringInterpolation) where DefaultStringInterpolation == StringInterpolation
    init(stringInterpolation: StringInterpolation)
}
public protocol ExpressibleByStringLiteral {
    init(stringLiteral value: StringLiteralType)
}
public protocol ExpressibleByUnicodeScalarLiteral {
    init(unicodeScalarLiteral value: UnicodeScalarLiteralType)
}
public protocol FixedWidthInteger {
    static var bitWidth: Int { get }
    static var max: Self { get }
    static var min: Self { get }
    static func random(in range: ClosedRange<Self>) -> Self
    static func random(in range: Range<Self>) -> Self
    static func random<T>(in range: ClosedRange<Self>, using generator: inout T) -> Self where T : RandomNumberGenerator
    static func random<T>(in range: Range<Self>, using generator: inout T) -> Self where T : RandomNumberGenerator
    init?<S>(_ text: S, radix: Int = x) where S : StringProtocol
    init(bigEndian value: Self)
    init(littleEndian value: Self)
    var bigEndian: Self { get }
    var byteSwapped: Self { get }
    var leadingZeroBitCount: Int { get }
    var littleEndian: Self { get }
    var nonzeroBitCount: Int { get }
    func &*(lhs: Self, rhs: Self) -> Self
    func &*=(lhs: inout Self, rhs: Self)
    func &+(lhs: Self, rhs: Self) -> Self
    func &+=(lhs: inout Self, rhs: Self)
    func &-(lhs: Self, rhs: Self) -> Self
    func &-=(lhs: inout Self, rhs: Self)
    func &<<(lhs: Self, rhs: Self) -> Self
    func &<<=(lhs: inout Self, rhs: Self)
    func &>>(lhs: Self, rhs: Self) -> Self
    func &>>=(lhs: inout Self, rhs: Self)
    func addingReportingOverflow(_ rhs: Self) -> (partialValue : Self, overflow : Bool)
    func dividedReportingOverflow(by rhs: Self) -> (partialValue : Self, overflow : Bool)
    func dividingFullWidth(_ dividend: (high : Self, low : Magnitude)) -> (quotient : Self, remainder : Self)
    func multipliedFullWidth(by other: Self) -> (high : Self, low : Magnitude)
    func multipliedReportingOverflow(by rhs: Self) -> (partialValue : Self, overflow : Bool)
    func remainderReportingOverflow(dividingBy rhs: Self) -> (partialValue : Self, overflow : Bool)
    func subtractingReportingOverflow(_ rhs: Self) -> (partialValue : Self, overflow : Bool)
}
public protocol FloatingPoint {
    static var greatestFiniteMagnitude: Self { get }
    static var infinity: Self { get }
    static var leastNonzeroMagnitude: Self { get }
    static var leastNormalMagnitude: Self { get }
    static var nan: Self { get }
    static var pi: Self { get }
    static var radix: Int { get }
    static var signalingNaN: Self { get }
    static var ulpOfOne: Self { get }
    static func maximum(_ x: Self, _ y: Self) -> Self
    static func maximumMagnitude(_ x: Self, _ y: Self) -> Self
    static func minimum(_ x: Self, _ y: Self) -> Self
    static func minimumMagnitude(_ x: Self, _ y: Self) -> Self
    init(_ value: Int)
    init(sign: FloatingPointSign, exponent: Exponent, significand: Self)
    init(signOf: Self, magnitudeOf: Self)
    var exponent: Exponent { get }
    var floatingPointClass: FloatingPointClassification { get }
    var isCanonical: Bool { get }
    var isFinite: Bool { get }
    var isInfinite: Bool { get }
    var isNaN: Bool { get }
    var isNormal: Bool { get }
    var isSignalingNaN: Bool { get }
    var isSubnormal: Bool { get }
    var isZero: Bool { get }
    var nextDown: Self { get }
    var nextUp: Self { get }
    var sign: FloatingPointSign { get }
    var significand: Self { get }
    var ulp: Self { get }
    func /(lhs: Self, rhs: Self) -> Self
    func /=(lhs: inout Self, rhs: Self)
    func <=(lhs: Self, rhs: Self) -> Bool
    func >(lhs: Self, rhs: Self) -> Bool
    func >=(lhs: Self, rhs: Self) -> Bool
    mutating func addProduct(_ lhs: Self, _ rhs: Self)
    func addingProduct(_ lhs: Self, _ rhs: Self) -> Self
    mutating func formRemainder(dividingBy other: Self)
    mutating func formSquareRoot()
    mutating func formTruncatingRemainder(dividingBy other: Self)
    func isEqual(to other: Self) -> Bool
    func isLess(than other: Self) -> Bool
    func isLessThanOrEqualTo(_ other: Self) -> Bool
    func isTotallyOrdered(belowOrEqualTo other: Self) -> Bool
    func remainder(dividingBy other: Self) -> Self
    mutating func round()
    mutating func round(_ rule: FloatingPointRoundingRule)
    func rounded() -> Self
    func rounded(_ rule: FloatingPointRoundingRule) -> Self
    func squareRoot() -> Self
    func truncatingRemainder(dividingBy other: Self) -> Self
}
public protocol Hashable {
    var hashValue: Int { get }
    func hash(into hasher: inout Hasher)
}
public protocol IteratorProtocol {
    mutating func next() -> Element?
}
public protocol LazyCollectionProtocol {
}
public protocol LazySequenceProtocol {
    var elements: Elements { get }
    var elements: Self { get } where Elements == Self
}
public protocol LosslessStringConvertible {
    init?(_ description: String)
}
public protocol MirrorPath {
}
public protocol MutableCollection {
    mutating func partition(by belongsInSecondPartition: (Element) throws -> Bool) rethrows -> Index
    mutating func reverse() where Self : BidirectionalCollection
    mutating func shuffle() where Self : RandomAccessCollection
    mutating func shuffle<T>(using generator: inout T) where Self : RandomAccessCollection, T : RandomNumberGenerator
    mutating func sort() where Element : Comparable, Self : RandomAccessCollection
    mutating func sort(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows where Self : RandomAccessCollection
    mutating func swapAt(_ i: Index, _ j: Index)
    mutating func swapAt(_ i: Index, _ j: Index)
    mutating func withContiguousMutableStorageIfAvailable<R>(_ body: (inout UnsafeMutableBufferPointer<Element>) throws -> R) rethrows -> R?
}
public protocol Numeric {
    init?<T>(exactly source: T) where T : BinaryInteger
    var magnitude: Magnitude { get }
    func *(lhs: Self, rhs: Self) -> Self
    func *=(lhs: inout Self, rhs: Self)
}
public protocol OptionSet {
    func intersection(_ other: Self) -> Self
    func symmetricDifference(_ other: Self) -> Self
    func union(_ other: Self) -> Self
}
public protocol RandomAccessCollection {
}
public protocol RandomNumberGenerator {
    mutating func next() -> UInt64
    mutating func next<T>() -> T where T : FixedWidthInteger & UnsignedInteger
    mutating func next<T>(upperBound: T) -> T where T : FixedWidthInteger & UnsignedInteger
}
public protocol RangeExpression {
    func contains(_ element: Bound) -> Bool
    func relative<C>(to collection: C) -> Range<Bound> where C : Collection, Bound == C.Index
    func ~=(pattern: Self, value: Bound) -> Bool
}
public protocol RangeReplaceableCollection {
    init()
    init<S>(_ elements: S) where S : Sequence, Element == S.Element
    init<S>(_ elements: S) where S : Sequence, Element == S.Element
    init(repeating repeatedValue: Element, count: Int)
    init(repeating repeatedValue: Element, count: Int)
    func +<Other>(lhs: Other, rhs: Self) -> Self where Other : Sequence, Element == Other.Element
    func +<Other>(lhs: Self, rhs: Other) -> Self where Other : RangeReplaceableCollection, Element == Other.Element
    func +<Other>(lhs: Self, rhs: Other) -> Self where Other : Sequence, Element == Other.Element
    func +=<Other>(lhs: inout Self, rhs: Other) where Other : Sequence, Element == Other.Element
    mutating func append(_ newElement: __owned Element)
    mutating func append<S>(contentsOf newElements: __owned S) where S : Sequence, Element == S.Element
    mutating func insert(_ newElement: __owned Element, at i: Index)
    mutating func insert<C>(contentsOf newElements: __owned C, at i: Index) where C : Collection, C.Element == Element
    mutating func popLast() -> Element? where Self : BidirectionalCollection
    @discardableResult mutating func remove(at i: Index) -> Element
    @discardableResult mutating func remove(at position: Index) -> Element
    mutating func removeAll(keepingCapacity keepCapacity: Bool = x)
    mutating func removeAll(where shouldBeRemoved: (Element) throws -> Bool) rethrows
    mutating func removeAll(where shouldBeRemoved: (Element) throws -> Bool) rethrows
    @discardableResult mutating func removeLast() -> Element where Self : BidirectionalCollection
    mutating func removeLast(_ k: Int) where Self : BidirectionalCollection
    mutating func removeSubrange(_ bounds: Range<Index>)
    mutating func removeSubrange(_ bounds: Range<Index>)
    mutating func replaceSubrange<C, R>(_ subrange: R, with newElements: __owned C) where C : Collection, R : RangeExpression, C.Element == Element, Index == R.Bound
    mutating func replaceSubrange<C>(_ subrange: Range<Index>, with newElements: __owned C) where C : Collection, C.Element == Element
    mutating func reserveCapacity(_ n: Int)
    mutating func reserveCapacity(_ n: Int)
}
public protocol RawRepresentable {
    init?(rawValue: RawValue)
    var hashValue: Int { get } where RawValue : Hashable, Self : Hashable
    var rawValue: RawValue { get }
    func hash(into hasher: inout Hasher) where RawValue : Hashable, Self : Hashable
}
public protocol SIMD {
}
public protocol SIMDScalar {
}
public protocol SIMDStorage {
    init()
    var scalarCount: Int { get }
    subscript(index: Int) -> Scalar { get set }
}
public protocol Sequence {
    var lazy: LazySequence<Self> { get }
    var underestimatedCount: Int { get }
    func allSatisfy(_ predicate: (Element) throws -> Bool) rethrows -> Bool
    func compactMap<ElementOfResult>(_ transform: (Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult]
    func contains(_ element: Element) -> Bool where Element : Equatable
    func contains(where predicate: (Element) throws -> Bool) rethrows -> Bool
    func count(where predicate: (Element) throws -> Bool) rethrows -> Int
    func elementsEqual<OtherSequence>(_ other: OtherSequence) -> Bool where Element : Equatable, OtherSequence : Sequence, Element == OtherSequence.Element
    func elementsEqual<OtherSequence>(_ other: OtherSequence, by areEquivalent: (Element, OtherSequence.Element) throws -> Bool) rethrows -> Bool where OtherSequence : Sequence
    func enumerated() -> EnumeratedSequence<Self>
    func first(where predicate: (Element) throws -> Bool) rethrows -> Element?
    func flatMap<SegmentOfResult>(_ transform: (Element) throws -> SegmentOfResult) rethrows -> [SegmentOfResult.Element] where SegmentOfResult : Sequence
    func forEach(_ body: (Element) throws -> Void) rethrows
    func joined(separator: String = x) -> String where Element : StringProtocol
    func lexicographicallyPrecedes<OtherSequence>(_ other: OtherSequence) -> Bool where Element : Comparable, OtherSequence : Sequence, Element == OtherSequence.Element
    func lexicographicallyPrecedes<OtherSequence>(_ other: OtherSequence, by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Bool where OtherSequence : Sequence, Element == OtherSequence.Element
    func map<T>(_ transform: (Element) throws -> T) rethrows -> [T]
    func max() -> Element? where Element : Comparable
    func max(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Element?
    func min() -> Element? where Element : Comparable
    func min(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Element?
    func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (_ partialResult: Result, Element) throws -> Result) rethrows -> Result
    func reduce<Result>(into initialResult: __owned Result, _ updateAccumulatingResult: (_ partialResult: inout Result, Element) throws -> Void) rethrows -> Result
    func shuffled() -> [Element]
    func shuffled<T>(using generator: inout T) -> [Element] where T : RandomNumberGenerator
    func sorted() -> [Element] where Element : Comparable
    func sorted(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> [Element]
    func starts<PossiblePrefix>(with possiblePrefix: PossiblePrefix) -> Bool where Element : Equatable, PossiblePrefix : Sequence, Element == PossiblePrefix.Element
    func starts<PossiblePrefix>(with possiblePrefix: PossiblePrefix, by areEquivalent: (Element, PossiblePrefix.Element) throws -> Bool) rethrows -> Bool where PossiblePrefix : Sequence
    func withContiguousStorageIfAvailable<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R?
}
public protocol SetAlgebra {
    init()
    init<S>(_ sequence: __owned S) where S : Sequence, Element == S.Element
    var isEmpty: Bool { get }
    func contains(_ member: Element) -> Bool
    mutating func formIntersection(_ other: Self)
    mutating func formSymmetricDifference(_ other: __owned Self)
    mutating func formUnion(_ other: __owned Self)
    @discardableResult mutating func insert(_ newMember: __owned Element) -> (inserted : Bool, memberAfterInsert : Element)
    func isDisjoint(with other: Self) -> Bool
    func isStrictSubset(of other: Self) -> Bool
    func isStrictSuperset(of other: Self) -> Bool
    func isSubset(of other: Self) -> Bool
    func isSuperset(of other: Self) -> Bool
    func isSuperset(of other: Self) -> Bool
    @discardableResult mutating func remove(_ member: Element) -> Element?
    mutating func subtract(_ other: Self)
    func subtracting(_ other: Self) -> Self
    @discardableResult mutating func update(with newMember: __owned Element) -> Element?
}
public protocol SignedInteger {
    static var max: Self { get } where Self : FixedWidthInteger
    static var min: Self { get } where Self : FixedWidthInteger
    func &+(lhs: Self, rhs: Self) -> Self where Self : FixedWidthInteger
    func &-(lhs: Self, rhs: Self) -> Self where Self : FixedWidthInteger
}
public protocol SignedNumeric {
    prefix func -(operand: Self) -> Self
    prefix func -(operand: Self) -> Self
    mutating func negate()
}
public protocol Strideable {
    func +(lhs: Self, rhs: Stride) -> Self where Self : _Pointer
    func +=(lhs: inout Self, rhs: Stride) where Self : _Pointer
    func -(lhs: Self, rhs: Self) -> Stride where Self : _Pointer
    func -=(lhs: inout Self, rhs: Stride) where Self : _Pointer
    func advanced(by n: Stride) -> Self
    func distance(to other: Self) -> Stride
}
public protocol StringInterpolationProtocol {
    init(literalCapacity: Int, interpolationCount: Int)
    mutating func appendLiteral(_ literal: StringLiteralType)
}
public protocol StringProtocol {
    init(cString nullTerminatedUTF8: UnsafePointer<CChar>)
    init<C, Encoding>(decoding codeUnits: C, as sourceEncoding: Encoding.Type) where C : Collection, Encoding : Unicode.Encoding, C.Iterator.Element == Encoding.CodeUnit
    init<Encoding>(decodingCString nullTerminatedCodeUnits: UnsafePointer<Encoding.CodeUnit>, as sourceEncoding: Encoding.Type) where Encoding : Unicode.Encoding
    var unicodeScalars: UnicodeScalarView { get }
    var utf16: UTF16View { get }
    var utf8: UTF8View { get }
    func hasPrefix<Prefix>(_ prefix: Prefix) -> Bool where Prefix : StringProtocol
    func hasSuffix<Suffix>(_ suffix: Suffix) -> Bool where Suffix : StringProtocol
    func lowercased() -> String
    func uppercased() -> String
    func withCString<Result>(_ body: (UnsafePointer<CChar>) throws -> Result) rethrows -> Result
    func withCString<Result, Encoding>(encodedAs targetEncoding: Encoding.Type, _ body: (UnsafePointer<Encoding.CodeUnit>) throws -> Result) rethrows -> Result where Encoding : Unicode.Encoding
}
public protocol TextOutputStream {
    mutating func write(_ string: String)
}
public protocol TextOutputStreamable {
    func write<Target>(to target: inout Target) where Target : TextOutputStream
}
public protocol UnicodeCodec {
    static func encode(_ input: Unicode.Scalar, into processCodeUnit: (CodeUnit) -> Void)
    init()
    mutating func decode<I>(_ input: inout I) -> UnicodeDecodingResult where I : IteratorProtocol, CodeUnit == I.Element
}
public protocol UnsignedInteger {
    static var max: Self { get } where Self : FixedWidthInteger
    static var min: Self { get } where Self : FixedWidthInteger
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
    public init(_ other: Range<Bound>) where Bound : Strideable, Bound.Stride : SignedInteger {}
    public init(from decoder: Decoder) throws where Bound : Decodable {}
    public func clamped(to limits: ClosedRange) -> ClosedRange {}
    public func encode(to encoder: Encoder) throws where Bound : Encodable {}
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
    public mutating func merge<S>(_ other: __owned S, uniquingKeysWith combine: (Value, Value) throws -> Value) rethrows where S : Sequence, (Key, Value) == S.Element {}
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
    public func ==(lhs: LazyPrefixWhileCollection<Base>.Index, rhs: LazyPrefixWhileCollection<Base>.Index) -> Bool where Base : Collection {}
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
    public init(from decoder: Decoder) throws where Bound : Decodable {}
    public func encode(to encoder: Encoder) throws where Bound : Encodable {}
}
extension PartialRangeThrough {
    public init(from decoder: Decoder) throws where Bound : Decodable {}
    public func encode(to encoder: Encoder) throws where Bound : Encodable {}
}
extension PartialRangeUpTo {
    public init(from decoder: Decoder) throws where Bound : Decodable {}
    public func encode(to encoder: Encoder) throws where Bound : Encodable {}
}
extension PrefixSequence {
}
extension PrefixSequence.Iterator {
}
extension Range {
    public init(_ other: ClosedRange<Bound>) where Bound : Strideable, Bound.Stride : SignedInteger {}
    public init(from decoder: Decoder) throws where Bound : Decodable {}
    public func clamped(to limits: Range) -> Range {}
    public func encode(to encoder: Encoder) throws where Bound : Encodable {}
    public func overlaps(_ other: Range<Bound>) -> Bool {}
}
extension Repeated {
}
extension Result {
    public init(catching body: () throws -> Success) where Failure == Swift.Error {}
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
    public subscript(index: Index) -> Base.Element { get set } where Base : MutableCollection {}
}
extension StrideThrough {
#if false
    public var count: Int { get } where Element.Stride : BinaryInteger
#endif
}
extension StrideThroughIterator {
}
extension StrideTo {
#if false
    public var count: Int { get } where Element.Stride : BinaryInteger
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
    public var count: Int { get }
    @available(swift, introduced: 4) public subscript(r: Range<Index>) -> String.UTF8View.SubSequence { get } {}
    public subscript(i: Index) -> UTF8.CodeUnit { get } {}
    public func withContiguousStorageIfAvailable<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R? {}
}
extension String.UTF8View.Index {
    public init?(_ idx: String.Index, within target: String.UTF8View) {}
}
extension String.UnicodeScalarView {
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
    public mutating func parseScalar<I>(from input: inout I) -> Unicode.ParseResult<Encoding.EncodedScalar> where I : IteratorProtocol, Encoding.CodeUnit == I.Element {}
}
extension UTF8.CodeUnit {
}
extension UTF8.ReverseParser {
}
extension UTF8ValidationResult {
}
extension Unicode.ASCII.Parser {
    public mutating func parseScalar<I>(from input: inout I) -> Unicode.ParseResult<Encoding.EncodedScalar> where I : IteratorProtocol, Encoding.CodeUnit == I.Element {}
}
extension Unicode.Scalar {
    public var isASCII: Bool { get }
    public var utf16: UTF16View { get }
    public var value: UInt32 { get }
    public func escaped(asASCII forceASCII: Bool) -> String {}
}
extension Unicode.Scalar.UTF16View {
}
extension Unicode.UTF32 {
    public static var encodedReplacementCharacter: EncodedScalar { get }
    public static func decode(_ source: EncodedScalar) -> Unicode.Scalar {}
    public static func encode(_ source: Unicode.Scalar) -> EncodedScalar? {}
}
extension Unicode.UTF8 {
    public static var encodedReplacementCharacter: EncodedScalar { get }
    public static func decode(_ source: EncodedScalar) -> Unicode.Scalar {}
    public static func encode(_ source: Unicode.Scalar) -> EncodedScalar? {}
    public static func transcode<FromEncoding>(_ content: FromEncoding.EncodedScalar, from _: FromEncoding.Type) -> EncodedScalar? where FromEncoding : _UnicodeEncoding {}
}
extension Unicode.UTF8.ForwardParser {
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