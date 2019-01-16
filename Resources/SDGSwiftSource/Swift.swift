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
public var endIndex: Index { get }
public var indices: Indices { get }
public var startIndex: Index { get }
public subscript(bounds: Range<Index>) -> SubSequence { get } {}
public subscript(position: Index) -> Element { get } {}
public func distance(from start: Index, to end: Index) -> Int {}
public func formIndex(after i: inout Index) {}
public func formIndex(before i: inout Index) {}
public func index(_ i: Index, offsetBy distance: Int) -> Index {}
public func index(_ i: Index, offsetBy distance: Int, limitedBy limit: Index) -> Index? {}
public func index(after i: Index) -> Index {}
public func index(before i: Index) -> Index {}
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
public var description: String { get }
public var trailingZeroBitCount: Int { get }
public var words: Words { get }
public func !=<Other>(lhs: Self, rhs: Other) -> Bool  where Other : BinaryInteger {}
public func %(lhs: Self, rhs: Self) -> Self {}
public func %=(lhs: inout Self, rhs: Self) {}
public func &(lhs: Self, rhs: Self) -> Self {}
public func &=(lhs: inout Self, rhs: Self) {}
public func /(lhs: Self, rhs: Self) -> Self {}
public func /=(lhs: inout Self, rhs: Self) {}
public func <<Other>(lhs: Self, rhs: Other) -> Bool  where Other : BinaryInteger {}
public func <<<RHS>(lhs: Self, rhs: RHS) -> Self  where RHS : BinaryInteger {}
public func <<=<RHS>(lhs: inout Self, rhs: RHS)  where RHS : BinaryInteger {}
public func <=<Other>(lhs: Self, rhs: Other) -> Bool  where Other : BinaryInteger {}
public func ==<Other>(lhs: Self, rhs: Other) -> Bool  where Other : BinaryInteger {}
public func ><Other>(lhs: Self, rhs: Other) -> Bool  where Other : BinaryInteger {}
public func >=<Other>(lhs: Self, rhs: Other) -> Bool  where Other : BinaryInteger {}
public func >><RHS>(lhs: Self, rhs: RHS) -> Self  where RHS : BinaryInteger {}
public func >>=<RHS>(lhs: inout Self, rhs: RHS)  where RHS : BinaryInteger {}
public func ^(lhs: Self, rhs: Self) -> Self {}
public func ^=(lhs: inout Self, rhs: Self) {}
public func advanced(by n: Int) -> Self {}
public func distance(to other: Self) -> Int {}
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
public var indices: Indices { get }
public var isEmpty: Bool { get }
public var isEmpty: Bool { get }
public var startIndex: Index { get }
public var underestimatedCount: Int { get }
public subscript(bounds: Range<Index>) -> Slice<Self> { get }  where Slice<Self> == SubSequence {}
public subscript(bounds: Range<Index>) -> SubSequence { get } {}
public func distance(from start: Index, to end: Index) -> Int {}
public func formIndex(_ i: inout Index, offsetBy distance: Int) {}
public func formIndex(_ i: inout Index, offsetBy distance: Int, limitedBy limit: Index) -> Bool {}
public func formIndex(after i: inout Index) {}
public func index(_ i: Index, offsetBy distance: Int) -> Index {}
public func index(_ i: Index, offsetBy distance: Int, limitedBy limit: Index) -> Index? {}
public func index(after i: Index) -> Index {}
public func makeIterator() -> Iterator {}
public func map<T>(_ transform: (Element) throws -> T) rethrows -> [T] {}
public mutating func popFirst() -> Element?  where Self == SubSequence {}
public func randomElement() -> Element? {}
public func randomElement<T>(using generator: inout T) -> Element?  where T : RandomNumberGenerator {}
@discardableResult public mutating func removeFirst() -> Element  where Self == SubSequence {}
public mutating func removeFirst(_ k: Int)  where Self == SubSequence {}
}
public protocol Comparable {
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
public init?<Source>(exactly value: Source)  where Source : BinaryInteger {}
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
public func *(lhs: Self, rhs: Self) -> Self {}
public func *=(lhs: inout Self, rhs: Self) {}
public func +(lhs: Self, rhs: Self) -> Self {}
public func +=(lhs: inout Self, rhs: Self) {}
public prefix func -(operand: Self) -> Self {}
public func -(lhs: Self, rhs: Self) -> Self {}
public func -=(lhs: inout Self, rhs: Self) {}
public func /(lhs: Self, rhs: Self) -> Self {}
public func /=(lhs: inout Self, rhs: Self) {}
public func <(lhs: Self, rhs: Self) -> Bool {}
public func <=(lhs: Self, rhs: Self) -> Bool {}
public func ==(lhs: Self, rhs: Self) -> Bool {}
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
public mutating func negate() {}
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
public var lazy: Elements { get }  where Elements : LazyCollectionProtocol
}
public protocol LazySequenceProtocol {
public var elements: Elements { get }
public var elements: Self { get }  where Elements == Self
public var lazy: Elements { get }  where Elements : LazySequenceProtocol
}
public protocol LosslessStringConvertible {
public init?(_ description: String) {}
}
public protocol MirrorPath {
}
public protocol MutableCollection {
public subscript(bounds: Range<Index>) -> Slice<Self> { get set } {}
public mutating func partition(by belongsInSecondPartition: (Element) throws -> Bool) rethrows -> Index {}
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
public init()  where RawValue : FixedWidthInteger {}
public init(rawValue: RawValue) {}
public func contains(_ member: Self) -> Bool  where Element == Self {}
public mutating func formIntersection(_ other: Self)  where RawValue : FixedWidthInteger {}
public mutating func formSymmetricDifference(_ other: Self)  where RawValue : FixedWidthInteger {}
public mutating func formUnion(_ other: Self)  where RawValue : FixedWidthInteger {}
@discardableResult public mutating func insert(_ newMember: Element) -> (inserted : Bool, memberAfterInsert : Element)  where Element == Self {}
public func intersection(_ other: Self) -> Self {}
@discardableResult public mutating func remove(_ member: Element) -> Element?  where Element == Self {}
public func symmetricDifference(_ other: Self) -> Self {}
public func union(_ other: Self) -> Self {}
@discardableResult public mutating func update(with newMember: Element) -> Element?  where Element == Self {}
}
public protocol RandomAccessCollection {
public var endIndex: Index { get }
public var indices: Indices { get }
public var indices: Range<Index> { get }  where Index : Strideable, Index.Stride == Int, Indices == Range<Index>
public var startIndex: Index { get }
public subscript(bounds: Range<Index>) -> SubSequence { get } {}
public subscript(position: Index) -> Element { get } {}
public func distance(from start: Index, to end: Index) -> Index.Stride  where Index : Strideable, Index.Stride == Int, Indices == Range<Index> {}
public func formIndex(after i: inout Index) {}
public func formIndex(before i: inout Index) {}
public func index(_ i: Index, offsetBy distance: Index.Stride) -> Index  where Index : Strideable, Index.Stride == Int, Indices == Range<Index> {}
public func index(_ i: Index, offsetBy distance: Int, limitedBy limit: Index) -> Index? {}
public func index(after i: Index) -> Index  where Index : Strideable, Index.Stride == Int, Indices == Range<Index> {}
public func index(after i: Index) -> Index {}
public func index(before i: Index) -> Index  where Index : Strideable, Index.Stride == Int, Indices == Range<Index> {}
public func index(before i: Index) -> Index {}
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
public subscript(bounds: Index) -> Element { get } {}
public func +<Other>(lhs: Other, rhs: Self) -> Self  where Other : Sequence, Element == Other.Element {}
public func +<Other>(lhs: Self, rhs: Other) -> Self  where Other : Sequence, Element == Other.Element {}
public func +<Other>(lhs: Self, rhs: Other) -> Self  where Other : RangeReplaceableCollection, Element == Other.Element {}
public func +=<Other>(lhs: inout Self, rhs: Other)  where Other : Sequence, Element == Other.Element {}
public mutating func append(_ newElement: __owned Element) {}
public mutating func append<S>(contentsOf newElements: __owned S)  where S : Sequence, Element == S.Element {}
public mutating func insert(_ newElement: __owned Element, at i: Index) {}
public mutating func insert<C>(contentsOf newElements: __owned C, at i: Index)  where C : Collection, C.Element == Element {}
public mutating func popLast() -> Element?  where Self : BidirectionalCollection {}
@discardableResult public mutating func remove(at i: Index) -> Element {}
@discardableResult public mutating func remove(at position: Index) -> Element {}
public mutating func removeAll(keepingCapacity keepCapacity: Bool = default) {}
public mutating func removeAll(where shouldBeRemoved: (Element) throws -> Bool) rethrows {}
public mutating func removeAll(where shouldBeRemoved: (Element) throws -> Bool) rethrows {}
@discardableResult public mutating func removeFirst() -> Element {}
@discardableResult public mutating func removeFirst() -> Element  where Self == SubSequence {}
public mutating func removeFirst(_ k: Int)  where Self == SubSequence {}
public mutating func removeFirst(_ k: Int) {}
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
public var underestimatedCount: Int { get }
public func first(where predicate: (Element) throws -> Bool) rethrows -> Element? {}
public func forEach(_ body: (Element) throws -> Void) rethrows {}
public func map<T>(_ transform: (Element) throws -> T) rethrows -> [T] {}
public func withContiguousStorageIfAvailable<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R? {}
}
public protocol SetAlgebra {
public init() {}
public init<S>(_ sequence: __owned S)  where S : Sequence, Element == S.Element {}
public init(arrayLiteral: Element...)  where ArrayLiteralElement == Element {}
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
public func <(x: Self, y: Self) -> Bool {}
public func ==(x: Self, y: Self) -> Bool {}
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
public func hasPrefix(_ prefix: String) -> Bool {}
public func hasSuffix(_ prefix: String) -> Bool {}
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
}
extension Array {
public init() {}
public init<S>(_ s: S)  where S : Sequence, Element == S.Element {}
public init(arrayLiteral elements: Element...) {}
public init(repeating repeatedValue: Element, count: Int) {}
public var capacity: Int { get }
public var count: Int { get }
public var customMirror: Mirror { get }
public var debugDescription: String { get }
public var description: String { get }
public var endIndex: Int { get }
public var startIndex: Int { get }
public subscript(bounds: Range<Int>) -> ArraySlice<Element> { get set } {}
public func +(lhs: Array, rhs: Array) -> Array {}
public func +=(lhs: inout Array, rhs: Array) {}
public func ==(lhs: [Element], rhs: [Element]) -> Bool  where Element : Equatable {}
public mutating func append(_ newElement: __owned Element) {}
public mutating func append<S>(contentsOf newElements: __owned S)  where S : Sequence, Element == S.Element {}
public func distance(from start: Int, to end: Int) -> Int {}
public func formIndex(after i: inout Int) {}
public func formIndex(before i: inout Int) {}
public func hash(into hasher: inout Hasher)  where Element : Hashable {}
public func index(_ i: Int, offsetBy distance: Int) -> Int {}
public func index(_ i: Int, offsetBy distance: Int, limitedBy limit: Int) -> Int? {}
public func index(after i: Int) -> Int {}
public func index(before i: Int) -> Int {}
public mutating func insert(_ newElement: __owned Element, at i: Int) {}
@discardableResult public mutating func remove(at index: Int) -> Element {}
public mutating func removeAll(keepingCapacity keepCapacity: Bool = default) {}
public mutating func replaceSubrange<C>(_ subrange: Range<Int>, with newElements: __owned C)  where C : Collection, C.Element == Element {}
public mutating func reserveCapacity(_ minimumCapacity: Int) {}
public mutating func withContiguousMutableStorageIfAvailable<R>(_ body: (inout UnsafeMutableBufferPointer<Element>) throws -> R) rethrows -> R? {}
public func withContiguousStorageIfAvailable<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R? {}
public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R {}
public func withUnsafeBytes<R>(_ body: (UnsafeRawBufferPointer) throws -> R) rethrows -> R {}
public mutating func withUnsafeMutableBufferPointer<R>(_ body: (inout UnsafeMutableBufferPointer<Element>) throws -> R) rethrows -> R {}
public mutating func withUnsafeMutableBytes<R>(_ body: (UnsafeMutableRawBufferPointer) throws -> R) rethrows -> R {}
}
extension ArraySlice {
public init() {}
public init<S>(_ s: S)  where S : Sequence, Element == S.Element {}
public init(arrayLiteral elements: Element...) {}
public init(repeating repeatedValue: Element, count: Int) {}
public var capacity: Int { get }
public var count: Int { get }
public var customMirror: Mirror { get }
public var debugDescription: String { get }
public var description: String { get }
public var endIndex: Int { get }
public var startIndex: Int { get }
public subscript(bounds: Range<Int>) -> ArraySlice<Element> { get set } {}
public func ==(lhs: ArraySlice<Element>, rhs: ArraySlice<Element>) -> Bool  where Element : Equatable {}
public mutating func append(_ newElement: __owned Element) {}
public mutating func append<S>(contentsOf newElements: __owned S)  where S : Sequence, Element == S.Element {}
public func distance(from start: Int, to end: Int) -> Int {}
public func formIndex(after i: inout Int) {}
public func formIndex(before i: inout Int) {}
public func hash(into hasher: inout Hasher)  where Element : Hashable {}
public func index(_ i: Int, offsetBy distance: Int) -> Int {}
public func index(_ i: Int, offsetBy distance: Int, limitedBy limit: Int) -> Int? {}
public func index(after i: Int) -> Int {}
public func index(before i: Int) -> Int {}
public mutating func insert(_ newElement: __owned Element, at i: Int) {}
@discardableResult public mutating func remove(at index: Int) -> Element {}
public mutating func removeAll(keepingCapacity keepCapacity: Bool = default) {}
public mutating func replaceSubrange<C>(_ subrange: Range<Int>, with newElements: __owned C)  where C : Collection, C.Element == Element {}
public mutating func reserveCapacity(_ minimumCapacity: Int) {}
public mutating func withContiguousMutableStorageIfAvailable<R>(_ body: (inout UnsafeMutableBufferPointer<Element>) throws -> R) rethrows -> R? {}
public func withContiguousStorageIfAvailable<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R? {}
public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R {}
public func withUnsafeBytes<R>(_ body: (UnsafeRawBufferPointer) throws -> R) rethrows -> R {}
public mutating func withUnsafeMutableBufferPointer<R>(_ body: (inout UnsafeMutableBufferPointer<Element>) throws -> R) rethrows -> R {}
public mutating func withUnsafeMutableBytes<R>(_ body: (UnsafeMutableRawBufferPointer) throws -> R) rethrows -> R {}
}
extension AutoreleasingUnsafeMutablePointer {
}
extension BidirectionalCollection {
public var last: Element? { get }
public func last(where predicate: (Element) throws -> Bool) rethrows -> Element? {}
public func lastIndex(of element: Element) -> Index?  where Element : Equatable {}
public func lastIndex(where predicate: (Element) throws -> Bool) rethrows -> Index? {}
}
extension BidirectionalCollection {
public func joined(separator: String = default) -> String  where Element == String {}
}
extension Bool {
}
extension Character {
}
extension Character {
public var asciiValue: UInt8? { get }
public var hexDigitValue: Int? { get }
public var isASCII: Bool { get }
public var isCased: Bool { get }
public var isCurrencySymbol: Bool { get }
public var isHexDigit: Bool { get }
public var isLetter: Bool { get }
public var isLowercase: Bool { get }
public var isMathSymbol: Bool { get }
public var isNewline: Bool { get }
public var isNumber: Bool { get }
public var isPunctuation: Bool { get }
public var isSymbol: Bool { get }
public var isUppercase: Bool { get }
public var isWhitespace: Bool { get }
public var isWholeNumber: Bool { get }
public var wholeNumberValue: Int? { get }
public func lowercased() -> String {}
public func uppercased() -> String {}
}
extension ClosedRange {
public init(_ other: Range<Bound>)  where Bound : Strideable, Bound.Stride : SignedInteger {}
public init(from decoder: Decoder) throws  where Bound : Decodable {}
public var customMirror: Mirror { get }
public var debugDescription: String { get }
public var description: String { get }
public var endIndex: Index { get }  where Bound : Strideable, Bound.Stride : SignedInteger
public var isEmpty: Bool { get }
public var startIndex: Index { get }  where Bound : Strideable, Bound.Stride : SignedInteger
public subscript(bounds: Range<Index>) -> Slice<ClosedRange<Bound>> { get }  where Bound : Strideable, Bound.Stride : SignedInteger {}
public subscript(position: Index) -> Bound { get }  where Bound : Strideable, Bound.Stride : SignedInteger {}
public func ==(lhs: ClosedRange<Bound>, rhs: ClosedRange<Bound>) -> Bool {}
public func clamped(to limits: ClosedRange) -> ClosedRange {}
public func contains(_ element: Bound) -> Bool {}
public func distance(from start: Index, to end: Index) -> Int  where Bound : Strideable, Bound.Stride : SignedInteger {}
public func encode(to encoder: Encoder) throws  where Bound : Encodable {}
public func hash(into hasher: inout Hasher)  where Bound : Hashable {}
public func index(_ i: Index, offsetBy distance: Int) -> Index  where Bound : Strideable, Bound.Stride : SignedInteger {}
public func index(after i: Index) -> Index  where Bound : Strideable, Bound.Stride : SignedInteger {}
public func index(before i: Index) -> Index  where Bound : Strideable, Bound.Stride : SignedInteger {}
public func overlaps(_ other: ClosedRange<Bound>) -> Bool {}
public func relative<C>(to collection: C) -> Range<Bound>  where C : Collection, Bound == C.Index {}
}
extension ClosedRange.Index {
public func <(lhs: ClosedRange<Bound>.Index, rhs: ClosedRange<Bound>.Index) -> Bool {}
public func ==(lhs: ClosedRange<Bound>.Index, rhs: ClosedRange<Bound>.Index) -> Bool {}
public func hash(into hasher: inout Hasher)  where Bound : Hashable, Bound : Strideable, Bound.Stride : SignedInteger {}
}
extension Collection {
public subscript(x: UnboundedRange) -> SubSequence { get } {}
public subscript<R>(r: R) -> SubSequence { get }  where R : RangeExpression, Index == R.Bound {}
}
extension Collection {
public var indices: DefaultIndices<Self> { get }  where DefaultIndices<Self> == Indices
}
extension Collection {
public func firstIndex(of element: Element) -> Index?  where Element : Equatable {}
public func firstIndex(where predicate: (Element) throws -> Bool) rethrows -> Index? {}
}
extension CollectionOfOne {
public var count: Int { get }
public var customMirror: Mirror { get }
public var debugDescription: String { get }
public var endIndex: Index { get }
public var startIndex: Index { get }
public subscript(bounds: Range<Int>) -> SubSequence { get set } {}
public func index(after i: Index) -> Index {}
public func index(before i: Index) -> Index {}
}
extension CollectionOfOne.Iterator {
public mutating func next() -> Element? {}
}
extension Comparable {
public func ...(minimum: Self, maximum: Self) -> ClosedRange<Self> {}
}
extension Comparable {
public postfix func ...(minimum: Self) -> PartialRangeFrom<Self> {}
public prefix func ...(maximum: Self) -> PartialRangeThrough<Self> {}
public prefix func ..<(maximum: Self) -> PartialRangeUpTo<Self> {}
public func ..<(minimum: Self, maximum: Self) -> Range<Self> {}
}
extension ContiguousArray {
}
extension ContiguousArray {
public init() {}
public init<S>(_ s: S)  where S : Sequence, Element == S.Element {}
public init(arrayLiteral elements: Element...) {}
public init(repeating repeatedValue: Element, count: Int) {}
public var capacity: Int { get }
public var count: Int { get }
public var customMirror: Mirror { get }
public var debugDescription: String { get }
public var description: String { get }
public var endIndex: Int { get }
public var startIndex: Int { get }
public subscript(bounds: Range<Int>) -> ArraySlice<Element> { get set } {}
public func ==(lhs: ContiguousArray<Element>, rhs: ContiguousArray<Element>) -> Bool  where Element : Equatable {}
public mutating func append(_ newElement: __owned Element) {}
public mutating func append<S>(contentsOf newElements: __owned S)  where S : Sequence, Element == S.Element {}
public func distance(from start: Int, to end: Int) -> Int {}
public func formIndex(after i: inout Int) {}
public func formIndex(before i: inout Int) {}
public func hash(into hasher: inout Hasher)  where Element : Hashable {}
public func index(_ i: Int, offsetBy distance: Int) -> Int {}
public func index(_ i: Int, offsetBy distance: Int, limitedBy limit: Int) -> Int? {}
public func index(after i: Int) -> Int {}
public func index(before i: Int) -> Int {}
public mutating func insert(_ newElement: __owned Element, at i: Int) {}
@discardableResult public mutating func remove(at index: Int) -> Element {}
public mutating func removeAll(keepingCapacity keepCapacity: Bool = default) {}
public mutating func replaceSubrange<C>(_ subrange: Range<Int>, with newElements: __owned C)  where C : Collection, C.Element == Element {}
public mutating func reserveCapacity(_ minimumCapacity: Int) {}
public mutating func withContiguousMutableStorageIfAvailable<R>(_ body: (inout UnsafeMutableBufferPointer<Element>) throws -> R) rethrows -> R? {}
public func withContiguousStorageIfAvailable<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R? {}
public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R {}
public func withUnsafeBytes<R>(_ body: (UnsafeRawBufferPointer) throws -> R) rethrows -> R {}
public mutating func withUnsafeMutableBufferPointer<R>(_ body: (inout UnsafeMutableBufferPointer<Element>) throws -> R) rethrows -> R {}
public mutating func withUnsafeMutableBytes<R>(_ body: (UnsafeMutableRawBufferPointer) throws -> R) rethrows -> R {}
}
extension DefaultIndices {
public var endIndex: Index { get }
public var indices: Indices { get }
public var startIndex: Index { get }
public subscript(bounds: Range<Index>) -> DefaultIndices<Elements> { get } {}
public subscript(i: Index) -> Elements.Index { get } {}
public func formIndex(after i: inout Index) {}
public func formIndex(before i: inout Index)  where Elements : BidirectionalCollection {}
public func index(after i: Index) -> Index {}
public func index(before i: Index) -> Index  where Elements : BidirectionalCollection {}
}
extension Dictionary {
public var capacity: Int { get }
public var count: Int { get }
public var customMirror: Mirror { get }
public var debugDescription: String { get }
public var description: String { get }
public var endIndex: Index { get }
public var isEmpty: Bool { get }
@available(swift, introduced: 4.0) public var keys: Keys { get }
public var startIndex: Index { get }
public subscript(position: Index) -> Element { get } {}
public func ==(lhs: [Key: Value], rhs: [Key: Value]) -> Bool  where Value : Equatable {}
public func compactMapValues<T>(_ transform: (Value) throws -> T?) rethrows -> [Key: T] {}
public func formIndex(after i: inout Index) {}
public func hash(into hasher: inout Hasher)  where Value : Hashable {}
public func index(after i: Index) -> Index {}
public func index(forKey key: Key) -> Index? {}
public func mapValues<T>(_ transform: (Value) throws -> T) rethrows -> [Key: T] {}
public mutating func merge(_ other: __owned [Key: Value], uniquingKeysWith combine: (Value, Value) throws -> Value) rethrows {}
public mutating func merge<S>(_ other: __owned S, uniquingKeysWith combine: (Value, Value) throws -> Value) rethrows  where S : Sequence, (Key, Value) == S.Element {}
public mutating func popFirst() -> Element? {}
@discardableResult public mutating func remove(at index: Index) -> Element {}
public mutating func removeAll(keepingCapacity keepCapacity: Bool = default) {}
@discardableResult public mutating func removeValue(forKey key: Key) -> Value? {}
public mutating func reserveCapacity(_ minimumCapacity: Int) {}
@discardableResult public mutating func updateValue(_ value: __owned Value, forKey key: Key) -> Value? {}
}
extension Dictionary.Index {
public func <(lhs: [Key: Value].Index, rhs: [Key: Value].Index) -> Bool {}
public func ==(lhs: [Key: Value].Index, rhs: [Key: Value].Index) -> Bool {}
public func hash(into hasher: inout Hasher) {}
}
extension Dictionary.Iterator {
public var customMirror: Mirror { get }
public mutating func next() -> (key : Key, value : Value)? {}
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
public var endIndex: Index { get }
public var startIndex: Index { get }
public subscript(bounds: Range<Index>) -> SubSequence { get set } {}
public subscript(position: Index) -> Element { get set } {}
public func ==(lhs: EmptyCollection<Element>, rhs: EmptyCollection<Element>) -> Bool {}
public func distance(from start: Index, to end: Index) -> Int {}
public func index(_ i: Index, offsetBy n: Int) -> Index {}
public func index(_ i: Index, offsetBy n: Int, limitedBy limit: Index) -> Index? {}
public func index(after i: Index) -> Index {}
public func index(before i: Index) -> Index {}
public func makeIterator() -> Iterator {}
}
extension EmptyCollection.Iterator {
public mutating func next() -> Element? {}
}
extension EnumeratedSequence {
}
extension EnumeratedSequence.Iterator {
public mutating func next() -> Element? {}
}
extension ExpressibleByIntegerLiteral {
public init(integerLiteral value: Self)  where Self : _ExpressibleByBuiltinIntegerLiteral {}
}
extension FixedWidthInteger {
public init?(_ description: String) {}
public init?<S>(_ text: S, radix: Int = default)  where S : StringProtocol {}
}
extension FlattenCollection {
public var endIndex: Index { get }
public var startIndex: Index { get }
public subscript(bounds: Range<Index>) -> SubSequence { get } {}
public subscript(position: Index) -> Base.Element.Element { get } {}
public func distance(from start: Index, to end: Index) -> Int {}
public func formIndex(_ i: inout Index, offsetBy n: Int) {}
public func formIndex(_ i: inout Index, offsetBy n: Int, limitedBy limit: Index) -> Bool {}
public func formIndex(after i: inout Index) {}
public func formIndex(before i: inout Index)  where Base : BidirectionalCollection, Base.Element : BidirectionalCollection {}
public func index(_ i: Index, offsetBy n: Int) -> Index {}
public func index(_ i: Index, offsetBy n: Int, limitedBy limit: Index) -> Index? {}
public func index(after i: Index) -> Index {}
public func index(before i: Index) -> Index  where Base : BidirectionalCollection, Base.Element : BidirectionalCollection {}
}
extension FlattenSequence {
}
extension FlattenSequence.Index {
public func <(lhs: FlattenCollection<Base>.Index, rhs: FlattenCollection<Base>.Index) -> Bool  where Base : Collection, Base.Element : Collection {}
public func ==(lhs: FlattenCollection<Base>.Index, rhs: FlattenCollection<Base>.Index) -> Bool  where Base : Collection, Base.Element : Collection {}
public func hash(into hasher: inout Hasher)  where Base : Collection, Base.Element : Collection, Base.Element.Index : Hashable, Base.Index : Hashable {}
}
extension FlattenSequence.Iterator {
public mutating func next() -> Element? {}
}
extension Float {
}
extension Float80 {
}
extension IndexingIterator {
public mutating func next() -> Elements.Element? {}
}
extension Int {
public init(bitPattern pointer: OpaquePointer?) {}
}
extension Int {
}
extension Int {
}
extension Int {
public init(bitPattern objectID: ObjectIdentifier) {}
}
extension Int {
public init<P>(bitPattern pointer: P?)  where P : _Pointer {}
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
public mutating func next() -> Element? {}
}
extension KeyValuePairs {
public var debugDescription: String { get }
public var description: String { get }
public var endIndex: Index { get }
public var startIndex: Index { get }
public subscript(position: Index) -> Element { get } {}
}
extension LazyCollection {
public var count: Int { get }
public var endIndex: Index { get }
public var indices: Indices { get }
public var isEmpty: Bool { get }
public var startIndex: Index { get }
public subscript(position: Index) -> Element { get } {}
public func distance(from start: Index, to end: Index) -> Int {}
public func index(_ i: Index, offsetBy n: Int) -> Index {}
public func index(_ i: Index, offsetBy n: Int, limitedBy limit: Index) -> Index? {}
public func index(after i: Index) -> Index {}
public func index(before i: Index) -> Index  where Base : BidirectionalCollection {}
}
extension LazyDropWhileCollection {
public var endIndex: Index { get }
public var startIndex: Index { get }
public subscript(position: Index) -> Element { get } {}
public func index(after i: Index) -> Index {}
public func index(before i: Index) -> Index  where Base : BidirectionalCollection {}
}
extension LazyDropWhileSequence {
}
extension LazyDropWhileSequence.Iterator {
public mutating func next() -> Element? {}
}
extension LazyFilterCollection {
public var endIndex: Index { get }
public var startIndex: Index { get }
public var underestimatedCount: Int { get }
public subscript(bounds: Range<Index>) -> SubSequence { get } {}
public subscript(position: Index) -> Element { get } {}
public func distance(from start: Index, to end: Index) -> Int {}
public func formIndex(_ i: inout Index, offsetBy n: Int) {}
public func formIndex(_ i: inout Index, offsetBy n: Int, limitedBy limit: Index) -> Bool {}
public func formIndex(after i: inout Index) {}
public func formIndex(before i: inout Index)  where Base : BidirectionalCollection {}
public func index(_ i: Index, offsetBy n: Int) -> Index {}
public func index(_ i: Index, offsetBy n: Int, limitedBy limit: Index) -> Index? {}
public func index(after i: Index) -> Index {}
public func index(before i: Index) -> Index  where Base : BidirectionalCollection {}
}
extension LazyFilterSequence {
}
extension LazyFilterSequence.Iterator {
public mutating func next() -> Element? {}
}
extension LazyMapCollection {
public var count: Int { get }
public var endIndex: Base.Index { get }
public var indices: Indices { get }
public var isEmpty: Bool { get }
public var startIndex: Base.Index { get }
public subscript(bounds: Range<Base.Index>) -> SubSequence { get } {}
public subscript(position: Base.Index) -> Element { get } {}
public func distance(from start: Index, to end: Index) -> Int {}
public func formIndex(after i: inout Index) {}
public func formIndex(before i: inout Index)  where Base : BidirectionalCollection {}
public func index(_ i: Index, offsetBy n: Int) -> Index {}
public func index(_ i: Index, offsetBy n: Int, limitedBy limit: Index) -> Index? {}
public func index(after i: Index) -> Index {}
public func index(before i: Index) -> Index  where Base : BidirectionalCollection {}
@available(swift, introduced: 5) public func map<ElementOfResult>(_ transform: @escaping (Element) -> ElementOfResult) -> LazyMapCollection<Base, ElementOfResult> {}
}
extension LazyMapSequence {
public var underestimatedCount: Int { get }
@available(swift, introduced: 5) public func map<ElementOfResult>(_ transform: @escaping (Element) -> ElementOfResult) -> LazyMapSequence<Base, ElementOfResult> {}
}
extension LazyMapSequence.Iterator {
public mutating func next() -> Element? {}
}
extension LazyPrefixWhileCollection {
public var endIndex: Index { get }
public var startIndex: Index { get }
public subscript(position: Index) -> Element { get } {}
public func index(after i: Index) -> Index {}
public func index(before i: Index) -> Index  where Base : BidirectionalCollection {}
}
extension LazyPrefixWhileSequence {
}
extension LazyPrefixWhileSequence.Index {
public func <(lhs: LazyPrefixWhileCollection<Base>.Index, rhs: LazyPrefixWhileCollection<Base>.Index) -> Bool  where Base : Collection {}
public func ==(lhs: LazyPrefixWhileCollection<Base>.Index, rhs: LazyPrefixWhileCollection<Base>.Index) -> Bool  where Base : Collection {}
public func hash(into hasher: inout Hasher)  where Base : Collection, Base.Index : Hashable {}
}
extension LazyPrefixWhileSequence.Iterator {
public mutating func next() -> Element? {}
}
extension LazySequence {
public var underestimatedCount: Int { get }
}
extension LazySequenceProtocol {
public func map<U>(_ transform: @escaping (Element) -> U) -> LazyMapSequence<Elements, U> {}
}
extension LazySequenceProtocol {
public func compactMap<ElementOfResult>(_ transform: @escaping (Elements.Element) -> ElementOfResult?) -> LazyMapSequence<LazyFilterSequence<LazyMapSequence<Elements, ElementOfResult?>>, ElementOfResult> {}
public func flatMap<SegmentOfResult>(_ transform: @escaping (Elements.Element) -> SegmentOfResult) -> LazySequence<FlattenSequence<LazyMapSequence<Elements, SegmentOfResult>>> {}
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
public func ==(lhs: ManagedBufferPointer, rhs: ManagedBufferPointer) -> Bool {}
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
extension MutableCollection {
public mutating func reverse()  where Self : BidirectionalCollection {}
}
extension MutableCollection {
public mutating func partition(by belongsInSecondPartition: (Element) throws -> Bool) rethrows -> Index {}
public mutating func shuffle()  where Self : RandomAccessCollection {}
public mutating func shuffle<T>(using generator: inout T)  where Self : RandomAccessCollection, T : RandomNumberGenerator {}
}
extension MutableCollection {
public mutating func sort()  where Element : Comparable, Self : RandomAccessCollection {}
public mutating func sort(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows  where Self : RandomAccessCollection {}
}
extension MutableCollection {
public subscript(x: UnboundedRange) -> SubSequence { get set } {}
public subscript<R>(r: R) -> SubSequence { get set }  where R : RangeExpression, Index == R.Bound {}
}
extension OpaquePointer {
}
extension OpaquePointer {
public init(_ from: UnsafeMutableRawPointer) {}
}
extension Optional {
public var customMirror: Mirror { get }
public var debugDescription: String { get }
public func !=(lhs: Wrapped?, rhs: _OptionalNilComparisonType) -> Bool {}
public func !=(lhs: _OptionalNilComparisonType, rhs: Wrapped?) -> Bool {}
public func ==(lhs: Wrapped?, rhs: Wrapped?) -> Bool  where Wrapped : Equatable {}
public func ==(lhs: Wrapped?, rhs: _OptionalNilComparisonType) -> Bool {}
public func ==(lhs: _OptionalNilComparisonType, rhs: Wrapped?) -> Bool {}
public func hash(into hasher: inout Hasher)  where Wrapped : Hashable {}
public func ~=(lhs: _OptionalNilComparisonType, rhs: Wrapped?) -> Bool {}
}
extension Optional {
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
public var customMirror: Mirror { get }
public var debugDescription: String { get }
public var description: String { get }
public var endIndex: Index { get }  where Bound : Strideable, Bound.Stride : SignedInteger
public var indices: Indices { get }  where Bound : Strideable, Bound.Stride : SignedInteger
public var startIndex: Index { get }  where Bound : Strideable, Bound.Stride : SignedInteger
public subscript(bounds: Range<Index>) -> Range<Bound> { get }  where Bound : Strideable, Bound.Stride : SignedInteger {}
public subscript(position: Index) -> Element { get }  where Bound : Strideable, Bound.Stride : SignedInteger {}
public func ==(lhs: Range<Bound>, rhs: Range<Bound>) -> Bool {}
public func clamped(to limits: Range) -> Range {}
public func distance(from start: Index, to end: Index) -> Int  where Bound : Strideable, Bound.Stride : SignedInteger {}
public func encode(to encoder: Encoder) throws  where Bound : Encodable {}
public func hash(into hasher: inout Hasher)  where Bound : Hashable {}
public func index(_ i: Index, offsetBy n: Int) -> Index  where Bound : Strideable, Bound.Stride : SignedInteger {}
public func index(after i: Index) -> Index  where Bound : Strideable, Bound.Stride : SignedInteger {}
public func index(before i: Index) -> Index  where Bound : Strideable, Bound.Stride : SignedInteger {}
public func overlaps(_ other: Range<Bound>) -> Bool {}
}
extension Repeated {
public var endIndex: Index { get }
public var startIndex: Index { get }
public subscript(position: Int) -> Element { get } {}
}
extension Result {
public init(catching body: () throws -> Success)  where Failure == Swift.Error {}
}
extension ReversedCollection {
public var endIndex: Index { get }
public var startIndex: Index { get }
public subscript(position: Index) -> Element { get } {}
public func distance(from start: Index, to end: Index) -> Int {}
public func index(_ i: Index, offsetBy n: Int) -> Index {}
public func index(_ i: Index, offsetBy n: Int, limitedBy limit: Index) -> Index? {}
public func index(after i: Index) -> Index {}
public func index(before i: Index) -> Index {}
}
extension ReversedCollection {
}
extension ReversedCollection.Index {
public func <(lhs: ReversedCollection<Base>.Index, rhs: ReversedCollection<Base>.Index) -> Bool {}
public func ==(lhs: ReversedCollection<Base>.Index, rhs: ReversedCollection<Base>.Index) -> Bool {}
public func hash(into hasher: inout Hasher)  where Base.Index : Hashable {}
}
extension ReversedCollection.Iterator {
public mutating func next() -> Element? {}
}
extension Sequence {
public func joined(separator: String = default) -> String  where Element : StringProtocol {}
}
extension Sequence {
public var lazy: LazySequence<Self> { get }
}
extension Sequence {
public func allSatisfy(_ predicate: (Element) throws -> Bool) rethrows -> Bool {}
public func compactMap<ElementOfResult>(_ transform: (Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult] {}
public func contains(_ element: Element) -> Bool  where Element : Equatable {}
public func contains(where predicate: (Element) throws -> Bool) rethrows -> Bool {}
public func count(where predicate: (Element) throws -> Bool) rethrows -> Int {}
public func elementsEqual<OtherSequence>(_ other: OtherSequence) -> Bool  where Element : Equatable, OtherSequence : Sequence, Element == OtherSequence.Element {}
public func elementsEqual<OtherSequence>(_ other: OtherSequence, by areEquivalent: (Element, OtherSequence.Element) throws -> Bool) rethrows -> Bool  where OtherSequence : Sequence {}
public func enumerated() -> EnumeratedSequence<Self> {}
public func flatMap<SegmentOfResult>(_ transform: (Element) throws -> SegmentOfResult) rethrows -> [SegmentOfResult.Element]  where SegmentOfResult : Sequence {}
public func lexicographicallyPrecedes<OtherSequence>(_ other: OtherSequence) -> Bool  where Element : Comparable, OtherSequence : Sequence, Element == OtherSequence.Element {}
public func lexicographicallyPrecedes<OtherSequence>(_ other: OtherSequence, by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Bool  where OtherSequence : Sequence, Element == OtherSequence.Element {}
public func max() -> Element?  where Element : Comparable {}
public func max(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Element? {}
public func min() -> Element?  where Element : Comparable {}
public func min(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Element? {}
public func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (_ partialResult: Result, Element) throws -> Result) rethrows -> Result {}
public func reduce<Result>(into initialResult: __owned Result, _ updateAccumulatingResult: (_ partialResult: inout Result, Element) throws -> Void) rethrows -> Result {}
public func starts<PossiblePrefix>(with possiblePrefix: PossiblePrefix) -> Bool  where Element : Equatable, PossiblePrefix : Sequence, Element == PossiblePrefix.Element {}
public func starts<PossiblePrefix>(with possiblePrefix: PossiblePrefix, by areEquivalent: (Element, PossiblePrefix.Element) throws -> Bool) rethrows -> Bool  where PossiblePrefix : Sequence {}
}
extension Sequence {
public func shuffled() -> [Element] {}
public func shuffled<T>(using generator: inout T) -> [Element]  where T : RandomNumberGenerator {}
}
extension Sequence {
public func sorted() -> [Element]  where Element : Comparable {}
public func sorted(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> [Element] {}
}
extension Set {
public init() {}
public init<Source>(_ sequence: __owned Source)  where Source : Sequence, Element == Source.Element {}
public init(arrayLiteral elements: Element...) {}
public var capacity: Int { get }
public var count: Int { get }
public var customMirror: Mirror { get }
public var debugDescription: String { get }
public var description: String { get }
public var endIndex: Index { get }
public var isEmpty: Bool { get }
public var startIndex: Index { get }
public subscript(position: Index) -> Element { get } {}
public func ==(lhs: Set<Element>, rhs: Set<Element>) -> Bool {}
public func contains(_ member: Element) -> Bool {}
public func firstIndex(of member: Element) -> Index? {}
public func formIndex(after i: inout Index) {}
public mutating func formIntersection<S>(_ other: S)  where S : Sequence, Element == S.Element {}
public mutating func formSymmetricDifference(_ other: __owned Set<Element>) {}
public mutating func formSymmetricDifference<S>(_ other: __owned S)  where S : Sequence, Element == S.Element {}
public mutating func formUnion<S>(_ other: __owned S)  where S : Sequence, Element == S.Element {}
public func hash(into hasher: inout Hasher) {}
public func index(after i: Index) -> Index {}
@discardableResult public mutating func insert(_ newMember: __owned Element) -> (inserted : Bool, memberAfterInsert : Element) {}
public func isDisjoint(with other: Set<Element>) -> Bool {}
public func isDisjoint<S>(with other: S) -> Bool  where S : Sequence, Element == S.Element {}
public func isStrictSubset(of other: Set<Element>) -> Bool {}
public func isStrictSubset<S>(of possibleStrictSuperset: S) -> Bool  where S : Sequence, Element == S.Element {}
public func isStrictSuperset(of other: Set<Element>) -> Bool {}
public func isStrictSuperset<S>(of possibleStrictSubset: S) -> Bool  where S : Sequence, Element == S.Element {}
public func isSubset(of other: Set<Element>) -> Bool {}
public func isSubset<S>(of possibleSuperset: S) -> Bool  where S : Sequence, Element == S.Element {}
public func isSuperset(of other: Set<Element>) -> Bool {}
public func isSuperset<S>(of possibleSubset: __owned S) -> Bool  where S : Sequence, Element == S.Element {}
public mutating func popFirst() -> Element? {}
@discardableResult public mutating func remove(_ member: Element) -> Element? {}
@discardableResult public mutating func remove(at position: Index) -> Element {}
public mutating func removeAll(keepingCapacity keepCapacity: Bool = default) {}
@discardableResult public mutating func removeFirst() -> Element {}
public mutating func reserveCapacity(_ minimumCapacity: Int) {}
public mutating func subtract(_ other: Set<Element>) {}
public mutating func subtract<S>(_ other: S)  where S : Sequence, Element == S.Element {}
@discardableResult public mutating func update(with newMember: __owned Element) -> Element? {}
}
extension Set {
public mutating func insert<ConcreteElement>(_ newMember: __owned ConcreteElement) -> (inserted : Bool, memberAfterInsert : ConcreteElement)  where ConcreteElement : Hashable, AnyHashable == Element {}
@discardableResult public mutating func remove<ConcreteElement>(_ member: ConcreteElement) -> ConcreteElement?  where ConcreteElement : Hashable, AnyHashable == Element {}
@discardableResult public mutating func update<ConcreteElement>(with newMember: __owned ConcreteElement) -> ConcreteElement?  where ConcreteElement : Hashable, AnyHashable == Element {}
}
extension Set.Index {
public func <(lhs: Set<Element>.Index, rhs: Set<Element>.Index) -> Bool {}
public func ==(lhs: Set<Element>.Index, rhs: Set<Element>.Index) -> Bool {}
public func hash(into hasher: inout Hasher) {}
}
extension Set.Iterator {
public var customMirror: Mirror { get }
public mutating func next() -> Element? {}
}
extension Set._Variant {
}
extension Slice {
}
extension Slice {
public init()  where Base : RangeReplaceableCollection {}
public init<S>(_ elements: S)  where Base : RangeReplaceableCollection, S : Sequence, Base.Element == S.Element {}
public init(repeating repeatedValue: Base.Element, count: Int)  where Base : RangeReplaceableCollection {}
public var endIndex: Index { get }
public var indices: Indices { get }
public var startIndex: Index { get }
public subscript(bounds: Range<Index>) -> Slice<Base> { get set }  where Base : MutableCollection {}
public subscript(index: Index) -> Base.Element { get set }  where Base : MutableCollection {}
public func distance(from start: Index, to end: Index) -> Int {}
public func formIndex(after i: inout Index) {}
public func formIndex(before i: inout Index)  where Base : BidirectionalCollection {}
public func index(_ i: Index, offsetBy n: Int) -> Index {}
public func index(_ i: Index, offsetBy n: Int, limitedBy limit: Index) -> Index? {}
public func index(after i: Index) -> Index {}
public func index(before i: Index) -> Index  where Base : BidirectionalCollection {}
public mutating func insert(_ newElement: Base.Element, at i: Index)  where Base : RangeReplaceableCollection {}
public mutating func insert<S>(contentsOf newElements: S, at i: Index)  where Base : RangeReplaceableCollection, S : Collection, Base.Element == S.Element {}
public mutating func remove(at i: Index) -> Base.Element  where Base : RangeReplaceableCollection {}
public mutating func removeSubrange(_ bounds: Range<Index>)  where Base : RangeReplaceableCollection {}
public mutating func replaceSubrange<C>(_ subRange: Range<Index>, with newElements: C)  where Base : RangeReplaceableCollection, C : Collection, Base.Element == C.Element {}
}
extension StrideThrough {
#if false
public var count: Int { get }  where Element.Stride : BinaryInteger
#endif
public var customMirror: Mirror { get }
#if false
public var endIndex: Index { get }  where Element.Stride : BinaryInteger
#endif
#if false
public var startIndex: Index { get }  where Element.Stride : BinaryInteger
#endif
public var underestimatedCount: Int { get }
#if false
public subscript(bounds: Range<Index>) -> Slice<StrideThrough<Element>> { get }  where Element.Stride : BinaryInteger {}
#endif
#if false
public subscript(position: Index) -> Element { get }  where Element.Stride : BinaryInteger {}
#endif
#if false
public func index(after i: Index) -> Index  where Element.Stride : BinaryInteger {}
#endif
#if false
public func index(before i: Index) -> Index  where Element.Stride : BinaryInteger {}
#endif
}
extension StrideThroughIterator {
public mutating func next() -> Element? {}
}
extension StrideTo {
#if false
public var count: Int { get }  where Element.Stride : BinaryInteger
#endif
public var customMirror: Mirror { get }
#if false
public var endIndex: Index { get }  where Element.Stride : BinaryInteger
#endif
#if false
public var startIndex: Index { get }  where Element.Stride : BinaryInteger
#endif
public var underestimatedCount: Int { get }
#if false
public subscript(bounds: Range<Index>) -> Slice<StrideTo<Element>> { get }  where Element.Stride : BinaryInteger {}
#endif
#if false
public subscript(position: Index) -> Element { get }  where Element.Stride : BinaryInteger {}
#endif
#if false
public func index(after i: Index) -> Index  where Element.Stride : BinaryInteger {}
#endif
#if false
public func index(before i: Index) -> Index  where Element.Stride : BinaryInteger {}
#endif
}
extension StrideToIterator {
public mutating func next() -> Element? {}
}
extension Strideable {
public func +(lhs: Self, rhs: Stride) -> Self  where Self : _Pointer {}
public func +=(lhs: inout Self, rhs: Stride)  where Self : _Pointer {}
public func -(lhs: Self, rhs: Self) -> Stride  where Self : _Pointer {}
public func -=(lhs: inout Self, rhs: Stride)  where Self : _Pointer {}
}
extension String {
}
extension String {
public init<Subject>(describing instance: Subject) {}
public init<Subject>(reflecting subject: Subject) {}
}
extension String {
public init(_ content: Substring.UnicodeScalarView) {}
public init(_ substring: __shared Substring) {}
public init?(_ codeUnits: Substring.UTF16View) {}
@available(swift, introduced: 4) public subscript(r: Range<Index>) -> Substring { get } {}
}
extension String {
}
extension String {
public var count: Int { get }
public var endIndex: Index { get }
public var startIndex: Index { get }
public subscript(i: Index) -> Character { get } {}
public func distance(from start: Index, to end: Index) -> IndexDistance {}
public func index(_ i: Index, offsetBy n: IndexDistance) -> Index {}
public func index(_ i: Index, offsetBy n: IndexDistance, limitedBy limit: Index) -> Index? {}
public func index(after i: Index) -> Index {}
public func index(before i: Index) -> Index {}
}
extension String {
@available(swift, introduced: 4.0) public init(_ utf16: UTF16View) {}
public var utf16: UTF16View { get set }
}
extension String {
public func hash(into hasher: inout Hasher) {}
}
extension String {
}
extension String {
public init(_ c: Character) {}
}
extension String {
public static func decodeCString<Encoding>(_ cString: UnsafePointer<Encoding.CodeUnit>?, as encoding: Encoding.Type, repairingInvalidCodeUnits isRepairing: Bool = default) -> (result : String, repairsMade : Bool)?  where Encoding : _UnicodeEncoding {}
public init(cString: UnsafePointer<CChar>) {}
public init(cString: UnsafePointer<UInt8>) {}
public init?(validatingUTF8 cString: UnsafePointer<CChar>) {}
}
extension String {
public init(repeating repeatedValue: Character, count: Int) {}
public mutating func append(_ c: Character) {}
public mutating func append(_ other: String) {}
public mutating func append<S>(contentsOf newElements: S)  where S : Sequence, Character == S.Iterator.Element {}
public mutating func insert(_ newElement: Character, at i: Index) {}
public mutating func insert<S>(contentsOf newElements: S, at i: Index)  where S : Collection, Character == S.Element {}
public func max<T>(_ x: T, _ y: T) -> T  where T : Comparable {}
public func min<T>(_ x: T, _ y: T) -> T  where T : Comparable {}
@discardableResult public mutating func remove(at i: Index) -> Character {}
public mutating func removeAll(keepingCapacity keepCapacity: Bool = default) {}
public mutating func removeSubrange(_ bounds: Range<Index>) {}
public mutating func replaceSubrange<C>(_ bounds: Range<Index>, with newElements: C)  where C : Collection, C.Iterator.Element == Character {}
public mutating func reserveCapacity(_ n: Int) {}
}
extension String {
public static func (lhs: String, rhs: String) -> Bool {}
}
extension String {
public func withCString<Result>(_ body: (UnsafePointer<Int8>) throws -> Result) rethrows -> Result {}
}
extension String {
public init<T>(_ value: T, radix: Int = default, uppercase: Bool = default)  where T : BinaryInteger {}
public init(repeating repeatedValue: String, count: Int) {}
public var isEmpty: Bool { get }
public func hasPrefix(_ prefix: String) -> Bool {}
public func hasSuffix(_ suffix: String) -> Bool {}
}
extension String {
@available(swift, introduced: 4.0, message: "Please use failable String.init?(_:UTF8View) when in Swift 3.2 mode") public init(_ utf8: UTF8View) {}
public var utf8: UTF8View { get set }
public var utf8CString: ContiguousArray<CChar> { get }
}
extension String {
public init(_ unicodeScalars: UnicodeScalarView) {}
public var unicodeScalars: UnicodeScalarView { get set }
}
extension String.Index {
public init?(_ sourcePosition: String.Index, within target: String) {}
public func samePosition(in utf16: String.UTF16View) -> String.UTF16View.Index? {}
public func samePosition(in utf8: String.UTF8View) -> String.UTF8View.Index? {}
}
extension String.Index {
public init(encodedOffset: Int) {}
public var encodedOffset: Int { get }
public func <(lhs: String.Index, rhs: String.Index) -> Bool {}
public func ==(lhs: String.Index, rhs: String.Index) -> Bool {}
public func hash(into hasher: inout Hasher) {}
}
extension String.UTF16View {
}
extension String.UTF16View {
public var count: Int { get }
public var customMirror: Mirror { get }
public var debugDescription: String { get }
public var description: String { get }
public var endIndex: Index { get }
public var startIndex: Index { get }
public subscript(i: Index) -> UTF16.CodeUnit { get } {}
public subscript(r: Range<Index>) -> Substring.UTF16View { get } {}
public func distance(from start: Index, to end: Index) -> Int {}
public func index(_ i: Index, offsetBy n: Int) -> Index {}
public func index(_ i: Index, offsetBy n: Int, limitedBy limit: Index) -> Index? {}
public func index(after i: Index) -> Index {}
public func index(before i: Index) -> Index {}
}
extension String.UTF16View.Index {
public init?(_ idx: String.Index, within target: String.UTF16View) {}
public func samePosition(in unicodeScalars: String.UnicodeScalarView) -> String.UnicodeScalarIndex? {}
}
extension String.UTF8View {
}
extension String.UTF8View {
public var count: Int { get }
public var customMirror: Mirror { get }
public var debugDescription: String { get }
public var description: String { get }
public var endIndex: Index { get }
public var startIndex: Index { get }
@available(swift, introduced: 4) public subscript(r: Range<Index>) -> String.UTF8View.SubSequence { get } {}
public subscript(i: Index) -> UTF8.CodeUnit { get } {}
public func distance(from i: Index, to j: Index) -> Int {}
public func index(_ i: Index, offsetBy n: Int) -> Index {}
public func index(_ i: Index, offsetBy n: Int, limitedBy limit: Index) -> Index? {}
public func index(after i: Index) -> Index {}
public func index(before i: Index) -> Index {}
public func withContiguousStorageIfAvailable<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R? {}
}
extension String.UTF8View.Index {
public init?(_ idx: String.Index, within target: String.UTF8View) {}
}
extension String.UnicodeScalarIndex {
public init?(_ sourcePosition: String.Index, within unicodeScalars: String.UnicodeScalarView) {}
public func samePosition(in characters: String) -> String.Index? {}
}
extension String.UnicodeScalarView {
public init() {}
public var customMirror: Mirror { get }
public var debugDescription: String { get }
public var description: String { get }
public var endIndex: Index { get }
public var startIndex: Index { get }
@available(swift, introduced: 4) public subscript(r: Range<Index>) -> String.UnicodeScalarView.SubSequence { get } {}
public subscript(position: Index) -> Unicode.Scalar { get } {}
public mutating func append(_ c: Unicode.Scalar) {}
public mutating func append<S>(contentsOf newElements: S)  where S : Sequence, S.Element == Unicode.Scalar {}
public func index(after i: Index) -> Index {}
public func index(before i: Index) -> Index {}
public mutating func replaceSubrange<C>(_ bounds: Range<Index>, with newElements: C)  where C : Collection, C.Element == Unicode.Scalar {}
public mutating func reserveCapacity(_ n: Int) {}
}
extension String.UnicodeScalarView {
}
extension StringProtocol {
public static func <RHS>(lhs: Self, rhs: RHS) -> Bool  where RHS : StringProtocol {}
}
extension StringProtocol {
public func hasPrefix<Prefix>(_ prefix: Prefix) -> Bool  where Prefix : StringProtocol {}
public func hasSuffix<Suffix>(_ suffix: Suffix) -> Bool  where Suffix : StringProtocol {}
}
extension StringProtocol {
public func hash(into hasher: inout Hasher) {}
}
extension Substring {
}
extension Substring {
}
extension Substring {
}
extension UInt {
public init<P>(bitPattern pointer: P?)  where P : _Pointer {}
}
extension UInt {
}
extension UInt {
public init(bitPattern pointer: OpaquePointer?) {}
}
extension UInt {
public init(bitPattern objectID: ObjectIdentifier) {}
}
extension UInt16 {
}
extension UInt32 {
public init(_ v: Unicode.Scalar) {}
}
extension UInt32 {
}
extension UInt64 {
}
extension UInt64 {
public init(_ v: Unicode.Scalar) {}
}
extension UInt8 {
public init(ascii v: Unicode.Scalar) {}
}
extension UInt8 {
}
extension UTF16 {
public static func isLeadSurrogate(_ x: CodeUnit) -> Bool {}
public static func isTrailSurrogate(_ x: CodeUnit) -> Bool {}
public static func leadSurrogate(_ x: Unicode.Scalar) -> UTF16.CodeUnit {}
public static func trailSurrogate(_ x: Unicode.Scalar) -> UTF16.CodeUnit {}
public static func transcodedLength<Input, Encoding>(of input: Input, decodedAs sourceEncoding: Encoding.Type, repairingIllFormedSequences: Bool) -> (count : Int, isASCII : Bool)?  where Encoding : Unicode.Encoding, Input : IteratorProtocol, Encoding.CodeUnit == Input.Element {}
public static func width(_ x: Unicode.Scalar) -> Int {}
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
extension Unicode {
}
extension Unicode {
}
extension Unicode {
}
extension Unicode {
}
extension Unicode {
}
extension Unicode {
}
extension Unicode {
}
extension Unicode {
}
extension Unicode.ASCII {
public static var encodedReplacementCharacter: EncodedScalar { get }
public static func decode(_ source: EncodedScalar) -> Unicode.Scalar {}
public static func encode(_ source: Unicode.Scalar) -> EncodedScalar? {}
public static func transcode<FromEncoding>(_ content: FromEncoding.EncodedScalar, from _: FromEncoding.Type) -> EncodedScalar?  where FromEncoding : Unicode.Encoding {}
}
extension Unicode.ASCII.Parser {
public mutating func parseScalar<I>(from input: inout I) -> Unicode.ParseResult<Encoding.EncodedScalar>  where I : IteratorProtocol, Encoding.CodeUnit == I.Element {}
}
extension Unicode.Scalar {
}
extension Unicode.Scalar {
public init(_ v: UInt8) {}
public init(_ v: Unicode.Scalar) {}
public init?(_ v: Int) {}
public init?(_ v: UInt16) {}
public init?(_ v: UInt32) {}
public init(unicodeScalarLiteral value: Unicode.Scalar) {}
public var debugDescription: String { get }
public var description: String { get }
public var isASCII: Bool { get }
public var utf16: UTF16View { get }
public var value: UInt32 { get }
public func <(lhs: Unicode.Scalar, rhs: Unicode.Scalar) -> Bool {}
public func ==(lhs: Unicode.Scalar, rhs: Unicode.Scalar) -> Bool {}
public func escaped(asASCII forceASCII: Bool) -> String {}
public func hash(into hasher: inout Hasher) {}
}
extension Unicode.Scalar {
public var properties: Properties { get }
}
extension Unicode.Scalar.Properties {
public var age: Unicode.Version? { get }
public var canonicalCombiningClass: Unicode.CanonicalCombiningClass { get }
public var changesWhenCaseFolded: Bool { get }
public var changesWhenCaseMapped: Bool { get }
public var changesWhenLowercased: Bool { get }
public var changesWhenNFKCCaseFolded: Bool { get }
public var changesWhenTitlecased: Bool { get }
public var changesWhenUppercased: Bool { get }
public var generalCategory: Unicode.GeneralCategory { get }
public var isASCIIHexDigit: Bool { get }
public var isAlphabetic: Bool { get }
public var isBidiControl: Bool { get }
public var isBidiMirrored: Bool { get }
public var isCaseIgnorable: Bool { get }
public var isCased: Bool { get }
public var isDash: Bool { get }
public var isDefaultIgnorableCodePoint: Bool { get }
public var isDeprecated: Bool { get }
public var isDiacritic: Bool { get }
#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
@available(macOS10.12.2, iOS10.2, tvOS10.1, watchOS3.1.1, *) public var isEmoji: Bool { get }
#endif
#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
@available(macOS10.12.2, iOS10.2, tvOS10.1, watchOS3.1.1, *) public var isEmojiModifier: Bool { get }
#endif
#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
@available(macOS10.12.2, iOS10.2, tvOS10.1, watchOS3.1.1, *) public var isEmojiModifierBase: Bool { get }
#endif
#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
@available(macOS10.12.2, iOS10.2, tvOS10.1, watchOS3.1.1, *) public var isEmojiPresentation: Bool { get }
#endif
public var isExtender: Bool { get }
public var isFullCompositionExclusion: Bool { get }
public var isGraphemeBase: Bool { get }
public var isGraphemeExtend: Bool { get }
public var isHexDigit: Bool { get }
public var isIDContinue: Bool { get }
public var isIDSBinaryOperator: Bool { get }
public var isIDSTrinaryOperator: Bool { get }
public var isIDStart: Bool { get }
public var isIdeographic: Bool { get }
public var isJoinControl: Bool { get }
public var isLogicalOrderException: Bool { get }
public var isLowercase: Bool { get }
public var isMath: Bool { get }
public var isNoncharacterCodePoint: Bool { get }
public var isPatternSyntax: Bool { get }
public var isPatternWhitespace: Bool { get }
public var isQuotationMark: Bool { get }
public var isRadical: Bool { get }
public var isSentenceTerminal: Bool { get }
public var isSoftDotted: Bool { get }
public var isTerminalPunctuation: Bool { get }
public var isUnifiedIdeograph: Bool { get }
public var isUppercase: Bool { get }
public var isVariationSelector: Bool { get }
public var isWhitespace: Bool { get }
public var isXIDContinue: Bool { get }
public var isXIDStart: Bool { get }
public var lowercaseMapping: String { get }
public var name: String? { get }
public var nameAlias: String? { get }
public var numericType: Unicode.NumericType? { get }
public var numericValue: Double? { get }
public var titlecaseMapping: String { get }
public var uppercaseMapping: String { get }
}
extension Unicode.Scalar.UTF16View {
public var endIndex: Int { get }
public var startIndex: Int { get }
public subscript(position: Int) -> UTF16.CodeUnit { get } {}
}
extension Unicode.UTF16 {
public static var encodedReplacementCharacter: EncodedScalar { get }
public static func decode(_ source: EncodedScalar) -> Unicode.Scalar {}
public static func encode(_ source: Unicode.Scalar) -> EncodedScalar? {}
public static func transcode<FromEncoding>(_ content: FromEncoding.EncodedScalar, from _: FromEncoding.Type) -> EncodedScalar?  where FromEncoding : Unicode.Encoding {}
}
extension Unicode.UTF16 {
}
extension Unicode.UTF16.ForwardParser {
}
extension Unicode.UTF32 {
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
public static func transcode<FromEncoding>(_ content: FromEncoding.EncodedScalar, from _: FromEncoding.Type) -> EncodedScalar?  where FromEncoding : _UnicodeEncoding {}
}
extension Unicode.UTF8 {
public static func isContinuation(_ byte: CodeUnit) -> Bool {}
}
extension Unicode.UTF8.ForwardParser {
}
extension UnsafeBufferPointer {
}
extension UnsafeMutableBufferPointer {
}
extension UnsafeMutablePointer {
}
extension UnsafeMutablePointer {
}
extension UnsafeMutableRawBufferPointer {
}
extension UnsafeMutableRawPointer {
}
extension UnsafeMutableRawPointer {
#if _runtime(_ObjC)
public init<T>(_ other: AutoreleasingUnsafeMutablePointer<T>) {}
#endif
#if _runtime(_ObjC)
public init?<T>(_ other: AutoreleasingUnsafeMutablePointer<T>?) {}
#endif
}
extension UnsafePointer {
}
extension UnsafePointer {
}
extension UnsafeRawBufferPointer {
}
extension UnsafeRawPointer {
}
extension UnsafeRawPointer {
#if _runtime(_ObjC)
public init<T>(_ other: AutoreleasingUnsafeMutablePointer<T>) {}
#endif
#if _runtime(_ObjC)
public init?<T>(_ other: AutoreleasingUnsafeMutablePointer<T>?) {}
#endif
}
extension Zip2Sequence {
public var underestimatedCount: Int { get }
}
extension Zip2Sequence.Iterator {
public mutating func next() -> Element? {}
}
extension _AppendKeyPath {
public func appending(path: AnyKeyPath) -> AnyKeyPath?  where AnyKeyPath == Self {}
public func appending<Root, AppendedRoot, AppendedValue>(path: KeyPath<AppendedRoot, AppendedValue>) -> KeyPath<Root, AppendedValue>?  where PartialKeyPath<Root> == Self {}
public func appending<Root, AppendedRoot, AppendedValue>(path: ReferenceWritableKeyPath<AppendedRoot, AppendedValue>) -> ReferenceWritableKeyPath<Root, AppendedValue>?  where PartialKeyPath<Root> == Self {}
public func appending<Root, Value, AppendedValue>(path: KeyPath<Value, AppendedValue>) -> KeyPath<Root, AppendedValue>  where Self : KeyPath<Root, Value> {}
public func appending<Root, Value, AppendedValue>(path: ReferenceWritableKeyPath<Value, AppendedValue>) -> ReferenceWritableKeyPath<Root, AppendedValue>  where KeyPath<Root, Value> == Self {}
public func appending<Root>(path: AnyKeyPath) -> PartialKeyPath<Root>?  where PartialKeyPath<Root> == Self {}
}
extension _ContiguousArrayBuffer {
}
extension _HashTable {
}
extension _HashTable.Bucket {
}
extension _HashTable.Index {
}
extension _NativeDictionary {
}
extension _NativeDictionary.Iterator {
}
extension _NativeSet {
}
extension _NativeSet.Iterator {
}
extension _Pointer {
public init(_ from: OpaquePointer) {}
public init(_ other: Self) {}
public init<T>(_ other: UnsafeMutablePointer<T>) {}
public init?(_ from: OpaquePointer?) {}
public init?(_ other: Self?) {}
public init?<T>(_ other: UnsafeMutablePointer<T>?) {}
public init?(bitPattern: Int) {}
public var customMirror: Mirror { get }
public var debugDescription: String { get }
public func <(lhs: Self, rhs: Self) -> Bool {}
public func ==(lhs: Self, rhs: Self) -> Bool {}
public func advanced(by n: Int) -> Self {}
public func distance(to end: Self) -> Int {}
public func hash(into hasher: inout Hasher) {}
public func predecessor() -> Self {}
public func successor() -> Self {}
}
extension _RuntimeFunctionCounters {
#if SWIFT_ENABLE_RUNTIME_FUNCTION_COUNTERS
public static func disableRuntimeFunctionCountersUpdates() -> (globalMode : Bool, perObjectMode : Bool) {}
#endif
#if SWIFT_ENABLE_RUNTIME_FUNCTION_COUNTERS
public static func enableRuntimeFunctionCountersUpdates(mode: (globalMode : Bool, perObjectMode : Bool) = default) {}
#endif
#if SWIFT_ENABLE_RUNTIME_FUNCTION_COUNTERS
@discardableResult public static func setGlobalRuntimeFunctionCountersMode(enable: Bool) -> Bool {}
#endif
#if SWIFT_ENABLE_RUNTIME_FUNCTION_COUNTERS
@discardableResult public static func setPerObjectRuntimeFunctionCountersMode(enable: Bool) -> Bool {}
#endif
}
extension _RuntimeFunctionCountersStats {
#if SWIFT_ENABLE_RUNTIME_FUNCTION_COUNTERS
public var debugDescription: String { get }
#endif
#if SWIFT_ENABLE_RUNTIME_FUNCTION_COUNTERS
public func diff(_ other: Self) -> Self {}
#endif
#if SWIFT_ENABLE_RUNTIME_FUNCTION_COUNTERS
public func dump(skipUnchanged: Bool) {}
#endif
#if SWIFT_ENABLE_RUNTIME_FUNCTION_COUNTERS
public func dump<T>(skipUnchanged: Bool, to: inout T)  where T : TextOutputStream {}
#endif
#if SWIFT_ENABLE_RUNTIME_FUNCTION_COUNTERS
public func dumpDiff(_ after: Self, skipUnchanged: Bool) {}
#endif
#if SWIFT_ENABLE_RUNTIME_FUNCTION_COUNTERS
public func dumpDiff<T>(_ after: Self, skipUnchanged: Bool, to: inout T)  where T : TextOutputStream {}
#endif
}
extension _SmallString {
}
extension _SwiftNewtypeWrapper {
public var hashValue: Int { get }  where RawValue : Hashable, Self : Hashable
public func hash(into hasher: inout Hasher)  where RawValue : Hashable, Self : Hashable {}
}
extension _UIntBuffer {
public init() {}
public var capacity: Int { get }
public var endIndex: Index { get }
public var startIndex: Index { get }
public subscript(i: Index) -> Element { get } {}
public mutating func append(_ newElement: Element) {}
public func distance(from i: Index, to j: Index) -> Int {}
public func index(_ i: Index, offsetBy n: Int) -> Index {}
public func index(after i: Index) -> Index {}
public func index(before i: Index) -> Index {}
public func makeIterator() -> Iterator {}
@discardableResult public mutating func removeFirst() -> Element {}
public mutating func replaceSubrange<C>(_ target: Range<Index>, with replacement: C)  where C : Collection, C.Element == Element {}
}
extension _UTFParser {
public mutating func parseScalar<I>(from input: inout I) -> Unicode.ParseResult<Encoding.EncodedScalar>  where Encoding.EncodedScalar : RangeReplaceableCollection, I : IteratorProtocol, Encoding.CodeUnit == I.Element {}
}
extension _UnicodeEncoding {
public static func transcode<FromEncoding>(_ content: FromEncoding.EncodedScalar, from _: FromEncoding.Type) -> EncodedScalar?  where FromEncoding : Unicode.Encoding {}
}
extension _UnsafeBitset {
}
extension _UnsafeBitset.Word {
}
extension _ValidUTF8Buffer {
public static var capacity: Int { get }
public static var encodedReplacementCharacter: _ValidUTF8Buffer { get }
public init() {}
public var capacity: Int { get }
public var count: Int { get }
public var endIndex: Index { get }
public var isEmpty: Bool { get }
public var startIndex: Index { get }
public subscript(i: Index) -> Element { get } {}
public mutating func append(_ e: Element) {}
public mutating func append(contentsOf other: _ValidUTF8Buffer) {}
public func distance(from i: Index, to j: Index) -> Int {}
public func index(_ i: Index, offsetBy n: Int) -> Index {}
public func index(after i: Index) -> Index {}
public func index(before i: Index) -> Index {}
public func makeIterator() -> Iterator {}
@discardableResult public mutating func removeFirst() -> Element {}
public mutating func replaceSubrange<C>(_ target: Range<Index>, with replacement: C)  where C : Collection, C.Element == Element {}
}
extension __CocoaDictionary {
}
extension __CocoaDictionary.Index {
}
extension __CocoaDictionary.Iterator {
}
extension __CocoaSet {
}
extension __CocoaSet.Index {
}
extension __CocoaSet.Iterator {
}
extension __EmptyDictionarySingleton {
}
extension __EmptySetSingleton {
}
extension __SwiftNativeNSArrayWithContiguousStorage {
}
