open class BlockOperation {
public init(block: @escaping () -> Void) {}
open var executionBlocks: [() -> Void] { get }
open func addExecutionBlock(_ block: @escaping () -> Void) {}
}
open class Bundle {
open class var allBundles: [Bundle] { get }
open class var main: Bundle { get }
open class func path(forResource name: String?, ofType ext: String?, inDirectory bundlePath: String) -> String? {}
open class func paths(forResourcesOfType ext: String?, inDirectory bundlePath: String) -> [String] {}
open class func preferredLocalizations(from localizationsArray: [String]) -> [String] {}
open class func preferredLocalizations(from localizationsArray: [String], forPreferences preferencesArray: [String]?) -> [String] {}
open class func url(forResource name: String?, withExtension ext: String?, subdirectory subpath: String?, in bundleURL: URL) -> URL? {}
open class func urls(forResourcesWithExtension ext: String?, subdirectory subpath: String?, in bundleURL: NSURL) -> [NSURL]? {}
public init(for aClass: AnyClass) {}
public init?(identifier: String) {}
public init?(path: String) {}
public convenience init?(url: URL) {}
open var appStoreReceiptURL: URL? { get }
open var builtInPlugInsPath: String? { get }
open var builtInPlugInsURL: URL? { get }
open var bundleIdentifier: String? { get }
open var bundlePath: String { get }
open var bundleURL: URL { get }
open var developmentLocalization: String? { get }
open var executableArchitectures: [NSNumber]? { get }
open var executablePath: String? { get }
open var executableURL: URL? { get }
open var infoDictionary: [String: Any]? { get }
open var isLoaded: Bool { get }
open var localizations: [String] { get }
open var localizedInfoDictionary: [String: Any]? { get }
open var preferredLocalizations: [String] { get }
open var principalClass: AnyClass? { get }
open var privateFrameworksPath: String? { get }
open var privateFrameworksURL: URL? { get }
open var resourcePath: String? { get }
open var resourceURL: URL? { get }
open var sharedFrameworksPath: String? { get }
open var sharedFrameworksURL: URL? { get }
open var sharedSupportPath: String? { get }
open var sharedSupportURL: URL? { get }
open func classNamed(_ className: String) -> AnyClass? {}
open func load() -> Bool {}
open func loadAndReturnError() throws {}
open func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {}
open func object(forInfoDictionaryKey key: String) -> Any? {}
open func path(forAuxiliaryExecutable executableName: String) -> String? {}
open func path(forResource name: String?, ofType ext: String?) -> String? {}
open func path(forResource name: String?, ofType ext: String?, inDirectory subpath: String?) -> String? {}
open func path(forResource name: String?, ofType ext: String?, inDirectory subpath: String?, forLocalization localizationName: String?) -> String? {}
open func paths(forResourcesOfType ext: String?, inDirectory subpath: String?) -> [String] {}
open func paths(forResourcesOfType ext: String?, inDirectory subpath: String?, forLocalization localizationName: String?) -> [String] {}
open func preflight() throws {}
open func url(forAuxiliaryExecutable executableName: String) -> URL? {}
open func url(forResource name: String?, withExtension ext: String?) -> URL? {}
open func url(forResource name: String?, withExtension ext: String?, subdirectory subpath: String?) -> URL? {}
open func url(forResource name: String?, withExtension ext: String?, subdirectory subpath: String?, localization localizationName: String?) -> URL? {}
open func urls(forResourcesWithExtension ext: String?, subdirectory subpath: String?) -> [NSURL]? {}
open func urls(forResourcesWithExtension ext: String?, subdirectory subpath: String?, localization localizationName: String?) -> [NSURL]? {}
}
open class ByteCountFormatter {
open class func string(fromByteCount byteCount: Int64, countStyle: ByteCountFormatter.CountStyle) -> String {}
open var allowedUnits: Units { get set }
open var allowsNonnumericFormatting: Bool { get set }
open var countStyle: CountStyle { get set }
open var formattingContext: Context { get set }
open var includesActualByteCount: Bool { get set }
open var includesCount: Bool { get set }
open var includesUnit: Bool { get set }
open var isAdaptive: Bool { get set }
open var zeroPadsFractionDigits: Bool { get set }
open func string(fromByteCount byteCount: Int64) -> String {}
}
open class CachedURLResponse {
public init(response: URLResponse, data: Data) {}
public init(response: URLResponse, data: Data, userInfo: [AnyHashable: Any]? = x, storagePolicy: URLCache.StoragePolicy) {}
open var data: Data { get }
open var response: URLResponse { get }
open var storagePolicy: URLCache.StoragePolicy { get }
open var userInfo: [AnyHashable: Any]? { get }
}
open class DateComponentsFormatter {
open class func localizedString(from components: DateComponents, unitsStyle: UnitsStyle) -> String? {}
open var allowedUnits: NSCalendar.Unit { get set }
open var allowsFractionalUnits: Bool { get set }
open var calendar: Calendar? { get set }
open var collapsesLargestUnit: Bool { get set }
open var formattingContext: Context { get set }
open var includesApproximationPhrase: Bool { get set }
open var includesTimeRemainingPhrase: Bool { get set }
open var maximumUnitCount: Int { get set }
open var unitsStyle: UnitsStyle { get set }
open var zeroFormattingBehavior: ZeroFormattingBehavior { get set }
open func string(from components: DateComponents) -> String? {}
open func string(from startDate: Date, to endDate: Date) -> String? {}
}
open class DateFormatter {
open class func dateFormat(fromTemplate tmplate: String, options opts: Int, locale: Locale?) -> String? {}
open class func localizedString(from date: Date, dateStyle dstyle: Style, timeStyle tstyle: Style) -> String {}
open var amSymbol: String! { get set }
open var calendar: Calendar! { get set }
open var dateFormat: String! { get set }
open var dateStyle: Style { get set }
open var defaultDate: Date? { get }
open var doesRelativeDateFormatting { get }
open var eraSymbols: [String]! { get set }
open var formattingContext: Context { get set }
open var generatesCalendarDates { get }
open var gregorianStartDate: Date? { get set }
open var isLenient { get }
open var locale: Locale! { get set }
open var longEraSymbols: [String]! { get set }
open var monthSymbols: [String]! { get set }
open var pmSymbol: String! { get set }
open var quarterSymbols: [String]! { get set }
open var shortMonthSymbols: [String]! { get set }
open var shortQuarterSymbols: [String]! { get set }
open var shortStandaloneMonthSymbols: [String]! { get set }
open var shortStandaloneQuarterSymbols: [String]! { get set }
open var shortStandaloneWeekdaySymbols: [String]! { get set }
open var shortWeekdaySymbols: [String]! { get set }
open var standaloneMonthSymbols: [String]! { get set }
open var standaloneQuarterSymbols: [String]! { get set }
open var standaloneWeekdaySymbols: [String]! { get set }
open var timeStyle: Style { get set }
open var timeZone: TimeZone! { get set }
open var twoDigitStartDate: Date? { get set }
open var veryShortMonthSymbols: [String]! { get set }
open var veryShortStandaloneMonthSymbols: [String]! { get set }
open var veryShortStandaloneWeekdaySymbols: [String]! { get set }
open var veryShortWeekdaySymbols: [String]! { get set }
open var weekdaySymbols: [String]! { get set }
open func date(from string: String) -> Date? {}
open func objectValue(_ string: String, range rangep: UnsafeMutablePointer<NSRange>) throws -> AnyObject? {}
open func setLocalizedDateFormatFromTemplate(_ dateFormatTemplate: String) {}
open func string(from date: Date) -> String {}
}
open class DateIntervalFormatter {
open var calendar: Calendar! { get set }
open var dateStyle: Style { get set }
open var dateTemplate: String! { get set }
open var locale: Locale! { get set }
open var timeStyle: Style { get set }
open var timeZone: TimeZone! { get set }
open func string(from dateInterval: DateInterval) -> String? {}
open func string(from fromDate: Date, to toDate: Date) -> String {}
}
open class Dimension {
open class func baseUnit() -> Self {}
public required init(symbol: String, converter: UnitConverter) {}
open var converter: UnitConverter { get }
}
open class EnergyFormatter {
open var isForFoodEnergyUse: Bool { get set }
open var numberFormatter: NumberFormatter! { get set }
open var unitStyle: UnitStyle { get set }
open func string(fromJoules numberInJoules: Double) -> String {}
open func string(fromValue value: Double, unit: Unit) -> String {}
open func unitString(fromJoules numberInJoules: Double, usedUnit unitp: UnsafeMutablePointer<Unit>?) -> String {}
open func unitString(fromValue value: Double, unit: Unit) -> String {}
}
open class FileHandle {
open class var nullDevice: FileHandle { get }
public static var readCompletionNotification { get }
open class var standardError: FileHandle { get }
open class var standardInput: FileHandle { get }
open class var standardOutput: FileHandle { get }
public convenience init(fileDescriptor fd: Int32) {}
public init(fileDescriptor fd: Int32, closeOnDealloc closeopt: Bool) {}
public convenience init?(forReadingAtPath path: String) {}
public convenience init(forReadingFrom url: URL) throws {}
public convenience init(forUpdating url: URL) throws {}
public convenience init?(forUpdatingAtPath path: String) {}
public convenience init?(forWritingAtPath path: String) {}
public convenience init(forWritingTo url: URL) throws {}
open var availableData: Data { get }
open var fileDescriptor: Int32 { get }
open var offsetInFile: UInt64 { get }
open var readabilityHandler: ((FileHandle) -> Void)? { get set }
open var writeabilityHandler: ((FileHandle) -> Void)? { get set }
open func acceptConnectionInBackgroundAndNotify() {}
open func acceptConnectionInBackgroundAndNotify(forModes modes: [RunLoopMode]?) {}
open func closeFile() {}
open func readData(ofLength length: Int) -> Data {}
open func readDataToEndOfFile() -> Data {}
open func readInBackgroundAndNotify() {}
open func readInBackgroundAndNotify(forModes modes: [RunLoopMode]?) {}
open func readToEndOfFileInBackgroundAndNotify() {}
open func readToEndOfFileInBackgroundAndNotify(forModes modes: [RunLoopMode]?) {}
open func seek(toFileOffset offset: UInt64) {}
@discardableResult open func seekToEndOfFile() -> UInt64 {}
open func synchronizeFile() {}
open func truncateFile(atOffset offset: UInt64) {}
open func waitForDataInBackgroundAndNotify() {}
open func waitForDataInBackgroundAndNotify(forModes modes: [RunLoopMode]?) {}
open func write(_ data: Data) {}
}
open class FileManager {
open class DirectoryEnumerator {
open var directoryAttributes: [FileAttributeKey: Any]? { get }
open var fileAttributes: [FileAttributeKey: Any]? { get }
open var level: Int { get }
open func skipDescendants() {}
}
open class var default: FileManager { get }
open var currentDirectoryPath: String { get }
open weak var delegate: FileManagerDelegate? { get set }
open var homeDirectoryForCurrentUser: URL { get }
open var temporaryDirectory: URL { get }
#if !(os(Android))
open func attributesOfFileSystem(forPath path: String) throws -> [FileAttributeKey: Any] {}
#endif
open func attributesOfItem(atPath path: String) throws -> [FileAttributeKey: Any] {}
@discardableResult open func changeCurrentDirectoryPath(_ path: String) -> Bool {}
open func componentsToDisplay(forPath path: String) -> [String]? {}
open func contents(atPath path: String) -> Data? {}
open func contentsEqual(atPath path1: String, andPath path2: String) -> Bool {}
open func contentsOfDirectory(at url: URL, includingPropertiesForKeys keys: [URLResourceKey]?, options mask: DirectoryEnumerationOptions = x) throws -> [URL] {}
open func contentsOfDirectory(atPath path: String) throws -> [String] {}
open func copyItem(at srcURL: URL, to dstURL: URL) throws {}
open func copyItem(atPath srcPath: String, toPath dstPath: String) throws {}
open func createDirectory(at url: URL, withIntermediateDirectories createIntermediates: Bool, attributes: [FileAttributeKey: Any]? = x) throws {}
open func createDirectory(atPath path: String, withIntermediateDirectories createIntermediates: Bool, attributes: [FileAttributeKey: Any]? = x) throws {}
@discardableResult open func createFile(atPath path: String, contents data: Data?, attributes attr: [FileAttributeKey: Any]? = x) -> Bool {}
open func createSymbolicLink(at url: URL, withDestinationURL destURL: URL) throws {}
open func createSymbolicLink(atPath path: String, withDestinationPath destPath: String) throws {}
open func destinationOfSymbolicLink(atPath path: String) throws -> String {}
open func displayName(atPath path: String) -> String {}
open func enumerator(at url: URL, includingPropertiesForKeys keys: [URLResourceKey]?, options mask: DirectoryEnumerationOptions = x, errorHandler handler: ((URL, Error) -> Bool)? = x) -> DirectoryEnumerator? {}
open func enumerator(atPath path: String) -> DirectoryEnumerator? {}
open func fileExists(atPath path: String) -> Bool {}
open func fileExists(atPath path: String, isDirectory: UnsafeMutablePointer<ObjCBool>?) -> Bool {}
open func fileSystemRepresentation(withPath path: String) -> UnsafePointer<Int8> {}
open func getRelationship(_ outRelationship: UnsafeMutablePointer<URLRelationship>, of directory: SearchPathDirectory, in domainMask: SearchPathDomainMask, toItemAt url: URL) throws {}
open func getRelationship(_ outRelationship: UnsafeMutablePointer<URLRelationship>, ofDirectoryAt directoryURL: URL, toItemAt otherURL: URL) throws {}
open func homeDirectory(forUser userName: String) -> URL? {}
open func isDeletableFile(atPath path: String) -> Bool {}
open func isExecutableFile(atPath path: String) -> Bool {}
open func isReadableFile(atPath path: String) -> Bool {}
open func isWritableFile(atPath path: String) -> Bool {}
open func linkItem(at srcURL: URL, to dstURL: URL) throws {}
open func linkItem(atPath srcPath: String, toPath dstPath: String) throws {}
open func mountedVolumeURLs(includingResourceValuesForKeys propertyKeys: [URLResourceKey]?, options: VolumeEnumerationOptions = x) -> [URL]? {}
open func moveItem(at srcURL: URL, to dstURL: URL) throws {}
open func moveItem(atPath srcPath: String, toPath dstPath: String) throws {}
open func removeItem(at url: URL) throws {}
open func removeItem(atPath path: String) throws {}
open func replaceItem(at originalItemURL: URL, withItemAt newItemURL: URL, backupItemName: String?, options: ItemReplacementOptions = x) throws {}
public func replaceItemAt(_ originalItemURL: URL, withItemAt newItemURL: URL, backupItemName: String? = x, options: ItemReplacementOptions = x) throws -> NSURL? {}
open func setAttributes(_ attributes: [FileAttributeKey: Any], ofItemAtPath path: String) throws {}
open func string(withFileSystemRepresentation str: UnsafePointer<Int8>, length len: Int) -> String {}
open func subpaths(atPath path: String) -> [String]? {}
open func subpathsOfDirectory(atPath path: String) throws -> [String] {}
open func url(for directory: SearchPathDirectory, in domain: SearchPathDomainMask, appropriateFor url: URL?, create shouldCreate: Bool) throws -> URL {}
#if !(os(Windows) )
open func urls(for directory: SearchPathDirectory, in domainMask: SearchPathDomainMask) -> [URL] {}
#endif
}
open class Formatter {
open func editingString(for obj: Any) -> String? {}
open func objectValue(_ string: String) throws -> Any? {}
open func string(for obj: Any) -> String? {}
}
open class HTTPCookie {
open class func cookies(withResponseHeaderFields headerFields: [String: String], for URL: URL) -> [HTTPCookie] {}
open class func requestHeaderFields(with cookies: [HTTPCookie]) -> [String: String] {}
public init?(properties: [HTTPCookiePropertyKey: Any]) {}
open var comment: String? { get }
open var commentURL: URL? { get }
open var domain: String { get }
open var expiresDate: Date? { get }
open var isHTTPOnly: Bool { get }
open var isSecure: Bool { get }
open var isSessionOnly: Bool { get }
open var name: String { get }
open var path: String { get }
open var portList: [NSNumber]? { get }
open var properties: [HTTPCookiePropertyKey: Any]? { get }
open var value: String { get }
open var version: Int { get }
}
open class HTTPCookieStorage {
open class var shared: HTTPCookieStorage { get }
open class func sharedCookieStorage(forGroupContainerIdentifier identifier: String) -> HTTPCookieStorage {}
open var cookieAcceptPolicy: HTTPCookie.AcceptPolicy { get set }
open var cookies: [HTTPCookie]? { get }
open func cookies(for url: URL) -> [HTTPCookie]? {}
open func deleteCookie(_ cookie: HTTPCookie) {}
open func removeCookies(since date: Date) {}
open func setCookie(_ cookie: HTTPCookie) {}
open func setCookies(_ cookies: [HTTPCookie], for url: URL?, mainDocumentURL: URL?) {}
open func sortedCookies(using sortOrder: [NSSortDescriptor]) -> [HTTPCookie] {}
}
open class HTTPURLResponse {
open class func localizedString(forStatusCode statusCode: Int) -> String {}
public init?(url: URL, statusCode: Int, httpVersion: String?, headerFields: [String: String]?) {}
public var allHeaderFields: [AnyHashable: Any] { get }
public var statusCode: Int { get }
}
open class Host {
open class func current() -> Host {}
public convenience init(address: String) {}
public convenience init(name: String?) {}
open var address: String? { get }
open var addresses: [String] { get }
open var localizedName: String? { get }
open var name: String? { get }
open var names: [String] { get }
open func isEqual(to aHost: Host) -> Bool {}
}
open class ISO8601DateFormatter {
open class func string(from date: Date, timeZone: TimeZone, formatOptions: ISO8601DateFormatter.Options = x) -> String {}
open var formatOptions: ISO8601DateFormatter.Options { get }
open var timeZone: TimeZone! { get }
open func date(from string: String) -> Date? {}
open func string(from date: Date) -> String {}
}
open class InputStream {
public init(data: Data) {}
public convenience init?(fileAtPath path: String) {}
public init?(url: URL) {}
open var hasBytesAvailable: Bool { get }
open func getBuffer(_ buffer: UnsafeMutablePointer<UnsafeMutablePointer<UInt8>?>, length len: UnsafeMutablePointer<Int>) -> Bool {}
open func read(_ buffer: UnsafeMutablePointer<UInt8>, maxLength len: Int) -> Int {}
}
open class JSONDecoder {
public init() {}
open var dataDecodingStrategy: DataDecodingStrategy { get set }
open var dateDecodingStrategy: DateDecodingStrategy { get set }
open var keyDecodingStrategy: KeyDecodingStrategy { get set }
open var nonConformingFloatDecodingStrategy: NonConformingFloatDecodingStrategy { get set }
open var userInfo: [CodingUserInfoKey: Any] { get set }
open func decode<T>(_ type: T.Type, from data: Data) throws -> T  where T : Decodable {}
}
open class JSONEncoder {
public init() {}
open var dataEncodingStrategy: DataEncodingStrategy { get set }
open var dateEncodingStrategy: DateEncodingStrategy { get set }
open var keyEncodingStrategy: KeyEncodingStrategy { get set }
open var nonConformingFloatEncodingStrategy: NonConformingFloatEncodingStrategy { get set }
open var outputFormatting: OutputFormatting { get set }
open var userInfo: [CodingUserInfoKey: Any] { get set }
open func encode<T>(_ value: T) throws -> Data  where T : Encodable {}
}
open class JSONSerialization {
open class func data(withJSONObject value: Any, options opt: WritingOptions = x) throws -> Data {}
open class func isValidJSONObject(_ obj: Any) -> Bool {}
open class func jsonObject(with data: Data, options opt: ReadingOptions = x) throws -> Any {}
open class func writeJSONObject(_ obj: Any, toStream stream: OutputStream, options opt: WritingOptions) throws -> Int {}
}
open class LengthFormatter {
open var isForPersonHeightUse: Bool { get set }
open var numberFormatter: NumberFormatter! { get set }
open var unitStyle: UnitStyle { get set }
open func string(fromMeters numberInMeters: Double) -> String {}
open func string(fromValue value: Double, unit: LengthFormatter.Unit) -> String {}
open func unitString(fromMeters numberInMeters: Double, usedUnit unitp: UnsafeMutablePointer<Unit>?) -> String {}
open func unitString(fromValue value: Double, unit: Unit) -> String {}
}
open class MassFormatter {
open var isForPersonMassUse: Bool { get set }
open var numberFormatter: NumberFormatter! { get set }
open var unitStyle: UnitStyle { get set }
open func string(fromKilograms numberInKilograms: Double) -> String {}
open func string(fromValue value: Double, unit: Unit) -> String {}
open func unitString(fromKilograms numberInKilograms: Double, usedUnit unitp: UnsafeMutablePointer<Unit>?) -> String {}
open func unitString(fromValue value: Double, unit: Unit) -> String {}
open func unitStringDisplayedAdjacent(toValue value: Double, unit: Unit) -> String {}
}
open class MeasurementFormatter {
open var locale: Locale! { get set }
open var numberFormatter: NumberFormatter! { get set }
open var unitOptions: MeasurementFormatter.UnitOptions { get set }
open var unitStyle: Formatter.UnitStyle { get set }
public func string<UnitType>(from measurement: Measurement<UnitType>) -> String {}
}
open class MessagePort {
}
open class NSAffineTransform {
public convenience init(transform: AffineTransform) {}
public var transformStruct: NSAffineTransformStruct { get set }
open func append(_ transform: AffineTransform) {}
open func invert() {}
open func prepend(_ transform: AffineTransform) {}
open func rotate(byDegrees angle: CGFloat) {}
open func rotate(byRadians angle: CGFloat) {}
open func scale(by scale: CGFloat) {}
open func scaleX(by scaleX: CGFloat, yBy scaleY: CGFloat) {}
open func transform(_ aPoint: NSPoint) -> NSPoint {}
open func transform(_ aSize: NSSize) -> NSSize {}
open func translateX(by deltaX: CGFloat, yBy deltaY: CGFloat) {}
}
open class NSArray {
public static var supportsSecureCoding: Bool { get }
public init() {}
public convenience init(array: [Any]) {}
public convenience init(array: [Any], copyItems: Bool) {}
public required convenience init(arrayLiteral elements: Any...) {}
public required convenience init?(coder aDecoder: NSCoder) {}
public convenience init(contentsOf url: URL, error: Void) throws {}
public convenience init(object anObject: Any) {}
public convenience init(objects elements: AnyObject...) {}
public convenience init(objects: UnsafePointer<AnyObject>, count: Int) {}
open var count: Int { get }
public var customMirror: Mirror { get }
open var description: String { get }
open var firstObject: Any? { get }
open var hash: Int { get }
open var lastObject: Any? { get }
open var sortedArrayHint: Data { get }
open subscript(idx: Int) -> Any { get } {}
open func adding(_ anObject: Any) -> [Any] {}
open func addingObjects(from otherArray: [Any]) -> [Any] {}
open func componentsJoined(by separator: String) -> String {}
open func contains(_ anObject: Any) -> Bool {}
open func copy() -> Any {}
open func copy(with zone: NSZone? = x) -> Any {}
open func description(withLocale locale: Locale?) -> String {}
open func description(withLocale locale: Locale?, indent level: Int) -> String {}
open func encode(with aCoder: NSCoder) {}
open func enumerateObjects(_ block: (Any, Int, UnsafeMutablePointer<ObjCBool>) -> Swift.Void) {}
open func enumerateObjects(at s: IndexSet, options opts: NSEnumerationOptions = x, using block: (Any, Int, UnsafeMutablePointer<ObjCBool>) -> Swift.Void) {}
open func enumerateObjects(options opts: NSEnumerationOptions = x, using block: (Any, Int, UnsafeMutablePointer<ObjCBool>) -> Swift.Void) {}
open func filtered(using predicate: NSPredicate) -> [Any] {}
open func firstObjectCommon(with otherArray: [Any]) -> Any? {}
open func index(of anObject: Any) -> Int {}
open func index(of anObject: Any, in range: NSRange) -> Int {}
open func index(of obj: Any, inSortedRange r: NSRange, options opts: NSBinarySearchingOptions = x, usingComparator cmp: (Any, Any) -> ComparisonResult) -> Int {}
open func indexOfObject(at s: IndexSet, options opts: NSEnumerationOptions = x, passingTest predicate: (Any, Int, UnsafeMutablePointer<ObjCBool>) -> Bool) -> Int {}
open func indexOfObject(options opts: NSEnumerationOptions = x, passingTest predicate: (Any, Int, UnsafeMutablePointer<ObjCBool>) -> Bool) -> Int {}
open func indexOfObject(passingTest predicate: (Any, Int, UnsafeMutablePointer<ObjCBool>) -> Bool) -> Int {}
open func indexOfObjectIdentical(to anObject: Any) -> Int {}
open func indexOfObjectIdentical(to anObject: Any, in range: NSRange) -> Int {}
open func indexesOfObjects(at s: IndexSet, options opts: NSEnumerationOptions = x, passingTest predicate: (Any, Int, UnsafeMutablePointer<ObjCBool>) -> Bool) -> IndexSet {}
open func indexesOfObjects(options opts: NSEnumerationOptions = x, passingTest predicate: (Any, Int, UnsafeMutablePointer<ObjCBool>) -> Bool) -> IndexSet {}
open func indexesOfObjects(passingTest predicate: (Any, Int, UnsafeMutablePointer<ObjCBool>) -> Bool) -> IndexSet {}
open func isEqual(_ value: Any?) -> Bool {}
open func isEqual(to otherArray: [Any]) -> Bool {}
public func makeIterator() -> Iterator {}
open func mutableCopy() -> Any {}
open func mutableCopy(with zone: NSZone? = x) -> Any {}
open func object(at index: Int) -> Any {}
open func objectEnumerator() -> NSEnumerator {}
open func objects(at indexes: IndexSet) -> [Any] {}
open func pathsMatchingExtensions(_ filterTypes: [String]) -> [String] {}
open func reverseObjectEnumerator() -> NSEnumerator {}
open func sortedArray(_ comparator: (Any, Any, UnsafeMutableRawPointer?) -> Int, context: UnsafeMutableRawPointer?) -> [Any] {}
open func sortedArray(_ comparator: (Any, Any, UnsafeMutableRawPointer?) -> Int, context: UnsafeMutableRawPointer?, hint: Data?) -> [Any] {}
open func sortedArray(comparator cmptr: (Any, Any) -> ComparisonResult) -> [Any] {}
open func sortedArray(options opts: NSSortOptions = x, usingComparator cmptr: (Any, Any) -> ComparisonResult) -> [Any] {}
public func sortedArray(using sortDescriptors: [NSSortDescriptor]) -> [Any] {}
open func subarray(with range: NSRange) -> [Any] {}
open func write(to url: URL) throws {}
}
open class NSAttributedString {
public static var supportsSecureCoding: Bool { get }
public init(attributedString: NSAttributedString) {}
public required init?(coder aDecoder: NSCoder) {}
public init(string: String) {}
public init(string: String, attributes attrs: [NSAttributedStringKey: Any]? = x) {}
open var length: Int { get }
open var string: String { get }
open func attribute(_ attrName: NSAttributedStringKey, at location: Int, effectiveRange range: NSRangePointer?) -> Any? {}
open func attribute(_ attrName: NSAttributedStringKey, at location: Int, longestEffectiveRange range: NSRangePointer?, in rangeLimit: NSRange) -> Any? {}
open func attributedSubstring(from range: NSRange) -> NSAttributedString {}
open func attributes(at location: Int, effectiveRange range: NSRangePointer?) -> [NSAttributedStringKey: Any] {}
open func attributes(at location: Int, longestEffectiveRange range: NSRangePointer?, in rangeLimit: NSRange) -> [NSAttributedStringKey: Any] {}
open func copy() -> Any {}
open func copy(with zone: NSZone? = x) -> Any {}
open func encode(with aCoder: NSCoder) {}
open func enumerateAttribute(_ attrName: NSAttributedStringKey, in enumerationRange: NSRange, options opts: NSAttributedString.EnumerationOptions = x, using block: (Any?, NSRange, UnsafeMutablePointer<ObjCBool>) -> Swift.Void) {}
open func enumerateAttributes(in enumerationRange: NSRange, options opts: NSAttributedString.EnumerationOptions = x, using block: ([NSAttributedStringKey: Any], NSRange, UnsafeMutablePointer<ObjCBool>) -> Swift.Void) {}
open func isEqual(to other: NSAttributedString) -> Bool {}
open func mutableCopy() -> Any {}
open func mutableCopy(with zone: NSZone? = x) -> Any {}
}
open class NSCache<KeyType, ObjectType> {
open var countLimit: Int { get set }
open weak var delegate: NSCacheDelegate? { get set }
open var evictsObjectsWithDiscardedContent: Bool { get set }
open var name: String { get set }
open var totalCostLimit: Int { get set }
open func object(forKey key: KeyType) -> ObjectType? {}
open func removeAllObjects() {}
open func removeObject(forKey key: KeyType) {}
open func setObject(_ obj: ObjectType, forKey key: KeyType) {}
open func setObject(_ obj: ObjectType, forKey key: KeyType, cost g: Int) {}
}
open class NSCalendar {
open class var autoupdatingCurrent: Calendar { get }
open class var current: Calendar { get }
public init?(calendarIdentifier ident: Identifier) {}
public init?(identifier calendarIdentifierConstant: Identifier) {}
open var amSymbol: String { get }
open var calendarIdentifier: Identifier { get }
open var eraSymbols: [String] { get }
open var firstWeekday: Int { get set }
open var locale: Locale? { get set }
open var longEraSymbols: [String] { get }
open var minimumDaysInFirstWeek: Int { get set }
open var monthSymbols: [String] { get }
open var pmSymbol: String { get }
open var quarterSymbols: [String] { get }
open var shortMonthSymbols: [String] { get }
open var shortQuarterSymbols: [String] { get }
open var shortStandaloneMonthSymbols: [String] { get }
open var shortStandaloneQuarterSymbols: [String] { get }
open var shortStandaloneWeekdaySymbols: [String] { get }
open var shortWeekdaySymbols: [String] { get }
open var standaloneMonthSymbols: [String] { get }
open var standaloneQuarterSymbols: [String] { get }
open var standaloneWeekdaySymbols: [String] { get }
open var timeZone: TimeZone { get set }
open var veryShortMonthSymbols: [String] { get }
open var veryShortStandaloneMonthSymbols: [String] { get }
open var veryShortStandaloneWeekdaySymbols: [String] { get }
open var veryShortWeekdaySymbols: [String] { get }
open var weekdaySymbols: [String] { get }
open func compare(_ date1: Date, to date2: Date, toUnitGranularity unit: Unit) -> ComparisonResult {}
open func component(_ unit: Unit, from date: Date) -> Int {}
open func components(_ unitFlags: Unit, from date: Date) -> DateComponents {}
open func components(_ unitFlags: Unit, from startingDate: Date, to resultDate: Date, options opts: Options = x) -> DateComponents {}
open func components(in timezone: TimeZone, from date: Date) -> DateComponents {}
open func date(_ date: Date, matchesComponents components: DateComponents) -> Bool {}
open func date(byAdding comps: DateComponents, to date: Date, options opts: Options = x) -> Date? {}
open func date(byAdding unit: Unit, value: Int, to date: Date, options: Options = x) -> Date? {}
open func date(bySettingHour h: Int, minute m: Int, second s: Int, of date: Date, options opts: Options = x) -> Date? {}
open func date(bySettingUnit unit: Unit, value v: Int, of date: Date, options opts: Options = x) -> Date? {}
open func date(era eraValue: Int, year yearValue: Int, month monthValue: Int, day dayValue: Int, hour hourValue: Int, minute minuteValue: Int, second secondValue: Int, nanosecond nanosecondValue: Int) -> Date? {}
open func date(era eraValue: Int, yearForWeekOfYear yearValue: Int, weekOfYear weekValue: Int, weekday weekdayValue: Int, hour hourValue: Int, minute minuteValue: Int, second secondValue: Int, nanosecond nanosecondValue: Int) -> Date? {}
open func date(from comps: DateComponents) -> Date? {}
open func enumerateDates(startingAfter start: Date, matching comps: DateComponents, options opts: NSCalendar.Options = x, using block: (Date?, Bool, UnsafeMutablePointer<ObjCBool>) -> Swift.Void) {}
open func getEra(_ eraValuePointer: UnsafeMutablePointer<Int>?, year yearValuePointer: UnsafeMutablePointer<Int>?, month monthValuePointer: UnsafeMutablePointer<Int>?, day dayValuePointer: UnsafeMutablePointer<Int>?, from date: Date) {}
open func getEra(_ eraValuePointer: UnsafeMutablePointer<Int>?, yearForWeekOfYear yearValuePointer: UnsafeMutablePointer<Int>?, weekOfYear weekValuePointer: UnsafeMutablePointer<Int>?, weekday weekdayValuePointer: UnsafeMutablePointer<Int>?, from date: Date) {}
open func getHour(_ hourValuePointer: UnsafeMutablePointer<Int>?, minute minuteValuePointer: UnsafeMutablePointer<Int>?, second secondValuePointer: UnsafeMutablePointer<Int>?, nanosecond nanosecondValuePointer: UnsafeMutablePointer<Int>?, from date: Date) {}
open func isDate(_ date1: Date, equalTo date2: Date, toUnitGranularity unit: Unit) -> Bool {}
open func isDate(_ date1: Date, inSameDayAs date2: Date) -> Bool {}
open func isDateInToday(_ date: Date) -> Bool {}
open func isDateInTomorrow(_ date: Date) -> Bool {}
open func isDateInWeekend(_ date: Date) -> Bool {}
open func isDateInYesterday(_ date: Date) -> Bool {}
open func maximumRange(of unit: Unit) -> NSRange {}
open func minimumRange(of unit: Unit) -> NSRange {}
open func nextDate(after date: Date, matching comps: DateComponents, options: Options = x) -> Date? {}
open func nextDate(after date: Date, matching unit: Unit, value: Int, options: Options = x) -> Date? {}
open func nextDate(after date: Date, matchingHour hourValue: Int, minute minuteValue: Int, second secondValue: Int, options: Options = x) -> Date? {}
open func nextWeekendAfter(_ date: Date, options: Options) -> DateInterval? {}
open func ordinality(of smaller: Unit, in larger: Unit, for date: Date) -> Int {}
open func range(of unit: Unit, for date: Date) -> DateInterval? {}
open func range(of smaller: Unit, in larger: Unit, for date: Date) -> NSRange {}
open func range(ofWeekendContaining date: Date) -> DateInterval? {}
open func startOfDay(for date: Date) -> Date {}
}
open class NSCharacterSet {
open class var alphanumerics: CharacterSet { get }
open class var capitalizedLetters: CharacterSet { get }
open class var controlCharacters: CharacterSet { get }
open class var decimalDigits: CharacterSet { get }
open class var decomposables: CharacterSet { get }
open class var illegalCharacters: CharacterSet { get }
public class var letters: CharacterSet { get }
open class var lowercaseLetters: CharacterSet { get }
open class var newlines: CharacterSet { get }
open class var nonBaseCharacters: CharacterSet { get }
open class var punctuationCharacters: CharacterSet { get }
open class var symbols: CharacterSet { get }
open class var uppercaseLetters: CharacterSet { get }
open class var urlFragmentAllowed: CharacterSet { get }
open class var urlHostAllowed: CharacterSet { get }
open class var urlPasswordAllowed: CharacterSet { get }
open class var urlPathAllowed: CharacterSet { get }
open class var urlQueryAllowed: CharacterSet { get }
open class var urlUserAllowed: CharacterSet { get }
open class var whitespaces: CharacterSet { get }
open class var whitespacesAndNewlines: CharacterSet { get }
public init() {}
public init(bitmapRepresentation data: Data) {}
public init(charactersIn aString: String) {}
public required convenience init(coder aDecoder: NSCoder) {}
public convenience init?(contentsOfFile fName: String) {}
public init(range aRange: NSRange) {}
open var bitmapRepresentation: Data { get }
open var description: String { get }
open var hash: Int { get }
open var inverted: CharacterSet { get }
open func characterIsMember(_ aCharacter: unichar) -> Bool {}
open func copy() -> Any {}
open func copy(with zone: NSZone? = x) -> Any {}
open func encode(with aCoder: NSCoder) {}
open func hasMemberInPlane(_ thePlane: UInt8) -> Bool {}
open func isEqual(_ value: Any?) -> Bool {}
open func isSuperset(of theOtherSet: CharacterSet) -> Bool {}
open func longCharacterIsMember(_ theLongChar: UInt32) -> Bool {}
open func mutableCopy() -> Any {}
open func mutableCopy(with zone: NSZone? = x) -> Any {}
}
open class NSCoder {
open var allowedClasses: [AnyClass]? { get }
open var allowsKeyedCoding: Bool { get }
open var decodingFailurePolicy: NSCoder.DecodingFailurePolicy { get }
open var error: Error? { get }
open var requiresSecureCoding: Bool { get }
open var systemVersion: UInt32 { get }
open func containsValue(forKey key: String) -> Bool {}
open func decodeArray(ofObjCType itemType: UnsafePointer<Int8>, count: Int, at array: UnsafeMutableRawPointer) {}
open func decodeBool(forKey key: String) -> Bool {}
open func decodeCInt(forKey key: String) -> Int32 {}
open func decodeData() -> Data? {}
open func decodeDouble(forKey key: String) -> Double {}
open func decodeFloat(forKey key: String) -> Float {}
open func decodeInt32(forKey key: String) -> Int32 {}
open func decodeInt64(forKey key: String) -> Int64 {}
open func decodeInteger(forKey key: String) -> Int {}
open func decodeObject() -> Any? {}
open func decodeObject(forKey key: String) -> Any? {}
open func decodeObject(of classes: [AnyClass]?, forKey key: String) -> Any? {}
public func decodePoint() -> NSPoint {}
public func decodePoint(forKey key: String) -> NSPoint {}
open func decodePropertyList() -> Any? {}
open func decodePropertyList(forKey key: String) -> Any? {}
public func decodeRect() -> NSRect {}
public func decodeRect(forKey key: String) -> NSRect {}
public func decodeSize() -> NSSize {}
public func decodeSize(forKey key: String) -> NSSize {}
open func decodeTopLevelObject() throws -> Any? {}
open func decodeTopLevelObject(forKey key: String) throws -> Any? {}
open func decodeTopLevelObject(of classes: [AnyClass], forKey key: String) throws -> Any? {}
open func decodeValue(ofObjCType type: UnsafePointer<Int8>, at data: UnsafeMutableRawPointer) {}
open func encode(_ data: Data) {}
open func encode(_ object: Any?) {}
open func encode(_ boolv: Bool, forKey key: String) {}
open func encode(_ intv: Int, forKey key: String) {}
open func encode(_ intv: Int32, forKey key: String) {}
open func encode(_ intv: Int64, forKey key: String) {}
open func encode(_ objv: Any?, forKey key: String) {}
open func encode(_ realv: Double, forKey key: String) {}
open func encodeArray(ofObjCType type: UnsafePointer<Int8>, count: Int, at array: UnsafeRawPointer) {}
open func encodeBycopyObject(_ anObject: Any?) {}
open func encodeByrefObject(_ anObject: Any?) {}
open func encodeBytes(_ byteaddr: UnsafeRawPointer?, length: Int) {}
open func encodeBytes(_ bytesp: UnsafePointer<UInt8>?, length lenv: Int, forKey key: String) {}
open func encodeConditionalObject(_ object: Any?) {}
open func encodeConditionalObject(_ objv: Any?, forKey key: String) {}
open func encodePropertyList(_ aPropertyList: Any) {}
open func encodeRootObject(_ rootObject: Any) {}
open func encodeValue(ofObjCType type: UnsafePointer<Int8>, at addr: UnsafeRawPointer) {}
open func failWithError(_ error: Error) {}
open func version(forClassName className: String) -> Int {}
open func withDecodedUnsafeBufferPointer<ResultType>(forKey key: String, body: (UnsafeBufferPointer<UInt8>?) throws -> ResultType) rethrows -> ResultType {}
}
open class NSComparisonPredicate {
public init(leftExpression lhs: NSExpression, rightExpression rhs: NSExpression, modifier: Modifier, type: Operator, options: Options) {}
open var comparisonPredicateModifier: Modifier { get }
open var leftExpression: NSExpression { get }
open var options: Options { get }
open var predicateOperatorType: Operator { get }
open var rightExpression: NSExpression { get }
}
open class NSCompoundPredicate {
public convenience init(andPredicateWithSubpredicates subpredicates: [NSPredicate]) {}
public convenience init(notPredicateWithSubpredicate predicate: NSPredicate) {}
public convenience init(orPredicateWithSubpredicates subpredicates: [NSPredicate]) {}
public init(type: LogicalType, subpredicates: [NSPredicate]) {}
open var compoundPredicateType: LogicalType { get set }
open var subpredicates: [NSPredicate] { get set }
}
open class NSCondition {
open var name: String? { get set }
open func broadcast() {}
open func signal() {}
open func wait() {}
open func wait(until limit: Date) -> Bool {}
}
open class NSConditionLock {
public init(condition: Int) {}
open var condition: Int { get }
open var name: String? { get set }
open func lock(before limit: Date) -> Bool {}
open func lock(whenCondition condition: Int) {}
open func lock(whenCondition condition: Int, before limit: Date) -> Bool {}
open func try() -> Bool {}
open func tryLock(whenCondition condition: Int) -> Bool {}
open func unlock(withCondition condition: Int) {}
}
open class NSCountedSet {
public convenience init(array: [Any]) {}
public convenience init(set: Set<AnyHashable>) {}
open func copy(with zone: NSZone? = x) -> Any {}
open func count(for object: Any) -> Int {}
open func mutableCopy(with zone: NSZone? = x) -> Any {}
}
open class NSData {
public init?(base64Encoded base64Data: Data, options: Base64DecodingOptions = x) {}
public init?(base64Encoded base64String: String, options: Base64DecodingOptions = x) {}
public init(bytes: UnsafeRawPointer?, length: Int) {}
public init(bytesNoCopy bytes: UnsafeMutableRawPointer, length: Int) {}
public init(bytesNoCopy bytes: UnsafeMutableRawPointer, length: Int, deallocator: ((UnsafeMutableRawPointer, Int) -> Void)? = x) {}
public init(bytesNoCopy bytes: UnsafeMutableRawPointer, length: Int, freeWhenDone: Bool) {}
public init?(contentsOf url: URL) {}
public init(contentsOf url: URL, options readOptionsMask: ReadingOptions = x) throws {}
public init?(contentsOfFile path: String) {}
public init(contentsOfFile path: String, options readOptionsMask: ReadingOptions = x) throws {}
public init(data: Data) {}
open var bytes: UnsafeRawPointer { get }
open var length: Int { get }
open func base64EncodedData(options: Base64EncodingOptions = x) -> Data {}
open func base64EncodedString(options: Base64EncodingOptions = x) -> String {}
open func enumerateBytes(_ block: (UnsafeRawPointer, NSRange, UnsafeMutablePointer<Bool>) -> Void) {}
open func getBytes(_ buffer: UnsafeMutableRawPointer, length: Int) {}
open func getBytes(_ buffer: UnsafeMutableRawPointer, range: NSRange) {}
open func isEqual(to other: Data) -> Bool {}
open func range(of dataToFind: Data, options mask: SearchOptions = x, in searchRange: NSRange) -> NSRange {}
open func subdata(with range: NSRange) -> Data {}
open func write(to url: URL, atomically: Bool) -> Bool {}
open func write(to url: URL, options writeOptionsMask: WritingOptions = x) throws {}
open func write(toFile path: String, atomically useAuxiliaryFile: Bool) -> Bool {}
open func write(toFile path: String, options writeOptionsMask: WritingOptions = x) throws {}
}
open class NSDate {
open class var distantFuture: Date { get }
open class var distantPast: Date { get }
open class var timeIntervalSinceReferenceDate: TimeInterval { get }
public convenience init(timeInterval secsToBeAdded: TimeInterval, since date: Date) {}
public convenience init(timeIntervalSince1970 secs: TimeInterval) {}
public convenience init(timeIntervalSinceNow secs: TimeInterval) {}
public required init(timeIntervalSinceReferenceDate ti: TimeInterval) {}
open var timeIntervalSince1970: TimeInterval { get }
open var timeIntervalSinceNow: TimeInterval { get }
open var timeIntervalSinceReferenceDate: TimeInterval { get }
open func addingTimeInterval(_ ti: TimeInterval) -> Date {}
open func compare(_ other: Date) -> ComparisonResult {}
open func description(with locale: Locale?) -> String {}
open func earlierDate(_ anotherDate: Date) -> Date {}
open func isEqual(to otherDate: Date) -> Bool {}
open func laterDate(_ anotherDate: Date) -> Date {}
open func timeIntervalSince(_ anotherDate: Date) -> TimeInterval {}
}
open class NSDateComponents {
open var calendar: Calendar? { get set }
open var date: Date? { get }
open var day: Int { get set }
open var era: Int { get set }
open var hour: Int { get set }
open var isLeapMonth: Bool { get set }
open var isValidDate: Bool { get }
open var minute: Int { get set }
open var month: Int { get set }
open var nanosecond: Int { get set }
open var quarter: Int { get set }
open var second: Int { get set }
open var timeZone: TimeZone? { get set }
open var weekOfMonth: Int { get set }
open var weekOfYear: Int { get set }
open var weekday: Int { get set }
open var weekdayOrdinal: Int { get set }
open var year: Int { get set }
open var yearForWeekOfYear: Int { get set }
open func isValidDate(in calendar: Calendar) -> Bool {}
open func setValue(_ value: Int, forComponent unit: NSCalendar.Unit) {}
open func value(forComponent unit: NSCalendar.Unit) -> Int {}
}
open class NSDateInterval {
public init(start startDate: Date, duration: TimeInterval) {}
public convenience init(start startDate: Date, end endDate: Date) {}
open var duration: TimeInterval { get }
open var endDate: Date { get }
open var startDate: Date { get }
open func compare(_ dateInterval: DateInterval) -> ComparisonResult {}
open func contains(_ date: Date) -> Bool {}
open func intersection(with dateInterval: DateInterval) -> DateInterval? {}
open func intersects(_ dateInterval: DateInterval) -> Bool {}
open func isEqual(to dateInterval: DateInterval) -> Bool {}
}
open class NSDecimalNumber {
open class var defaultBehavior: NSDecimalNumberBehaviors { get }
open class var maximum: NSDecimalNumber { get }
open class var minimum: NSDecimalNumber { get }
open class var notANumber: NSDecimalNumber { get }
open class var one: NSDecimalNumber { get }
open class var zero: NSDecimalNumber { get }
public init(decimal dcm: Decimal) {}
public convenience init(mantissa: UInt64, exponent: Int16, isNegative: Bool) {}
public convenience init(string numberValue: String?) {}
public convenience init(string numberValue: String?, locale: Any?) {}
open func adding(_ other: NSDecimalNumber) -> NSDecimalNumber {}
open func adding(_ other: NSDecimalNumber, withBehavior b: NSDecimalNumberBehaviors?) -> NSDecimalNumber {}
open func dividing(by other: NSDecimalNumber) -> NSDecimalNumber {}
open func dividing(by other: NSDecimalNumber, withBehavior b: NSDecimalNumberBehaviors?) -> NSDecimalNumber {}
open func multiplying(by other: NSDecimalNumber) -> NSDecimalNumber {}
open func multiplying(by other: NSDecimalNumber, withBehavior b: NSDecimalNumberBehaviors?) -> NSDecimalNumber {}
open func multiplying(byPowerOf10 power: Int16) -> NSDecimalNumber {}
open func multiplying(byPowerOf10 power: Int16, withBehavior b: NSDecimalNumberBehaviors?) -> NSDecimalNumber {}
open func raising(toPower power: Int) -> NSDecimalNumber {}
open func raising(toPower power: Int, withBehavior b: NSDecimalNumberBehaviors?) -> NSDecimalNumber {}
open func rounding(accordingToBehavior b: NSDecimalNumberBehaviors?) -> NSDecimalNumber {}
open func subtracting(_ other: NSDecimalNumber) -> NSDecimalNumber {}
open func subtracting(_ other: NSDecimalNumber, withBehavior b: NSDecimalNumberBehaviors?) -> NSDecimalNumber {}
}
open class NSDecimalNumberHandler {
open class var default: NSDecimalNumberHandler { get }
public init(roundingMode: NSDecimalNumber.RoundingMode, scale: Int16, raiseOnExactness exact: Bool, raiseOnOverflow overflow: Bool, raiseOnUnderflow underflow: Bool, raiseOnDivideByZero divideByZero: Bool) {}
}
open class NSDictionary {
public static var supportsSecureCoding: Bool { get }
open class func sharedKeySet(forKeys keys: [NSCopying]) -> Any {}
public convenience init() {}
public required convenience init?(coder aDecoder: NSCoder) {}
public convenience init(dictionary otherDictionary: [AnyHashable: Any]) {}
public required convenience init(dictionaryLiteral elements: (Any, Any)...) {}
public convenience init(object: Any, forKey key: NSCopying) {}
public convenience init(objects: [Any], forKeys keys: [NSObject]) {}
public required init(objects: UnsafePointer<AnyObject>!, forKeys keys: UnsafePointer<NSObject>!, count cnt: Int) {}
open var allKeys: [Any] { get }
open var allValues: [Any] { get }
open var count: Int { get }
public var customMirror: Mirror { get }
open var description: String { get }
open var descriptionInStringsFileFormat: String { get }
open var hash: Int { get }
open subscript(key: Any) -> Any? { get } {}
open func allKeys(for anObject: Any) -> [Any] {}
open func copy() -> Any {}
open func copy(with zone: NSZone? = x) -> Any {}
open func description(withLocale locale: Locale?) -> String {}
open func description(withLocale locale: Locale?, indent level: Int) -> String {}
open func encode(with aCoder: NSCoder) {}
open func enumerateKeysAndObjects(_ block: (Any, Any, UnsafeMutablePointer<ObjCBool>) -> Swift.Void) {}
open func enumerateKeysAndObjects(options opts: NSEnumerationOptions = x, using block: (Any, Any, UnsafeMutablePointer<ObjCBool>) -> Void) {}
open func getObjects(_ objects: inout [Any], andKeys keys: inout [Any], count: Int) {}
open func isEqual(_ value: Any?) -> Bool {}
open func isEqual(to otherDictionary: [AnyHashable: Any]) -> Bool {}
open func keyEnumerator() -> NSEnumerator {}
open func keysOfEntries(options opts: NSEnumerationOptions = x, passingTest predicate: (Any, Any, UnsafeMutablePointer<ObjCBool>) -> Bool) -> Set<AnyHashable> {}
open func keysOfEntries(passingTest predicate: (Any, Any, UnsafeMutablePointer<ObjCBool>) -> Bool) -> Set<AnyHashable> {}
open func keysSortedByValue(comparator cmptr: (Any, Any) -> ComparisonResult) -> [Any] {}
open func keysSortedByValue(options opts: NSSortOptions = x, usingComparator cmptr: (Any, Any) -> ComparisonResult) -> [Any] {}
public func makeIterator() -> Iterator {}
open func mutableCopy() -> Any {}
open func mutableCopy(with zone: NSZone? = x) -> Any {}
open func object(forKey aKey: Any) -> Any? {}
open func objectEnumerator() -> NSEnumerator {}
open func objects(forKeys keys: [Any], notFoundMarker marker: Any) -> [Any] {}
open func value(forKey key: String) -> Any? {}
open func write(to url: URL, atomically: Bool) -> Bool {}
open func write(toFile path: String, atomically useAuxiliaryFile: Bool) -> Bool {}
}
open class NSEnumerator {
public var allObjects: [Any] { get }
public func makeIterator() -> Iterator {}
open func nextObject() -> Any? {}
}
open class NSError {
open class func setUserInfoValueProvider(forDomain errorDomain: String, provider: ((Error, String) -> Any?)?) {}
open class func userInfoValueProvider(forDomain errorDomain: String) -> ((Error, String) -> Any?)? {}
public init(domain: String, code: Int, userInfo dict: [String: Any]? = x) {}
open var code: Int { get }
open var domain: String { get }
open var helpAnchor: String? { get }
open var localizedDescription: String { get }
open var localizedFailureReason: String? { get }
open var localizedRecoveryOptions: [String]? { get }
open var localizedRecoverySuggestion: String? { get }
open var recoveryAttempter: Any? { get }
open var userInfo: [String: Any] { get }
}
open class NSExpression {
open class func expressionForAnyKey() -> NSExpression {}
open class func expressionForEvaluatedObject() -> NSExpression {}
public init(block: @escaping (Any?, [Any], NSMutableDictionary?) -> Any, arguments: [NSExpression]?) {}
public init(expressionType type: ExpressionType) {}
public init(forAggregate subexpressions: [Any]) {}
public init(forConditional predicate: Any, trueExpression: NSExpression, falseExpression: NSExpression) {}
public init(forConstantValue obj: Any?) {}
public init(forFunction name: String, arguments parameters: [Any]) {}
public init(forFunction target: NSExpression, selectorName name: String, arguments parameters: [Any]?) {}
public init(forIntersectSet left: NSExpression, with right: NSExpression) {}
public init(forKeyPath keyPath: String) {}
public init(forMinusSet left: NSExpression, with right: NSExpression) {}
public init(forSubquery expression: NSExpression, usingIteratorVariable variable: String, predicate: Any) {}
public init(forUnionSet left: NSExpression, with right: NSExpression) {}
public init(forVariable string: String) {}
public convenience init(format expressionFormat: String, _ args: CVarArg...) {}
public init(format expressionFormat: String, argumentArray arguments: [Any]) {}
public init(format expressionFormat: String, arguments argList: CVaListPointer) {}
open var arguments: [NSExpression]? { get }
open var collection: Any { get }
open var constantValue: Any { get }
open var expressionBlock: (Any?, [Any], NSMutableDictionary?) -> Any { get }
open var expressionType: ExpressionType { get }
open var false: NSExpression { get }
open var function: String { get }
open var keyPath: String { get }
open var left: NSExpression { get }
open var operand: NSExpression { get }
open var predicate: NSPredicate { get }
open var right: NSExpression { get }
open var true: NSExpression { get }
open var variable: String { get }
open func allowEvaluation() {}
open func expressionValue(with object: Any?, context: NSMutableDictionary?) -> Any? {}
}
open class NSIndexPath {
public convenience init(index: Int) {}
public init(indexes: UnsafePointer<Int>?, length: Int) {}
open var length: Int { get }
open func adding(_ index: Int) -> IndexPath {}
open func compare(_ otherObject: IndexPath) -> ComparisonResult {}
open func getIndexes(_ indexes: UnsafeMutablePointer<Int>, range positionRange: NSRange) {}
open func index(atPosition position: Int) -> Int {}
open func removingLastIndex() -> IndexPath {}
}
open class NSIndexSet {
public convenience init(index value: Int) {}
public init(indexSet: IndexSet) {}
public init(indexesIn range: NSRange) {}
open var count: Int { get }
open var firstIndex: Int { get }
open var lastIndex: Int { get }
open func contains(_ indexSet: IndexSet) -> Bool {}
open func contains(in range: NSRange) -> Bool {}
open func countOfIndexes(in range: NSRange) -> Int {}
open func enumerate(_ block: (Int, UnsafeMutablePointer<ObjCBool>) -> Void) {}
open func enumerate(in range: NSRange, options opts: NSEnumerationOptions = x, using block: (Int, UnsafeMutablePointer<ObjCBool>) -> Void) {}
open func enumerate(options opts: NSEnumerationOptions = x, using block: (Int, UnsafeMutablePointer<ObjCBool>) -> Void) {}
open func enumerateRanges(_ block: (NSRange, UnsafeMutablePointer<ObjCBool>) -> Void) {}
open func enumerateRanges(in range: NSRange, options opts: NSEnumerationOptions = x, using block: (NSRange, UnsafeMutablePointer<ObjCBool>) -> Void) {}
open func enumerateRanges(options opts: NSEnumerationOptions = x, using block: (NSRange, UnsafeMutablePointer<ObjCBool>) -> Void) {}
open func getIndexes(_ indexBuffer: UnsafeMutablePointer<Int>, maxCount bufferSize: Int, inIndexRange range: NSRangePointer?) -> Int {}
open func index(in range: NSRange, options opts: NSEnumerationOptions = x, passingTest predicate: (Int, UnsafeMutablePointer<ObjCBool>) -> Bool) -> Int {}
open func index(options opts: NSEnumerationOptions = x, passingTest predicate: (Int, UnsafeMutablePointer<ObjCBool>) -> Bool) -> Int {}
open func index(passingTest predicate: (Int, UnsafeMutablePointer<ObjCBool>) -> Bool) -> Int {}
open func indexGreaterThanIndex(_ value: Int) -> Int {}
open func indexGreaterThanOrEqual(to value: Int) -> Int {}
open func indexLessThanIndex(_ value: Int) -> Int {}
open func indexLessThanOrEqual(to value: Int) -> Int {}
open func indexes(in range: NSRange, options opts: NSEnumerationOptions = x, passingTest predicate: (Int, UnsafeMutablePointer<ObjCBool>) -> Bool) -> IndexSet {}
open func indexes(options opts: NSEnumerationOptions = x, passingTest predicate: (Int, UnsafeMutablePointer<ObjCBool>) -> Bool) -> IndexSet {}
open func indexes(passingTest predicate: (Int, UnsafeMutablePointer<ObjCBool>) -> Bool) -> IndexSet {}
open func intersects(in range: NSRange) -> Bool {}
open func isEqual(to indexSet: IndexSet) -> Bool {}
public func makeIterator() -> NSIndexSetIterator {}
}
open class NSKeyedArchiver {
open class func archiveRootObject(_ rootObject: Any, toFile path: String) -> Bool {}
open class func archivedData(withRootObject rootObject: Any) -> Data {}
open class func classNameForClass(_ cls: AnyClass) -> String? {}
open class func setClassName(_ codedName: String?, for cls: AnyClass) {}
public convenience init() {}
public convenience init(forWritingWith data: NSMutableData) {}
open weak var delegate: NSKeyedArchiverDelegate? { get set }
open var encodedData: Data { get }
open var outputFormat { get }
open func classNameForClass(_ cls: AnyClass) -> String? {}
open func encodePropertyList(_ aPropertyList: Any, forKey key: String) {}
open func finishEncoding() {}
open func setClassName(_ codedName: String?, for cls: AnyClass) {}
}
open class NSKeyedUnarchiver {
open class func class(forClassName codedName: String) -> AnyClass? {}
open class func setClass(_ cls: AnyClass?, forClassName codedName: String) {}
open class func unarchiveObject(with data: Data) -> Any? {}
open class func unarchiveObject(withFile path: String) -> Any? {}
open class func unarchiveTopLevelObjectWithData(_ data: Data) throws -> Any? {}
public convenience init(forReadingWith data: Data) {}
open weak var delegate: NSKeyedUnarchiverDelegate? { get set }
open func class(forClassName codedName: String) -> AnyClass? {}
open func finishDecoding() {}
open func setClass(_ cls: AnyClass?, forClassName codedName: String) {}
}
open class NSLocale {
open class var availableLocaleIdentifiers: [String] { get }
open class var commonISOCurrencyCodes: [String] { get }
open class var current: Locale { get }
public static var currentLocaleDidChangeNotification { get }
open class var isoCountryCodes: [String] { get }
open class var isoCurrencyCodes: [String] { get }
open class var isoLanguageCodes: [String] { get }
open class var preferredLanguages: [String] { get }
open class var system: Locale { get }
open class func canonicalLanguageIdentifier(from string: String) -> String {}
open class func canonicalLocaleIdentifier(from string: String) -> String {}
open class func characterDirection(forLanguage isoLangCode: String) -> NSLocale.LanguageDirection {}
open class func components(fromLocaleIdentifier string: String) -> [String: String] {}
open class func lineDirection(forLanguage isoLangCode: String) -> NSLocale.LanguageDirection {}
open class func localeIdentifier(fromComponents dict: [String: String]) -> String {}
open class func localeIdentifier(fromWindowsLocaleCode lcid: UInt32) -> String? {}
open class func windowsLocaleCode(fromLocaleIdentifier localeIdentifier: String) -> UInt32 {}
public init(localeIdentifier string: String) {}
public var localeIdentifier: String { get }
open func displayName(forKey key: Key, value: String) -> String? {}
open func object(forKey key: NSLocale.Key) -> Any? {}
}
open class NSLock {
open var name: String? { get set }
open func lock(before limit: Date) -> Bool {}
open func try() -> Bool {}
}
open class NSMeasurement {
public init(doubleValue: Double, unit: Unit) {}
open var doubleValue: Double { get }
open var unit: Unit { get }
open func adding(_ measurement: Measurement<Unit>) -> Measurement<Unit> {}
open func canBeConverted(to unit: Unit) -> Bool {}
open func converting(to unit: Unit) -> Measurement<Unit> {}
open func subtracting(_ measurement: Measurement<Unit>) -> Measurement<Unit> {}
}
open class NSMutableArray {
public init(capacity numItems: Int) {}
open func add(_ anObject: Any) {}
open func addObjects(from otherArray: [Any]) {}
open func exchangeObject(at idx1: Int, withObjectAt idx2: Int) {}
open func filter(using predicate: NSPredicate) {}
open func insert(_ anObject: Any, at index: Int) {}
open func remove(_ anObject: Any) {}
open func remove(_ anObject: Any, in range: NSRange) {}
open func removeAllObjects() {}
open func removeLastObject() {}
open func removeObject(at index: Int) {}
open func removeObject(identicalTo anObject: Any) {}
open func removeObject(identicalTo anObject: Any, in range: NSRange) {}
open func removeObjects(at indexes: IndexSet) {}
open func removeObjects(in otherArray: [Any]) {}
open func replaceObject(at index: Int, with anObject: Any) {}
open func replaceObjects(at indexes: IndexSet, with objects: [Any]) {}
open func replaceObjects(in range: NSRange, withObjectsFrom otherArray: [Any]) {}
open func replaceObjects(in range: NSRange, withObjectsFrom otherArray: [Any], range otherRange: NSRange) {}
open func setArray(_ otherArray: [Any]) {}
open func sort(_ compare: (Any, Any, UnsafeMutableRawPointer?) -> Int, context: UnsafeMutableRawPointer?) {}
open func sort(comparator: Comparator) {}
open func sort(options opts: NSSortOptions = x, usingComparator cmptr: Comparator) {}
public func sort(using sortDescriptors: [NSSortDescriptor]) {}
}
open class NSMutableAttributedString {
open var mutableString: NSMutableString { get }
open func addAttribute(_ name: NSAttributedStringKey, value: Any, range: NSRange) {}
open func addAttributes(_ attrs: [NSAttributedStringKey: Any], range: NSRange) {}
open func append(_ attrString: NSAttributedString) {}
open func beginEditing() {}
open func deleteCharacters(in range: NSRange) {}
open func endEditing() {}
open func insert(_ attrString: NSAttributedString, at loc: Int) {}
open func removeAttribute(_ name: NSAttributedStringKey, range: NSRange) {}
open func replaceCharacters(in range: NSRange, with attrString: NSAttributedString) {}
open func setAttributedString(_ attrString: NSAttributedString) {}
open func setAttributes(_ attrs: [NSAttributedStringKey: Any]?, range: NSRange) {}
}
open class NSMutableCharacterSet {
open class func alphanumeric() -> NSMutableCharacterSet {}
open class func capitalizedLetter() -> NSMutableCharacterSet {}
open class func control() -> NSMutableCharacterSet {}
open class func decimalDigit() -> NSMutableCharacterSet {}
open class func decomposable() -> NSMutableCharacterSet {}
open class func illegal() -> NSMutableCharacterSet {}
public class func letter() -> NSMutableCharacterSet {}
open class func lowercaseLetter() -> NSMutableCharacterSet {}
open class func newline() -> NSMutableCharacterSet {}
open class func nonBase() -> NSMutableCharacterSet {}
open class func punctuation() -> NSMutableCharacterSet {}
open class func symbol() -> NSMutableCharacterSet {}
open class func uppercaseLetter() -> NSMutableCharacterSet {}
open class func whitespace() -> NSMutableCharacterSet {}
open class func whitespaceAndNewline() -> NSMutableCharacterSet {}
open func addCharacters(in aRange: NSRange) {}
open func formIntersection(with otherSet: CharacterSet) {}
open func formUnion(with otherSet: CharacterSet) {}
open func invert() {}
open func removeCharacters(in aRange: NSRange) {}
}
open class NSMutableData {
public init?(capacity: Int) {}
public init?(length: Int) {}
open var mutableBytes: UnsafeMutableRawPointer { get }
open func append(_ other: Data) {}
open func append(_ bytes: UnsafeRawPointer, length: Int) {}
open func increaseLength(by extraLength: Int) {}
open func replaceBytes(in range: NSRange, withBytes bytes: UnsafeRawPointer) {}
open func replaceBytes(in range: NSRange, withBytes replacementBytes: UnsafeRawPointer?, length replacementLength: Int) {}
open func resetBytes(in range: NSRange) {}
open func setData(_ data: Data) {}
}
open class NSMutableDictionary {
public convenience init(capacity numItems: Int) {}
public convenience init(sharedKeySet keyset: Any) {}
open func addEntries(from otherDictionary: [AnyHashable: Any]) {}
open func removeAllObjects() {}
open func removeObject(forKey aKey: Any) {}
open func removeObjects(forKeys keyArray: [Any]) {}
open func setDictionary(_ otherDictionary: [AnyHashable: Any]) {}
open func setObject(_ anObject: Any, forKey aKey: AnyHashable) {}
}
open class NSMutableIndexSet {
open func add(_ indexSet: IndexSet) {}
open func add(in r: NSRange) {}
open func remove(_ indexSet: IndexSet) {}
open func remove(in range: NSRange) {}
open func removeAllIndexes() {}
open func shiftIndexesStarting(at index: Int, by delta: Int) {}
}
open class NSMutableOrderedSet {
public init(capacity numItems: Int) {}
open func add(_ object: Any) {}
open func add(_ objects: UnsafePointer<AnyObject>!, count: Int) {}
open func addObjects(from array: [Any]) {}
open func exchangeObject(at idx1: Int, withObjectAt idx2: Int) {}
open func filter(using predicate: NSPredicate) {}
open func insert(_ object: Any, at idx: Int) {}
open func intersect(_ other: NSOrderedSet) {}
open func intersectSet(_ other: Set<AnyHashable>) {}
open func minus(_ other: NSOrderedSet) {}
open func minusSet(_ other: Set<AnyHashable>) {}
open func moveObjects(at indexes: IndexSet, to idx: Int) {}
open func remove(_ val: Any) {}
public func removeAllObjects() {}
open func removeObject(at idx: Int) {}
open func removeObjects(at indexes: IndexSet) {}
open func removeObjects(in array: [Any]) {}
open func replaceObject(at idx: Int, with obj: Any) {}
open func replaceObjects(at indexes: IndexSet, with objects: [Any]) {}
open func replaceObjects(in range: NSRange, with objects: UnsafePointer<AnyObject>!, count: Int) {}
open func setObject(_ obj: Any, at idx: Int) {}
open func sort(comparator cmptr: (Any, Any) -> ComparisonResult) {}
open func sort(options opts: NSSortOptions = x, usingComparator cmptr: (Any, Any) -> ComparisonResult) {}
public func sort(using sortDescriptors: [NSSortDescriptor]) {}
open func sortRange(_ range: NSRange, options opts: NSSortOptions = x, usingComparator cmptr: (Any, Any) -> ComparisonResult) {}
open func union(_ other: NSOrderedSet) {}
open func unionSet(_ other: Set<AnyHashable>) {}
}
open class NSMutableSet {
public required init(capacity numItems: Int) {}
open func add(_ object: Any) {}
open func addObjects(from array: [Any]) {}
open func filter(using predicate: NSPredicate) {}
open func intersect(_ otherSet: Set<AnyHashable>) {}
open func minus(_ otherSet: Set<AnyHashable>) {}
open func remove(_ object: Any) {}
open func removeAllObjects() {}
open func setSet(_ otherSet: Set<AnyHashable>) {}
open func union(_ otherSet: Set<AnyHashable>) {}
}
open class NSMutableString {
public required init(capacity: Int) {}
public func append(_ aString: String) {}
public func applyTransform(_ transform: String, reverse: Bool, range: NSRange, updatedRange resultingRange: NSRangePointer?) -> Bool {}
public func deleteCharacters(in range: NSRange) {}
public func insert(_ aString: String, at loc: Int) {}
open func replaceCharacters(in range: NSRange, with aString: String) {}
public func replaceOccurrences(of target: String, with replacement: String, options: CompareOptions = x, range searchRange: NSRange) -> Int {}
public func setString(_ aString: String) {}
}
open class NSMutableURLRequest {
open func addValue(_ value: String, forHTTPHeaderField field: String) {}
open func setValue(_ value: String?, forHTTPHeaderField field: String) {}
}
open class NSNotification {
public init(name: Name, object: Any?, userInfo: [AnyHashable: Any]? = x) {}
open var name: Name { get }
open var object: Any? { get }
open var userInfo: [AnyHashable: Any]? { get }
}
open class NSNull {
}
open class NSNumber {
public required convenience init(booleanLiteral value: Bool) {}
public required convenience init(floatLiteral value: Double) {}
public required convenience init(integerLiteral value: Int) {}
public convenience init(value: Bool) {}
open var boolValue: Bool { get }
open var classForCoder: AnyClass { get }
public var decimalValue: Decimal { get }
open var doubleValue: Double { get }
open var floatValue: Float { get }
open var int16Value: Int16 { get }
open var int32Value: Int32 { get }
open var int64Value: Int64 { get }
open var int8Value: Int8 { get }
open var intValue: Int { get }
open var stringValue: String { get }
open var uint16Value: UInt16 { get }
open var uint32Value: UInt32 { get }
open var uint64Value: UInt64 { get }
open var uint8Value: UInt8 { get }
open var uintValue: UInt { get }
open func compare(_ otherNumber: NSNumber) -> ComparisonResult {}
open func description(withLocale locale: Locale?) -> String {}
}
open class NSObject {
open class func classFallbacksForKeyedArchiver() -> [String] {}
open class func classForKeyedUnarchiver() -> AnyClass {}
public init() {}
open var classForCoder: AnyClass { get }
open var classForKeyedArchiver: AnyClass? { get }
open var hashValue: Int { get }
public func ==(lhs: NSObject, rhs: NSObject) -> Bool {}
open func copy() -> Any {}
open func mutableCopy() -> Any {}
open func replacementObject(for aCoder: NSCoder) -> Any? {}
open func replacementObject(for archiver: NSKeyedArchiver) -> Any? {}
}
open class NSOrderedSet {
public convenience init(array: [Any]) {}
public convenience init(array set: [Any], copyItems flag: Bool) {}
public convenience init(array set: [Any], range: NSRange, copyItems flag: Bool) {}
public required convenience init(arrayLiteral elements: Any...) {}
public convenience init(object: Any) {}
public convenience init(objects elements: Any...) {}
public init(objects: UnsafePointer<AnyObject>!, count cnt: Int) {}
public convenience init(orderedSet set: NSOrderedSet) {}
public convenience init(orderedSet set: NSOrderedSet, copyItems flag: Bool) {}
public convenience init(orderedSet set: NSOrderedSet, range: NSRange, copyItems flag: Bool) {}
public convenience init(set: Set<AnyHashable>) {}
public convenience init(set: Set<AnyHashable>, copyItems flag: Bool) {}
public var array: [Any] { get }
open var count: Int { get }
public var firstObject: Any? { get }
public var lastObject: Any? { get }
public var reversed: NSOrderedSet { get }
public var set: Set<AnyHashable> { get }
open subscript(idx: Int) -> Any { get } {}
open func contains(_ object: Any) -> Bool {}
public func description(withLocale locale: Locale?) -> String {}
public func description(withLocale locale: Locale?, indent level: Int) -> String {}
open func enumerateObjects(_ block: (Any, Int, UnsafeMutablePointer<ObjCBool>) -> Swift.Void) {}
open func enumerateObjects(at s: IndexSet, options opts: NSEnumerationOptions = x, using block: (Any, Int, UnsafeMutablePointer<ObjCBool>) -> Swift.Void) {}
open func enumerateObjects(options opts: NSEnumerationOptions = x, using block: (Any, Int, UnsafeMutablePointer<ObjCBool>) -> Swift.Void) {}
open func filtered(using predicate: NSPredicate) -> NSOrderedSet {}
public func getObjects(_ objects: inout [AnyObject], range: NSRange) {}
open func index(_ opts: NSEnumerationOptions = x, ofObjectPassingTest predicate: (Any, Int, UnsafeMutablePointer<ObjCBool>) -> Bool) -> Int {}
open func index(of object: Any) -> Int {}
open func index(of object: Any, inSortedRange range: NSRange, options opts: NSBinarySearchingOptions = x, usingComparator cmp: (Any, Any) -> ComparisonResult) -> Int {}
open func index(ofObjectAt s: IndexSet, options opts: NSEnumerationOptions = x, passingTest predicate: (Any, Int, UnsafeMutablePointer<ObjCBool>) -> Bool) -> Int {}
open func index(ofObjectPassingTest predicate: (Any, Int, UnsafeMutablePointer<ObjCBool>) -> Bool) -> Int {}
open func indexes(ofObjectsAt s: IndexSet, options opts: NSEnumerationOptions = x, passingTest predicate: (Any, Int, UnsafeMutablePointer<ObjCBool>) -> Bool) -> IndexSet {}
open func indexes(ofObjectsPassingTest predicate: (Any, Int, UnsafeMutablePointer<ObjCBool>) -> Bool) -> IndexSet {}
open func indexes(options opts: NSEnumerationOptions = x, ofObjectsPassingTest predicate: (Any, Int, UnsafeMutablePointer<ObjCBool>) -> Bool) -> IndexSet {}
open func intersects(_ other: NSOrderedSet) -> Bool {}
open func intersectsSet(_ set: Set<AnyHashable>) -> Bool {}
open func isEqual(to other: NSOrderedSet) -> Bool {}
open func isSubset(of other: NSOrderedSet) -> Bool {}
public func makeIterator() -> Iterator {}
open func object(at idx: Int) -> Any {}
public func objectEnumerator() -> NSEnumerator {}
open func objects(at indexes: IndexSet) -> [Any] {}
public func reverseObjectEnumerator() -> NSEnumerator {}
open func sortedArray(comparator cmptr: (Any, Any) -> ComparisonResult) -> [Any] {}
open func sortedArray(options opts: NSSortOptions = x, usingComparator cmptr: (Any, Any) -> ComparisonResult) -> [Any] {}
public func sortedArray(using sortDescriptors: [NSSortDescriptor]) -> [Any] {}
}
open class NSPersonNameComponents {
open var familyName: String? { get set }
open var givenName: String? { get set }
open var middleName: String? { get set }
open var namePrefix: String? { get set }
open var nameSuffix: String? { get set }
open var nickname: String? { get set }
open var phoneticRepresentation: PersonNameComponents? { get set }
}
open class NSPredicate {
public init(block: @escaping (Any?, [String: Any]?) -> Bool) {}
public convenience init(format predicateFormat: String, _ args: CVarArg...) {}
public init(format predicateFormat: String, argumentArray arguments: [Any]?) {}
public init(format predicateFormat: String, arguments argList: CVaListPointer) {}
public init?(fromMetadataQueryString queryString: String) {}
public init(value: Bool) {}
open var predicateFormat: String { get }
open func allowEvaluation() {}
open func evaluate(with object: Any?) -> Bool {}
open func evaluate(with object: Any?, substitutionVariables bindings: [String: Any]?) -> Bool {}
open func withSubstitutionVariables(_ variables: [String: Any]) -> Self {}
}
open class NSRecursiveLock {
open var name: String? { get set }
open func lock(before limit: Date) -> Bool {}
open func try() -> Bool {}
}
open class NSRegularExpression {
open class func escapedPattern(for string: String) -> String {}
open class func escapedTemplate(for string: String) -> String {}
public init(pattern: String, options: Options = x) throws {}
open var numberOfCaptureGroups: Int { get }
open var options: Options { get }
open var pattern: String { get }
public func enumerateMatches(in string: String, options: NSRegularExpression.MatchingOptions = x, range: NSRange, using block: @escaping (NSTextCheckingResult?, NSRegularExpression.MatchingFlags, UnsafeMutablePointer<ObjCBool>) -> Swift.Void) {}
public func firstMatch(in string: String, options: NSRegularExpression.MatchingOptions = x, range: NSRange) -> NSTextCheckingResult? {}
public func matches(in string: String, options: NSRegularExpression.MatchingOptions = x, range: NSRange) -> [NSTextCheckingResult] {}
public func numberOfMatches(in string: String, options: NSRegularExpression.MatchingOptions = x, range: NSRange) -> Int {}
public func rangeOfFirstMatch(in string: String, options: NSRegularExpression.MatchingOptions = x, range: NSRange) -> NSRange {}
public func replaceMatches(in string: NSMutableString, options: NSRegularExpression.MatchingOptions = x, range: NSRange, withTemplate templ: String) -> Int {}
public func replacementString(for result: NSTextCheckingResult, in string: String, offset: Int, template templ: String) -> String {}
public func stringByReplacingMatches(in string: String, options: NSRegularExpression.MatchingOptions = x, range: NSRange, withTemplate templ: String) -> String {}
}
open class NSSet {
public static var supportsSecureCoding: Bool { get }
public convenience init() {}
public convenience init(array: [Any]) {}
public required convenience init?(coder aDecoder: NSCoder) {}
public convenience init(object: Any) {}
public init(objects: UnsafePointer<AnyObject>!, count cnt: Int) {}
public convenience init(set: Set<AnyHashable>) {}
public convenience init(set: Set<AnyHashable>, copyItems flag: Bool) {}
open var allObjects: [Any] { get }
open var count: Int { get }
public var customMirror: Mirror { get }
open var hash: Int { get }
open func adding(_ anObject: Any) -> Set<AnyHashable> {}
open func addingObjects(from other: Set<AnyHashable>) -> Set<AnyHashable> {}
open func anyObject() -> Any? {}
open func contains(_ anObject: Any) -> Bool {}
open func copy() -> Any {}
open func copy(with zone: NSZone? = x) -> Any {}
open func description(withLocale locale: Locale?) -> String {}
open func encode(with aCoder: NSCoder) {}
open func enumerateObjects(_ block: (Any, UnsafeMutablePointer<ObjCBool>) -> Swift.Void) {}
open func enumerateObjects(options opts: NSEnumerationOptions = x, using block: (Any, UnsafeMutablePointer<ObjCBool>) -> Swift.Void) {}
open func filtered(using predicate: NSPredicate) -> Set<AnyHashable> {}
open func intersects(_ otherSet: Set<AnyHashable>) -> Bool {}
open func isEqual(_ value: Any?) -> Bool {}
open func isEqual(to otherSet: Set<AnyHashable>) -> Bool {}
open func isSubset(of otherSet: Set<AnyHashable>) -> Bool {}
public func makeIterator() -> Iterator {}
open func member(_ object: Any) -> Any? {}
open func mutableCopy() -> Any {}
open func mutableCopy(with zone: NSZone? = x) -> Any {}
open func objectEnumerator() -> NSEnumerator {}
open func objects(options opts: NSEnumerationOptions = x, passingTest predicate: (Any, UnsafeMutablePointer<ObjCBool>) -> Bool) -> Set<AnyHashable> {}
open func objects(passingTest predicate: (Any, UnsafeMutablePointer<ObjCBool>) -> Bool) -> Set<AnyHashable> {}
public func sortedArray(using sortDescriptors: [NSSortDescriptor]) -> [Any] {}
}
open class NSSortDescriptor {
public init(key: String?, ascending: Bool) {}
public init(key: String?, ascending: Bool, comparator cmptr: Comparator) {}
public convenience init<Root, Value>(keyPath: KeyPath<Root, Value>, ascending: Bool) {}
public convenience init<Root, Value>(keyPath: KeyPath<Root, Value>, ascending: Bool, comparator cmptr: @escaping Comparator) {}
open var ascending: Bool { get }
open var comparator: Comparator { get }
open var key: String? { get }
public var keyPath: AnyKeyPath? { get }
open var reversedSortDescriptor: Any { get }
open func allowEvaluation() {}
open func compare(_ object1: Any, to object2: Any) -> ComparisonResult {}
}
open class NSString {
open class var availableStringEncodings: UnsafePointer<UInt> { get }
open class var defaultCStringEncoding: UInt { get }
public static var supportsSecureCoding: Bool { get }
open class func localizedName(of encoding: UInt) -> String {}
public static func pathWithComponents(_ components: [String]) -> String {}
public convenience init() {}
public convenience init?(bytes: UnsafeRawPointer, length len: Int, encoding: UInt) {}
public convenience init?(bytesNoCopy bytes: UnsafeMutableRawPointer, length len: Int, encoding: UInt, freeWhenDone freeBuffer: Bool) {}
public convenience init?(cString nullTerminatedCString: UnsafePointer<Int8>, encoding: UInt) {}
public init(characters: UnsafePointer<unichar>, length: Int) {}
public convenience init(charactersNoCopy characters: UnsafeMutablePointer<unichar>, length: Int, freeWhenDone freeBuffer: Bool) {}
public required convenience init?(coder aDecoder: NSCoder) {}
public convenience init(contentsOf url: URL, encoding enc: UInt) throws {}
public convenience init(contentsOf url: URL, usedEncoding enc: UnsafeMutablePointer<UInt>?) throws {}
public convenience init(contentsOfFile path: String, encoding enc: UInt) throws {}
public convenience init(contentsOfFile path: String, usedEncoding enc: UnsafeMutablePointer<UInt>?) throws {}
public convenience init?(data: Data, encoding: UInt) {}
public required convenience init(extendedGraphemeClusterLiteral value: StaticString) {}
public convenience init(format: NSString, _ args: CVarArg...) {}
public convenience init(format: String, arguments argList: CVaListPointer) {}
public convenience init(format: String, locale: AnyObject?, arguments argList: CVaListPointer) {}
public required convenience init(string aString: String) {}
public required init(stringLiteral value: StaticString) {}
public required convenience init(unicodeScalarLiteral value: StaticString) {}
public convenience init?(utf8String nullTerminatedCString: UnsafePointer<Int8>) {}
public var boolValue: Bool { get }
public var capitalized: String { get }
open var decomposedStringWithCanonicalMapping: String { get }
open var decomposedStringWithCompatibilityMapping: String { get }
public var deletingLastPathComponent: String { get }
public var deletingPathExtension: String { get }
open var description: String { get }
public var doubleValue: Double { get }
public var expandingTildeInPath: String { get }
public var fastestEncoding: UInt { get }
public var fileSystemRepresentation: UnsafePointer<Int8> { get }
public var floatValue: Float { get }
open var hash: Int { get }
public var intValue: Int32 { get }
public var integerValue: Int { get }
public var isAbsolutePath: Bool { get }
public var lastPathComponent: String { get }
open var length: Int { get }
public var localizedCapitalized: String { get }
public var localizedLowercase: String { get }
public var localizedUppercase: String { get }
public var longLongValue: Int64 { get }
public var lowercased: String { get }
public var pathComponents: [String] { get }
public var pathExtension: String { get }
open var precomposedStringWithCanonicalMapping: String { get }
open var precomposedStringWithCompatibilityMapping: String { get }
open var removingPercentEncoding: String? { get }
public var resolvingSymlinksInPath: String { get }
public var smallestEncoding: UInt { get }
public var standardizingPath: String { get }
public var uppercased: String { get }
public var utf8String: UnsafePointer<Int8>? { get }
open func addingPercentEncoding(withAllowedCharacters allowedCharacters: CharacterSet) -> String? {}
public func appending(_ aString: String) -> String {}
public func appendingPathComponent(_ str: String) -> String {}
public func appendingPathExtension(_ str: String) -> String? {}
open func applyingTransform(_ transform: String, reverse: Bool) -> String? {}
public func cString(using encoding: UInt) -> UnsafePointer<Int8>? {}
public func canBeConverted(to encoding: UInt) -> Bool {}
public func capitalized(with locale: Locale?) -> String {}
public func caseInsensitiveCompare(_ string: String) -> ComparisonResult {}
open func character(at index: Int) -> unichar {}
public func commonPrefix(with str: String, options mask: CompareOptions = x) -> String {}
public func compare(_ string: String) -> ComparisonResult {}
public func compare(_ string: String, options mask: CompareOptions) -> ComparisonResult {}
public func compare(_ string: String, options mask: CompareOptions, range compareRange: NSRange) -> ComparisonResult {}
public func compare(_ string: String, options mask: CompareOptions, range compareRange: NSRange, locale: Any?) -> ComparisonResult {}
public func completePath(into outputName: inout String?, caseSensitive flag: Bool, matchesInto outputArray: inout [String], filterTypes: [String]?) -> Int {}
open func components(separatedBy separator: CharacterSet) -> [String] {}
public func contains(_ str: String) -> Bool {}
open func copy() -> Any {}
open func copy(with zone: NSZone? = x) -> Any {}
public func data(using encoding: UInt) -> Data? {}
public func data(using encoding: UInt, allowLossyConversion lossy: Bool = x) -> Data? {}
open func encode(with aCoder: NSCoder) {}
public func enumerateLines(_ block: (String, UnsafeMutablePointer<ObjCBool>) -> Void) {}
public func enumerateSubstrings(in range: NSRange, options opts: EnumerationOptions = x, using block: (String?, NSRange, NSRange, UnsafeMutablePointer<ObjCBool>) -> Void) {}
open func folding(options: CompareOptions = x, locale: Locale?) -> String {}
public func getBytes(_ buffer: UnsafeMutableRawPointer?, maxLength maxBufferCount: Int, usedLength usedBufferCount: UnsafeMutablePointer<Int>?, encoding: UInt, options: EncodingConversionOptions = x, range: NSRange, remaining leftover: NSRangePointer?) -> Bool {}
public func getCString(_ buffer: UnsafeMutablePointer<Int8>, maxLength maxBufferCount: Int, encoding: UInt) -> Bool {}
public func getCharacters(_ buffer: UnsafeMutablePointer<unichar>, range: NSRange) {}
public func getFileSystemRepresentation(_ cname: UnsafeMutablePointer<Int8>, maxLength max: Int) -> Bool {}
public func getLineStart(_ startPtr: UnsafeMutablePointer<Int>?, end lineEndPtr: UnsafeMutablePointer<Int>?, contentsEnd contentsEndPtr: UnsafeMutablePointer<Int>?, for range: NSRange) {}
public func getParagraphStart(_ startPtr: UnsafeMutablePointer<Int>?, end parEndPtr: UnsafeMutablePointer<Int>?, contentsEnd contentsEndPtr: UnsafeMutablePointer<Int>?, for range: NSRange) {}
public func hasPrefix(_ str: String) -> Bool {}
public func hasSuffix(_ str: String) -> Bool {}
open func isEqual(_ object: Any?) -> Bool {}
public func isEqual(to aString: String) -> Bool {}
public func lengthOfBytes(using enc: UInt) -> Int {}
public func lineRange(for range: NSRange) -> NSRange {}
public func localizedCaseInsensitiveCompare(_ string: String) -> ComparisonResult {}
public func localizedCaseInsensitiveContains(_ str: String) -> Bool {}
public func localizedCompare(_ string: String) -> ComparisonResult {}
public func localizedStandardCompare(_ string: String) -> ComparisonResult {}
public func localizedStandardContains(_ str: String) -> Bool {}
public func localizedStandardRange(of str: String) -> NSRange {}
public func lowercased(with locale: Locale?) -> String {}
public func maximumLengthOfBytes(using enc: UInt) -> Int {}
open func mutableCopy() -> Any {}
open func mutableCopy(with zone: NSZone? = x) -> Any {}
open func padding(toLength newLength: Int, withPad padString: String, startingAt padIndex: Int) -> String {}
public func paragraphRange(for range: NSRange) -> NSRange {}
public func range(of searchString: String) -> NSRange {}
public func range(of searchString: String, options mask: CompareOptions = x) -> NSRange {}
public func range(of searchString: String, options mask: CompareOptions = x, range searchRange: NSRange) -> NSRange {}
public func range(of searchString: String, options mask: CompareOptions = x, range searchRange: NSRange, locale: Locale?) -> NSRange {}
public func rangeOfCharacter(from searchSet: CharacterSet) -> NSRange {}
public func rangeOfCharacter(from searchSet: CharacterSet, options mask: CompareOptions = x) -> NSRange {}
public func rangeOfCharacter(from searchSet: CharacterSet, options mask: CompareOptions = x, range searchRange: NSRange) -> NSRange {}
public func rangeOfComposedCharacterSequence(at index: Int) -> NSRange {}
public func rangeOfComposedCharacterSequences(for range: NSRange) -> NSRange {}
open func replacingCharacters(in range: NSRange, with replacement: String) -> String {}
open func replacingOccurrences(of target: String, with replacement: String) -> String {}
open func replacingOccurrences(of target: String, with replacement: String, options: CompareOptions = x, range searchRange: NSRange) -> String {}
public func stringsByAppendingPaths(_ paths: [String]) -> [String] {}
public func substring(from: Int) -> String {}
public func substring(to: Int) -> String {}
public func substring(with range: NSRange) -> String {}
open func trimmingCharacters(in set: CharacterSet) -> String {}
public func uppercased(with locale: Locale?) -> String {}
open func write(to url: URL, atomically useAuxiliaryFile: Bool, encoding enc: UInt) throws {}
open func write(toFile path: String, atomically useAuxiliaryFile: Bool, encoding enc: UInt) throws {}
}
open class NSTextCheckingResult {
open class func regularExpressionCheckingResultWithRanges(_ ranges: NSRangePointer, count: Int, regularExpression: NSRegularExpression) -> NSTextCheckingResult {}
open var numberOfRanges: Int { get }
open var range: NSRange { get }
open var regularExpression: NSRegularExpression? { get }
open var resultType: CheckingType { get }
public func adjustingRanges(offset: Int) -> NSTextCheckingResult {}
open func range(at idx: Int) -> NSRange {}
}
open class NSTimeZone {
open class var abbreviationDictionary: [String: String] { get set }
open class var default: TimeZone { get set }
open class var knownTimeZoneNames: [String] { get }
open class var local: TimeZone { get }
open class var system: TimeZone { get }
open class var timeZoneDataVersion: String { get }
open class func resetSystemTimeZone() {}
public convenience init?(abbreviation: String) {}
public convenience init(forSecondsFromGMT seconds: Int) {}
public convenience init?(name tzName: String) {}
public init?(name tzName: String, data aData: Data?) {}
open var abbreviation: String? { get }
open var data: Data { get }
open var daylightSavingTimeOffset: TimeInterval { get }
open var isDaylightSavingTime: Bool { get }
open var name: String { get }
open var nextDaylightSavingTimeTransition: Date? { get }
open var secondsFromGMT: Int { get }
open func abbreviation(for aDate: Date) -> String? {}
open func daylightSavingTimeOffset(for aDate: Date) -> TimeInterval {}
open func isDaylightSavingTime(for aDate: Date) -> Bool {}
open func isEqual(to aTimeZone: TimeZone) -> Bool {}
open func localizedName(_ style: NameStyle, locale: Locale?) -> String? {}
open func nextDaylightSavingTimeTransition(after aDate: Date) -> Date? {}
open func secondsFromGMT(for aDate: Date) -> Int {}
}
open class NSURL {
open class func fileURL(withPathComponents components: [String]) -> URL? {}
public init(absoluteURLWithDataRepresentation data: Data, relativeTo baseURL: URL?) {}
public init(dataRepresentation data: Data, relativeTo baseURL: URL?) {}
public convenience init(fileURLWithFileSystemRepresentation path: UnsafePointer<Int8>, isDirectory isDir: Bool, relativeTo baseURL: URL?) {}
public init(fileURLWithPath path: String) {}
public convenience init(fileURLWithPath path: String, isDirectory isDir: Bool) {}
public init(fileURLWithPath path: String, isDirectory isDir: Bool, relativeTo baseURL: URL?) {}
public convenience init(fileURLWithPath path: String, relativeTo baseURL: URL?) {}
public convenience init?(string URLString: String) {}
public init?(string URLString: String, relativeTo baseURL: URL?) {}
open var absoluteString: String { get }
open var absoluteURL: URL? { get }
open var baseURL: URL? { get }
open var dataRepresentation: Data { get }
open var deletingLastPathComponent: URL? { get }
open var deletingPathExtension: URL? { get }
open var filePathURL: URL? { get }
open var fileSystemRepresentation: UnsafePointer<Int8> { get }
open var fragment: String? { get }
open var hasDirectoryPath: Bool { get }
open var host: String? { get }
open var isFileURL: Bool { get }
open var lastPathComponent: String? { get }
open var parameterString: String? { get }
open var password: String? { get }
open var path: String? { get }
open var pathComponents: [String]? { get }
open var pathExtension: String? { get }
open var port: NSNumber? { get }
open var query: String? { get }
open var relativePath: String? { get }
open var relativeString: String { get }
open var resolvingSymlinksInPath: URL? { get }
open var resourceSpecifier: String? { get }
open var scheme: String? { get }
open var standardized: URL? { get }
open var standardizingPath: URL? { get }
open var user: String? { get }
open func appendingPathComponent(_ pathComponent: String) -> URL? {}
open func appendingPathComponent(_ pathComponent: String, isDirectory: Bool) -> URL? {}
open func appendingPathExtension(_ pathExtension: String) -> URL? {}
open func checkResourceIsReachable() throws -> Bool {}
open func getFileSystemRepresentation(_ buffer: UnsafeMutablePointer<Int8>, maxLength maxBufferLength: Int) -> Bool {}
open func removeAllCachedResourceValues() {}
open func removeCachedResourceValue(forKey key: URLResourceKey) {}
open func resourceValues(forKeys keys: [URLResourceKey]) throws -> [URLResourceKey: Any] {}
open func setResourceValue(_ value: Any?, forKey key: URLResourceKey) throws {}
open func setResourceValues(_ keyedValues: [URLResourceKey: Any]) throws {}
open func setTemporaryResourceValue(_ value: Any?, forKey key: URLResourceKey) {}
}
open class NSURLComponents {
public init?(string URLString: String) {}
public init?(url: URL, resolvingAgainstBaseURL resolve: Bool) {}
open var fragment: String? { get set }
open var host: String? { get set }
open var password: String? { get set }
open var path: String? { get set }
open var percentEncodedFragment: String? { get set }
open var percentEncodedHost: String? { get set }
open var percentEncodedPassword: String? { get set }
open var percentEncodedPath: String? { get set }
open var percentEncodedQuery: String? { get set }
open var percentEncodedUser: String? { get set }
open var port: NSNumber? { get set }
open var query: String? { get set }
open var queryItems: [URLQueryItem]? { get set }
open var rangeOfFragment: NSRange { get }
open var rangeOfHost: NSRange { get }
open var rangeOfPassword: NSRange { get }
open var rangeOfPath: NSRange { get }
open var rangeOfPort: NSRange { get }
open var rangeOfQuery: NSRange { get }
open var rangeOfScheme: NSRange { get }
open var rangeOfUser: NSRange { get }
open var scheme: String? { get set }
open var string: String? { get }
open var url: URL? { get }
open var user: String? { get set }
open func url(relativeTo baseURL: URL?) -> URL? {}
}
open class NSURLQueryItem {
public init(name: String, value: String?) {}
open var name: String { get }
open var value: String? { get }
}
open class NSURLRequest {
public convenience init(url: URL) {}
public init(url: URL, cachePolicy: NSURLRequest.CachePolicy, timeoutInterval: TimeInterval) {}
open var allHTTPHeaderFields: [String: String]? { get }
open var allowsCellularAccess: Bool { get }
open var cachePolicy: CachePolicy { get }
open var httpBody: Data? { get }
open var httpBodyStream: InputStream? { get }
open var httpMethod: String? { get }
open var httpShouldHandleCookies: Bool { get }
open var httpShouldUsePipelining: Bool { get }
open var mainDocumentURL: URL? { get }
open var networkServiceType: NetworkServiceType { get }
open var timeoutInterval: TimeInterval { get }
open var url: URL? { get }
open func value(forHTTPHeaderField field: String) -> String? {}
}
open class NSUUID {
public init(uuidBytes bytes: UnsafePointer<UInt8>) {}
public convenience init?(uuidString string: String) {}
open var uuidString: String { get }
open func getBytes(_ uuid: UnsafeMutablePointer<UInt8>) {}
}
open class NSValue {
public required convenience init(bytes value: UnsafeRawPointer, objCType type: UnsafePointer<Int8>) {}
public convenience init(edgeInsets insets: NSEdgeInsets) {}
public convenience init(point: NSPoint) {}
#if DEPLOYMENT_RUNTIME_SWIFT
public convenience init(range: NSRange) {}
#endif
public convenience init(rect: NSRect) {}
public convenience init(size: NSSize) {}
public var edgeInsetsValue: NSEdgeInsets { get }
open var objCType: UnsafePointer<Int8> { get }
public var pointValue: NSPoint { get }
#if DEPLOYMENT_RUNTIME_SWIFT
public var rangeValue: NSRange { get }
#endif
public var rectValue: NSRect { get }
public var sizeValue: NSSize { get }
open func getValue(_ value: UnsafeMutableRawPointer) {}
}
open class NotificationCenter {
open class var default: NotificationCenter { get }
open func addObserver(forName name: NSNotification.Name?, object obj: Any?, queue: OperationQueue?, using block: @escaping (Notification) -> Void) -> NSObjectProtocol {}
open func post(_ notification: Notification) {}
open func post(name aName: NSNotification.Name, object anObject: Any?, userInfo aUserInfo: [AnyHashable: Any]? = x) {}
open func removeObserver(_ observer: Any) {}
open func removeObserver(_ observer: Any, name aName: NSNotification.Name?, object: Any?) {}
}
open class NotificationQueue {
open class var default: NotificationQueue { get }
public init(notificationCenter: NotificationCenter) {}
open func dequeueNotifications(matching notification: Notification, coalesceMask: NotificationCoalescing) {}
open func enqueue(_ notification: Notification, postingStyle: PostingStyle) {}
open func enqueue(_ notification: Notification, postingStyle: PostingStyle, coalesceMask: NotificationCoalescing, forModes modes: [RunLoopMode]?) {}
}
open class NumberFormatter {
open class func localizedString(from num: NSNumber, number nstyle: Style) -> String {}
open var allowsFloats: Bool { get set }
open var alwaysShowsDecimalSeparator: Bool { get set }
open var attributedStringForNil: NSAttributedString { get set }
open var attributedStringForNotANumber: NSAttributedString { get set }
open var attributedStringForZero: NSAttributedString { get set }
open var currencyCode: String! { get set }
open var currencyDecimalSeparator: String! { get set }
open var currencyGroupingSeparator: String! { get set }
open var currencySymbol: String! { get set }
open var decimalSeparator: String! { get set }
open var exponentSymbol: String! { get set }
open var format: String { get set }
open var formatWidth: Int { get set }
open var formattingContext: Context { get set }
open var generatesDecimalNumbers: Bool { get set }
open var groupingSeparator: String! { get set }
open var groupingSize: Int { get set }
open var hasThousandSeparators: Bool { get set }
open var internationalCurrencySymbol: String! { get set }
open var isLenient: Bool { get set }
open var isPartialStringValidationEnabled: Bool { get set }
open var locale: Locale! { get set }
open var localizesFormat: Bool { get set }
open var maximum: NSNumber? { get set }
open var maximumFractionDigits: Int { get set }
open var maximumIntegerDigits: Int { get set }
open var maximumSignificantDigits: Int { get set }
open var minimum: NSNumber? { get set }
open var minimumFractionDigits: Int { get set }
open var minimumIntegerDigits: Int { get set }
open var minimumSignificantDigits: Int { get set }
open var minusSign: String! { get set }
open var multiplier: NSNumber? { get set }
open var negativeFormat: String! { get set }
open var negativeInfinitySymbol: String { get set }
open var negativePrefix: String! { get set }
open var negativeSuffix: String! { get set }
open var nilSymbol: String { get set }
open var notANumberSymbol: String! { get set }
open var numberStyle: Style { get set }
open var paddingCharacter: String! { get set }
open var paddingPosition: PadPosition { get set }
open var perMillSymbol: String! { get set }
open var percentSymbol: String! { get set }
open var plusSign: String! { get set }
open var positiveFormat: String! { get set }
open var positiveInfinitySymbol: String { get set }
open var positivePrefix: String! { get set }
open var positiveSuffix: String! { get set }
open var roundingBehavior: NSDecimalNumberHandler { get set }
open var roundingIncrement: NSNumber! { get set }
open var roundingMode: RoundingMode { get set }
open var secondaryGroupingSize: Int { get set }
open var textAttributesForNegativeInfinity: [String: Any]? { get set }
open var textAttributesForNegativeValues: [String: Any]? { get set }
open var textAttributesForNil: [String: Any]? { get set }
open var textAttributesForNotANumber: [String: Any]? { get set }
open var textAttributesForPositiveInfinity: [String: Any]? { get set }
open var textAttributesForPositiveValues: [String: Any]? { get set }
open var textAttributesForZero: [String: Any]? { get set }
open var thousandSeparator: String! { get set }
open var usesGroupingSeparator: Bool { get set }
open var usesSignificantDigits: Bool { get set }
open var zeroSymbol: String? { get set }
open func number(from string: String) -> NSNumber? {}
open func objectValue(_ string: String, range: inout NSRange) throws -> Any? {}
open func string(from number: NSNumber) -> String? {}
}
open class Operation {
public init() {}
public var completionBlock: (() -> Void)? { get set }
open var dependencies: [Operation] { get }
open var isAsynchronous: Bool { get }
open var isCancelled: Bool { get }
open var isExecuting: Bool { get }
open var isFinished: Bool { get }
open var isReady: Bool { get }
open var name: String? { get set }
open var qualityOfService: QualityOfService { get set }
open var queuePriority: QueuePriority { get set }
open var threadPriority: Double { get set }
open func addDependency(_ op: Operation) {}
open func cancel() {}
public func didChangeValue(forKey key: String) {}
open func main() {}
open func removeDependency(_ op: Operation) {}
open func start() {}
open func waitUntilFinished() {}
public func willChangeValue(forKey key: String) {}
}
open class OperationQueue {
open class var current: OperationQueue? { get }
public static var defaultMaxConcurrentOperationCount: Int { get }
open class var main: OperationQueue { get }
open var isSuspended: Bool { get set }
open var maxConcurrentOperationCount: Int { get set }
open var name: String? { get set }
open var operationCount: Int { get }
open var operations: [Operation] { get }
open var qualityOfService: QualityOfService { get set }
#if DEPLOYMENT_ENABLE_LIBDISPATCH
open var underlyingQueue: DispatchQueue? { get set }
#endif
open func addOperation(_ block: @escaping () -> Swift.Void) {}
open func addOperations(_ ops: [Operation], waitUntilFinished wait: Bool) {}
open func cancelAllOperations() {}
open func waitUntilAllOperationsAreFinished() {}
}
open class OutputStream {
open class func toMemory() -> Self {}
public init(toBuffer buffer: UnsafeMutablePointer<UInt8>, capacity: Int) {}
public convenience init?(toFileAtPath path: String, append shouldAppend: Bool) {}
public required init(toMemory: Void) {}
public init?(url: URL, append shouldAppend: Bool) {}
open var hasSpaceAvailable: Bool { get }
open func write(_ buffer: UnsafePointer<UInt8>, maxLength len: Int) -> Int {}
}
open class PersonNameComponentsFormatter {
open class func localizedString(from components: PersonNameComponents, style nameFormatStyle: Style, options nameOptions: Options = x) -> String {}
open var isPhonetic: Bool { get set }
open var style: Style { get set }
open func annotatedString(from components: PersonNameComponents) -> NSAttributedString {}
open func personNameComponents(from string: String) -> PersonNameComponents? {}
open func string(from components: PersonNameComponents) -> String {}
}
open class Pipe {
public var fileHandleForReading: FileHandle { get }
public var fileHandleForWriting: FileHandle { get }
}
open class Port {
public static var didBecomeInvalidNotification { get }
open var isValid: Bool { get }
open var reservedSpaceLength: Int { get }
open func invalidate() {}
open func remove(from runLoop: RunLoop, forMode mode: RunLoopMode) {}
open func schedule(in runLoop: RunLoop, forMode mode: RunLoopMode) {}
open func sendBeforeDate(_ limitDate: Date, components: NSMutableArray?, from receivePort: Port?, reserved headerSpaceReserved: Int) -> Bool {}
open func sendBeforeDate(_ limitDate: Date, msgid msgID: Int, components: NSMutableArray?, from receivePort: Port?, reserved headerSpaceReserved: Int) -> Bool {}
}
open class PortMessage {
public init(sendPort: Port?, receivePort replyPort: Port?, components: [AnyObject]?) {}
open var components: [AnyObject]? { get }
open var msgid: UInt32 { get set }
open var receivePort: Port? { get }
open var sendPort: Port? { get }
open func sendBeforeDate(_ date: Date) -> Bool {}
}
open class Process {
public static var didTerminateNotification { get }
open class func run(_ url: URL, arguments: [String], terminationHandler: ((Process) -> Void)? = x) throws -> Process {}
open var arguments: [String]? { get set }
open var currentDirectoryURL { get set }
open var environment: [String: String]? { get set }
open var executableURL: URL? { get set }
open var isRunning: Bool { get }
open var processIdentifier: Int32 { get }
open var qualityOfService: QualityOfService { get set }
open var standardError: Any? { get }
open var standardInput: Any? { get }
open var standardOutput: Any? { get }
open var terminationHandler: ((Process) -> Void)? { get set }
public var terminationReason: TerminationReason { get }
public var terminationStatus: Int32 { get }
open func interrupt() {}
open func resume() -> Bool {}
open func run() throws {}
open func suspend() -> Bool {}
open func terminate() {}
open func waitUntilExit() {}
}
open class ProcessInfo {
public static var processInfo { get }
open var activeProcessorCount: Int { get }
open var arguments: [String] { get }
open var environment: [String: String] { get }
open var fullUserName: String { get }
open var globallyUniqueString: String { get }
open var hostName: String { get }
open var operatingSystemVersion: OperatingSystemVersion { get }
open var operatingSystemVersionString: String { get }
open var physicalMemory: UInt64 { get }
open var processIdentifier: Int32 { get }
open var processName: String { get set }
open var processorCount: Int { get }
open var systemUptime: TimeInterval { get }
open var userName: String { get }
open func isOperatingSystemAtLeast(_ version: OperatingSystemVersion) -> Bool {}
}
open class Progress {
open class func current() -> Progress? {}
open class func discreteProgress(totalUnitCount unitCount: Int64) -> Progress {}
public init(parent parentProgress: Progress?, userInfo userInfoOrNil: [ProgressUserInfoKey: Any]? = x) {}
public convenience init(totalUnitCount unitCount: Int64) {}
public convenience init(totalUnitCount unitCount: Int64, parent: Progress, pendingUnitCount portionOfParentTotalUnitCount: Int64) {}
open var cancellationHandler: (() -> Void)? { get }
open var completedUnitCount: Int64 { get set }
public var fractionCompleted: Double { get }
open var isCancellable: Bool { get set }
open var isCancelled: Bool { get set }
open var isFinished: Bool { get }
open var isIndeterminate: Bool { get }
open var isPausable: Bool { get set }
open var isPaused: Bool { get set }
open var kind: ProgressKind? { get set }
open var localizedAdditionalDescription: String! { get }
open var localizedDescription: String! { get }
open var pausingHandler: (() -> Void)? { get }
open var resumingHandler: (() -> Void)? { get set }
open var totalUnitCount: Int64 { get set }
open var userInfo: [ProgressUserInfoKey: Any] { get }
open func addChild(_ child: Progress, withPendingUnitCount inUnitCount: Int64) {}
open func becomeCurrent(withPendingUnitCount unitCount: Int64) {}
open func cancel() {}
open func pause() {}
open func resignCurrent() {}
open func resume() {}
open func setUserInfoObject(_ objectOrNil: Any?, forKey key: ProgressUserInfoKey) {}
}
open class PropertyListSerialization {
open class func data(fromPropertyList plist: Any, format: PropertyListFormat, options opt: WriteOptions) throws -> Data {}
open class func propertyList(_ plist: Any, isValidFor format: PropertyListFormat) -> Bool {}
open class func propertyList(from data: Data, options opt: ReadOptions = x, format: UnsafeMutablePointer<PropertyListFormat>?) throws -> Any {}
open class func propertyList(with stream: InputStream, options opt: ReadOptions = x, format: UnsafeMutablePointer<PropertyListFormat>?) throws -> Any {}
}
open class RunLoop {
open class var current: RunLoop { get }
open class var main: RunLoop { get }
open var currentMode: RunLoopMode? { get }
open func acceptInput(forMode mode: String, before limitDate: Date) {}
open func add(_ aPort: Port, forMode mode: RunLoopMode) {}
open func getCFRunLoop() -> CFRunLoop {}
open func limitDate(forMode mode: RunLoopMode) -> Date? {}
public func perform(_ block: @escaping () -> Void) {}
public func perform(inModes modes: [RunLoopMode], block: @escaping () -> Void) {}
open func remove(_ aPort: Port, forMode mode: RunLoopMode) {}
public func run() {}
public func run(mode: RunLoopMode, before limitDate: Date) -> Bool {}
public func run(until limitDate: Date) {}
}
open class Scanner {
open class func localizedScannerWithString(_ string: String) -> AnyObject {}
public init(string: String) {}
open var caseSensitive: Bool { get set }
open var charactersToBeSkipped: CharacterSet? { get set }
public var isAtEnd: Bool { get }
open var locale: Locale? { get set }
open var scanLocation: Int { get set }
open var string: String { get }
public func scanCharactersFromSet(_ set: CharacterSet) -> String? {}
public func scanDecimal() -> Decimal? {}
public func scanDecimal(_ dcm: inout Decimal) -> Bool {}
public func scanDouble() -> Double? {}
@discardableResult public func scanDouble(_ result: UnsafeMutablePointer<Double>) -> Bool {}
public func scanFloat() -> Float? {}
@discardableResult public func scanFloat(_ result: UnsafeMutablePointer<Float>) -> Bool {}
public func scanHexDouble() -> Double? {}
@discardableResult public func scanHexDouble(_ result: UnsafeMutablePointer<Double>) -> Bool {}
public func scanHexFloat() -> Float? {}
@discardableResult public func scanHexFloat(_ result: UnsafeMutablePointer<Float>) -> Bool {}
public func scanHexInt32() -> UInt32? {}
@discardableResult public func scanHexInt32(_ result: UnsafeMutablePointer<UInt32>) -> Bool {}
public func scanHexInt64() -> UInt64? {}
@discardableResult public func scanHexInt64(_ result: UnsafeMutablePointer<UInt64>) -> Bool {}
public func scanInt() -> Int? {}
@discardableResult public func scanInt(_ result: UnsafeMutablePointer<Int>) -> Bool {}
public func scanInt32() -> Int32? {}
@discardableResult public func scanInt32(_ result: UnsafeMutablePointer<Int32>) -> Bool {}
public func scanInt64() -> Int64? {}
@discardableResult public func scanInt64(_ result: UnsafeMutablePointer<Int64>) -> Bool {}
public func scanString(_ searchString: String) -> String? {}
@discardableResult public func scanString(_ string: String, into ptr: UnsafeMutablePointer<String?>?) -> Bool {}
public func scanUnsignedLongLong() -> UInt64? {}
@discardableResult public func scanUnsignedLongLong(_ result: UnsafeMutablePointer<UInt64>) -> Bool {}
@discardableResult public func scanUpToCharacters(from set: CharacterSet, into ptr: UnsafeMutablePointer<String?>?) -> Bool {}
public func scanUpToCharactersFromSet(_ set: CharacterSet) -> String? {}
public func scanUpToString(_ string: String) -> String? {}
}
open class SocketPort {
public init?(protocolFamily family: Int32, socketType type: Int32, protocol: Int32, address: Data) {}
public init?(protocolFamily family: Int32, socketType type: Int32, protocol: Int32, socket sock: SocketNativeHandle) {}
public init(remoteWithProtocolFamily family: Int32, socketType type: Int32, protocol: Int32, address: Data) {}
public convenience init?(remoteWithTCPPort port: UInt16, host hostName: String?) {}
public convenience init?(tcpPort port: UInt16) {}
open var address: Data { get }
open var protocol: Int32 { get }
open var protocolFamily: Int32 { get }
open var socket: SocketNativeHandle { get }
open var socketType: Int32 { get }
}
open class Stream {
#if false
open class func getBoundStreams(withBufferSize bufferSize: Int, inputStream: AutoreleasingUnsafeMutablePointer<InputStream?>?, outputStream: AutoreleasingUnsafeMutablePointer<OutputStream?>?) {}
#endif
#if false
open class func getStreamsToHost(withName hostname: String, port: Int, inputStream: AutoreleasingUnsafeMutablePointer<InputStream?>?, outputStream: AutoreleasingUnsafeMutablePointer<OutputStream?>?) {}
#endif
open weak var delegate: StreamDelegate? { get set }
open var streamError: Error? { get }
open var streamStatus: Status { get }
open func close() {}
open func open() {}
open func property(forKey key: PropertyKey) -> AnyObject? {}
open func remove(from aRunLoop: RunLoop, forMode mode: RunLoopMode) {}
open func schedule(in aRunLoop: RunLoop, forMode mode: RunLoopMode) {}
open func setProperty(_ property: AnyObject?, forKey key: PropertyKey) -> Bool {}
}
open class Thread {
open class var callStackReturnAddresses: [NSNumber] { get }
open class var callStackSymbols: [String] { get }
open class var current: Thread { get }
open class var isMainThread: Bool { get }
open class var mainThread: Thread { get }
open class func detachNewThread(_ block: @escaping () -> Swift.Void) {}
open class func exit() {}
open class func isMultiThreaded() -> Bool {}
open class func sleep(forTimeInterval interval: TimeInterval) {}
open class func sleep(until date: Date) {}
public convenience init(block: @escaping () -> Swift.Void) {}
open var isCancelled: Bool { get }
open var isExecuting: Bool { get }
open var isFinished: Bool { get }
open var isMainThread: Bool { get }
open var name: String? { get }
open var stackSize: Int { get set }
open var threadDictionary: NSMutableDictionary { get }
open func cancel() {}
open func main() {}
open func start() {}
}
open class Timer {
open class func scheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping (Timer) -> Void) -> Timer {}
public init(fire date: Date, interval: TimeInterval, repeats: Bool, block: @escaping (Timer) -> Swift.Void) {}
public convenience init(timeInterval interval: TimeInterval, repeats: Bool, block: @escaping (Timer) -> Swift.Void) {}
open var fireDate: Date { get set }
open var isValid: Bool { get }
open var timeInterval: TimeInterval { get }
open var tolerance: TimeInterval { get set }
open var userInfo: Any? { get }
open func fire() {}
open func invalidate() {}
}
open class URLAuthenticationChallenge {
public init(authenticationChallenge challenge: URLAuthenticationChallenge, sender: URLAuthenticationChallengeSender) {}
public init(protectionSpace space: URLProtectionSpace, proposedCredential credential: URLCredential?, previousFailureCount: Int, failureResponse response: URLResponse?, error: Error?, sender: URLAuthenticationChallengeSender) {}
open var error: Error? { get }
open var failureResponse: URLResponse? { get }
open var previousFailureCount: Int { get }
open var proposedCredential: URLCredential? { get }
open var protectionSpace: URLProtectionSpace { get }
open var sender: URLAuthenticationChallengeSender? { get }
}
open class URLCache {
open class var shared: URLCache { get set }
public init(memoryCapacity: Int, diskCapacity: Int, diskPath path: String?) {}
open var currentDiskUsage: Int { get }
open var currentMemoryUsage: Int { get }
open var diskCapacity: Int { get set }
open var memoryCapacity: Int { get set }
open func cachedResponse(for request: URLRequest) -> CachedURLResponse? {}
public func getCachedResponse(for dataTask: URLSessionDataTask, completionHandler: (CachedURLResponse?) -> Void) {}
open func removeAllCachedResponses() {}
public func removeCachedResponse(for dataTask: URLSessionDataTask) {}
open func removeCachedResponses(since date: Date) {}
public func storeCachedResponse(_ cachedResponse: CachedURLResponse, for dataTask: URLSessionDataTask) {}
}
open class URLCredential {
public init(user: String, password: String, persistence: Persistence) {}
open var hasPassword: Bool { get }
open var password: String? { get }
open var persistence: Persistence { get }
open var user: String? { get }
}
open class URLCredentialStorage {
open class var shared: URLCredentialStorage { get }
open var allCredentials: [URLProtectionSpace: [String: URLCredential]] { get }
open func credentials(for space: URLProtectionSpace) -> [String: URLCredential]? {}
open func defaultCredential(for space: URLProtectionSpace) -> URLCredential? {}
public func getCredentials(for protectionSpace: URLProtectionSpace, task: URLSessionTask, completionHandler: ([String: URLCredential]?) -> Void) {}
public func getDefaultCredential(for space: URLProtectionSpace, task: URLSessionTask, completionHandler: (URLCredential?) -> Void) {}
open func remove(_ credential: URLCredential, for space: URLProtectionSpace) {}
open func remove(_ credential: URLCredential, for space: URLProtectionSpace, options: [String: AnyObject]? = x) {}
public func remove(_ credential: URLCredential, for protectionSpace: URLProtectionSpace, options: [String: AnyObject]? = x, task: URLSessionTask) {}
open func set(_ credential: URLCredential, for space: URLProtectionSpace) {}
public func set(_ credential: URLCredential, for protectionSpace: URLProtectionSpace, task: URLSessionTask) {}
open func setDefaultCredential(_ credential: URLCredential, for space: URLProtectionSpace) {}
public func setDefaultCredential(_ credential: URLCredential, for protectionSpace: URLProtectionSpace, task: URLSessionTask) {}
}
open class URLProtectionSpace {
public init(host: String, port: Int, protocol: String?, realm: String?, authenticationMethod: String?) {}
public init(proxyHost host: String, port: Int, type: String?, realm: String?, authenticationMethod: String?) {}
open var authenticationMethod: String { get }
public var distinguishedNames: [Data]? { get }
open var host: String { get }
open var port: Int { get }
open var protocol: String? { get }
open var proxyType: String? { get }
open var realm: String? { get }
open var receivesCredentialSecurely: Bool { get }
}
open class URLProtocol {
open class func canInit(with request: URLRequest) -> Bool {}
open class func canonicalRequest(for request: URLRequest) -> URLRequest {}
open class func property(forKey key: String, in request: URLRequest) -> Any? {}
open class func registerClass(_ protocolClass: AnyClass) -> Bool {}
open class func removeProperty(forKey key: String, in request: NSMutableURLRequest) {}
open class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {}
open class func setProperty(_ value: Any, forKey key: String, in request: NSMutableURLRequest) {}
open class func unregisterClass(_ protocolClass: AnyClass) {}
public required init(request: URLRequest, cachedResponse: CachedURLResponse?, client: URLProtocolClient?) {}
public required convenience init(task: URLSessionTask, cachedResponse: CachedURLResponse?, client: URLProtocolClient?) {}
open var cachedResponse: CachedURLResponse? { get }
open var client: URLProtocolClient? { get set }
open var request: URLRequest { get }
open var task: URLSessionTask? { get set }
open func startLoading() {}
open func stopLoading() {}
}
open class URLResponse {
public static var supportsSecureCoding: Bool { get }
public required init?(coder aDecoder: NSCoder) {}
public init(url: URL, mimeType: String?, expectedContentLength length: Int, textEncodingName name: String?) {}
open var expectedContentLength: Int64 { get }
open var mimeType: String? { get }
open var suggestedFilename: String? { get }
open var textEncodingName: String? { get }
open var url: URL? { get }
open func copy() -> Any {}
open func copy(with zone: NSZone? = x) -> Any {}
open func encode(with aCoder: NSCoder) {}
}
open class URLSession {
open class var shared: URLSession { get }
public init(configuration: URLSessionConfiguration) {}
public init(configuration: URLSessionConfiguration, delegate: URLSessionDelegate?, delegateQueue queue: OperationQueue?) {}
open var configuration: URLSessionConfiguration { get }
open var delegate: URLSessionDelegate? { get set }
open var delegateQueue: OperationQueue { get }
open var sessionDescription: String? { get set }
open func dataTask(with request: URLRequest) -> URLSessionDataTask {}
open func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {}
open func downloadTask(with request: URLRequest) -> URLSessionDownloadTask {}
open func downloadTask(with request: URLRequest, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask {}
open func downloadTask(withResumeData resumeData: Data) -> URLSessionDownloadTask {}
open func downloadTask(withResumeData resumeData: Data, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask {}
open func finishTasksAndInvalidate() {}
open func flush(completionHandler: @escaping () -> Void) {}
open func getAllTasks(completionHandler: @escaping ([URLSessionTask]) -> Void) {}
open func getTasksWithCompletionHandler(completionHandler: @escaping ([URLSessionDataTask], [URLSessionUploadTask], [URLSessionDownloadTask]) -> Void) {}
open func invalidateAndCancel() {}
open func reset(completionHandler: @escaping () -> Void) {}
open func streamTask(withHostName hostname: String, port: Int) -> URLSessionStreamTask {}
open func uploadTask(with request: URLRequest, from bodyData: Data) -> URLSessionUploadTask {}
open func uploadTask(with request: URLRequest, from bodyData: Data?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask {}
open func uploadTask(with request: URLRequest, fromFile fileURL: URL) -> URLSessionUploadTask {}
open func uploadTask(with request: URLRequest, fromFile fileURL: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask {}
open func uploadTask(withStreamedRequest request: URLRequest) -> URLSessionUploadTask {}
}
open class URLSessionConfiguration {
open class var default: URLSessionConfiguration { get }
open class var ephemeral: URLSessionConfiguration { get }
open class func background(withIdentifier identifier: String) -> URLSessionConfiguration {}
open var allowsCellularAccess: Bool { get set }
open var connectionProxyDictionary: [AnyHashable: Any]? { get set }
open var httpAdditionalHeaders: [AnyHashable: Any]? { get set }
open var httpCookieAcceptPolicy: HTTPCookie.AcceptPolicy { get set }
open var httpCookieStorage: HTTPCookieStorage? { get set }
open var httpMaximumConnectionsPerHost: Int { get set }
open var httpShouldSetCookies: Bool { get set }
open var httpShouldUsePipelining: Bool { get set }
open var identifier: String? { get set }
open var isDiscretionary: Bool { get set }
open var networkServiceType: URLRequest.NetworkServiceType { get set }
open var protocolClasses: [AnyClass]? { get set }
open var requestCachePolicy: URLRequest.CachePolicy { get set }
open var sharedContainerIdentifier: String? { get }
open var shouldUseExtendedBackgroundIdleMode: Bool { get set }
open var timeoutIntervalForRequest: TimeInterval { get set }
open var timeoutIntervalForResource: TimeInterval { get set }
open var urlCache: URLCache? { get set }
open var urlCredentialStorage: URLCredentialStorage? { get set }
}
open class URLSessionDataTask {
}
open class URLSessionDownloadTask {
open func cancel(byProducingResumeData completionHandler: @escaping (Data?) -> Void) {}
}
open class URLSessionStreamTask {
open func captureStreams() {}
open func closeRead() {}
open func closeWrite() {}
open func readData(ofMinLength minBytes: Int, maxLength maxBytes: Int, timeout: TimeInterval, completionHandler: @escaping (Data?, Bool, Error?) -> Void) {}
open func startSecureConnection() {}
open func stopSecureConnection() {}
open func write(_ data: Data, timeout: TimeInterval, completionHandler: @escaping (Error?) -> Void) {}
}
open class URLSessionTask {
public static var defaultPriority: Float { get }
public static var highPriority: Float { get }
public static var lowPriority: Float { get }
public var countOfBytesClientExpectsToReceive: Int64 { get }
public var countOfBytesClientExpectsToSend: Int64 { get }
open var countOfBytesExpectedToReceive: Int64 { get }
open var countOfBytesExpectedToSend: Int64 { get }
open var countOfBytesReceived: Int64 { get }
open var countOfBytesSent: Int64 { get }
open var currentRequest: URLRequest? { get }
public var earliestBeginDate: Date? { get }
open var error: Error? { get }
open var originalRequest: URLRequest? { get }
open var priority: Float { get set }
open var response: URLResponse? { get }
open var state: URLSessionTask.State { get set }
open var taskDescription: String? { get set }
open var taskIdentifier: Int { get }
open func cancel() {}
open func resume() {}
open func suspend() {}
}
open class URLSessionUploadTask {
}
open class Unit {
public static var supportsSecureCoding: Bool { get }
public required init?(coder aDecoder: NSCoder) {}
public required init(symbol: String) {}
open var symbol: String { get }
open func copy(with zone: NSZone?) -> Any {}
open func encode(with aCoder: NSCoder) {}
open func isEqual(_ object: Any?) -> Bool {}
}
open class UnitConverter {
open func baseUnitValue(fromValue value: Double) -> Double {}
open func value(fromBaseUnitValue baseUnitValue: Double) -> Double {}
}
open class UnitConverterLinear {
public convenience init(coefficient: Double) {}
public init(coefficient: Double, constant: Double) {}
open var coefficient: Double { get }
open var constant: Double { get }
open func isEqual(_ object: Any?) -> Bool {}
}
open class UserDefaults {
public static var argumentDomain: String { get }
public static var didChangeNotification { get }
public static var globalDomain: String { get }
public static var registrationDomain: String { get }
open class var standard: UserDefaults { get }
open class func resetStandardUserDefaults() {}
public init?(suiteName suitename: String?) {}
open var volatileDomainNames: [String] { get }
open func addSuite(named suiteName: String) {}
open func array(forKey defaultName: String) -> [Any]? {}
open func bool(forKey defaultName: String) -> Bool {}
open func data(forKey defaultName: String) -> Data? {}
open func dictionary(forKey defaultName: String) -> [String: Any]? {}
open func dictionaryRepresentation() -> [String: Any] {}
open func double(forKey defaultName: String) -> Double {}
open func float(forKey defaultName: String) -> Float {}
open func integer(forKey defaultName: String) -> Int {}
open func object(forKey defaultName: String) -> Any? {}
open func objectIsForced(forKey key: String) -> Bool {}
open func objectIsForced(forKey key: String, inDomain domain: String) -> Bool {}
open func persistentDomain(forName domainName: String) -> [String: Any]? {}
open func register(defaults registrationDictionary: [String: Any]) {}
open func removeObject(forKey defaultName: String) {}
open func removePersistentDomain(forName domainName: String) {}
open func removeSuite(named suiteName: String) {}
open func removeVolatileDomain(forName domainName: String) {}
open func set(_ url: URL?, forKey defaultName: String) {}
open func setPersistentDomain(_ domain: [String: Any], forName domainName: String) {}
open func setVolatileDomain(_ domain: [String: Any], forName domainName: String) {}
open func string(forKey defaultName: String) -> String? {}
open func stringArray(forKey defaultName: String) -> [String]? {}
@discardableResult open func synchronize() -> Bool {}
open func url(forKey defaultName: String) -> URL? {}
open func volatileDomain(forName domainName: String) -> [String: Any] {}
}
open class XMLDTD {
open class func predefinedEntityDeclaration(forName name: String) -> XMLDTDNode? {}
public init() {}
public convenience init(contentsOf url: URL, options mask: XMLNode.Options = x) throws {}
public convenience init(data: Data, options mask: XMLNode.Options = x) throws {}
open var publicID: String? { get set }
open var systemID: String? { get set }
open func addChild(_ child: XMLNode) {}
open func attributeDeclaration(forName name: String, elementName: String) -> XMLDTDNode? {}
open func elementDeclaration(forName name: String) -> XMLDTDNode? {}
open func entityDeclaration(forName name: String) -> XMLDTDNode? {}
open func insertChild(_ child: XMLNode, at index: Int) {}
open func insertChildren(_ children: [XMLNode], at index: Int) {}
open func notationDeclaration(forName name: String) -> XMLDTDNode? {}
open func removeChild(at index: Int) {}
open func replaceChild(at index: Int, with node: XMLNode) {}
open func setChildren(_ children: [XMLNode]?) {}
}
open class XMLDTDNode {
public init?(xmlString string: String) {}
open var dtdKind: XMLDTDNode.DTDKind { get }
open var isExternal: Bool { get }
open var notationName: String? { get set }
open var publicID: String? { get set }
open var systemID: String? { get set }
}
open class XMLDocument {
open class func replacementClass(for cls: AnyClass) -> AnyClass {}
public init() {}
public convenience init(contentsOf url: URL, options mask: XMLNode.Options = x) throws {}
public init(data: Data, options mask: XMLNode.Options = x) throws {}
public init(rootElement element: XMLElement?) {}
public convenience init(xmlString string: String, options mask: XMLNode.Options = x) throws {}
open var characterEncoding: String? { get set }
open var documentContentKind: XMLDocument.ContentKind { get set }
open var dtd: XMLDTD? { get set }
open var isStandalone: Bool { get set }
open var mimeType: String? { get set }
open var version: String? { get set }
open var xmlData: Data { get }
open func addChild(_ child: XMLNode) {}
open func insertChild(_ child: XMLNode, at index: Int) {}
open func insertChildren(_ children: [XMLNode], at index: Int) {}
open func object(byApplyingXSLT xslt: Data, arguments: [String: String]?) throws -> Any {}
open func object(byApplyingXSLTString xslt: String, arguments: [String: String]?) throws -> Any {}
open func objectByApplyingXSLT(at xsltURL: URL, arguments argument: [String: String]?) throws -> Any {}
open func removeChild(at index: Int) {}
open func replaceChild(at index: Int, with node: XMLNode) {}
open func rootElement() -> XMLElement? {}
open func setChildren(_ children: [XMLNode]?) {}
open func setRootElement(_ root: XMLElement) {}
open func validate() throws {}
open func xmlData(options: XMLNode.Options = x) -> Data {}
}
open class XMLElement {
public convenience init(name: String) {}
public convenience init(name: String, stringValue string: String?) {}
public init(name: String, uri URI: String?) {}
public convenience init(xmlString string: String) throws {}
open var attributes: [XMLNode]? { get set }
open var namespaces: [XMLNode]? { get set }
open func addAttribute(_ attribute: XMLNode) {}
open func addChild(_ child: XMLNode) {}
open func addNamespace(_ aNamespace: XMLNode) {}
open func attribute(forLocalName localName: String, uri URI: String?) -> XMLNode? {}
open func attribute(forName name: String) -> XMLNode? {}
open func elements(forLocalName localName: String, uri URI: String?) -> [XMLElement] {}
open func elements(forName name: String) -> [XMLElement] {}
open func insertChild(_ child: XMLNode, at index: Int) {}
open func insertChildren(_ children: [XMLNode], at index: Int) {}
open func namespace(forPrefix name: String) -> XMLNode? {}
open func normalizeAdjacentTextNodesPreservingCDATA(_ preserve: Bool) {}
open func removeAttribute(forName name: String) {}
open func removeChild(at index: Int) {}
open func removeNamespace(forPrefix name: String) {}
open func replaceChild(at index: Int, with node: XMLNode) {}
open func resolveNamespace(forName name: String) -> XMLNode? {}
open func resolvePrefix(forNamespaceURI namespaceURI: String) -> String? {}
open func setAttributesWith(_ attributes: [String: String]) {}
open func setChildren(_ children: [XMLNode]?) {}
}
open class XMLNode {
open class func attribute(withName name: String, stringValue: String) -> Any {}
open class func attribute(withName name: String, uri: String, stringValue: String) -> Any {}
open class func comment(withStringValue stringValue: String) -> Any {}
open class func document() -> Any {}
open class func document(withRootElement element: XMLElement) -> Any {}
open class func dtdNode(withXMLString string: String) -> Any? {}
open class func element(withName name: String) -> Any {}
open class func element(withName name: String, children: [XMLNode]?, attributes: [XMLNode]?) -> Any {}
open class func element(withName name: String, stringValue string: String) -> Any {}
open class func element(withName name: String, uri: String) -> Any {}
open class func localName(forName name: String) -> String {}
open class func namespace(withName name: String, stringValue: String) -> Any {}
open class func predefinedNamespace(forPrefix name: String) -> XMLNode? {}
open class func prefix(forName name: String) -> String? {}
public class func processingInstruction(withName name: String, stringValue: String) -> Any {}
open class func text(withStringValue stringValue: String) -> Any {}
public convenience init(kind: XMLNode.Kind) {}
public init(kind: XMLNode.Kind, options: XMLNode.Options = x) {}
open var childCount: Int { get }
open var children: [XMLNode]? { get }
public var endIndex: Index { get }
open var index: Int { get }
open var kind: XMLNode.Kind { get }
open var level: Int { get }
open var localName: String? { get }
open var name: String? { get set }
open var next: XMLNode? { get }
open var nextSibling: XMLNode? { get }
open var objectValue: Any? { get set }
open var parent: XMLNode? { get }
open var prefix: String? { get }
open var previous: XMLNode? { get }
open var previousSibling: XMLNode? { get }
open var rootDocument: XMLDocument? { get }
public var startIndex: Index { get }
open var stringValue: String? { get set }
open var uri: String? { get set }
open var xPath: String? { get }
open var xmlString: String { get }
public subscript(index: Index) -> XMLNode { get } {}
open func canonicalXMLStringPreservingComments(_ comments: Bool) -> String {}
open func child(at index: Int) -> XMLNode? {}
open func detach() {}
public func index(after i: Index) -> Index {}
open func nodes(forXPath xpath: String) throws -> [XMLNode] {}
open func objects(forXQuery xquery: String) throws -> [Any] {}
open func objects(forXQuery xquery: String, constants: [String: Any]?) throws -> [Any] {}
open func setStringValue(_ string: String, resolvingEntities resolve: Bool) {}
open func xmlString(options: Options) -> String {}
}
open class XMLParser {
public static var errorDomain: String { get }
public convenience init?(contentsOf url: URL) {}
public init(data: Data) {}
public init(stream: InputStream) {}
open var allowedExternalEntityURLs: Set<URL>? { get set }
open var columnNumber: Int { get }
open weak var delegate: XMLParserDelegate? { get set }
open var externalEntityResolvingPolicy: ExternalEntityResolvingPolicy { get set }
open var lineNumber: Int { get }
open var parserError: Error? { get }
open var publicID: String? { get }
open var shouldProcessNamespaces: Bool { get set }
open var shouldReportNamespacePrefixes: Bool { get set }
open var shouldResolveExternalEntities: Bool { get set }
open var systemID: String? { get }
open func abortParsing() {}
open func parse() -> Bool {}
}
public protocol CustomNSError {
public static var errorDomain: String { get }
public var errorCode: Int { get }
public var errorUserInfo: [String: Any] { get }
}
public protocol FileManagerDelegate {
public func fileManager(_ fileManager: FileManager, shouldCopyItemAt srcURL: URL, to dstURL: URL) -> Bool {}
public func fileManager(_ fileManager: FileManager, shouldCopyItemAtPath srcPath: String, toPath dstPath: String) -> Bool {}
public func fileManager(_ fileManager: FileManager, shouldLinkItemAt srcURL: URL, to dstURL: URL) -> Bool {}
public func fileManager(_ fileManager: FileManager, shouldLinkItemAtPath srcPath: String, toPath dstPath: String) -> Bool {}
public func fileManager(_ fileManager: FileManager, shouldMoveItemAt srcURL: URL, to dstURL: URL) -> Bool {}
public func fileManager(_ fileManager: FileManager, shouldMoveItemAtPath srcPath: String, toPath dstPath: String) -> Bool {}
public func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, copyingItemAt srcURL: URL, to dstURL: URL) -> Bool {}
public func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, copyingItemAtPath srcPath: String, toPath dstPath: String) -> Bool {}
public func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, linkingItemAt srcURL: URL, to dstURL: URL) -> Bool {}
public func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, linkingItemAtPath srcPath: String, toPath dstPath: String) -> Bool {}
public func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, movingItemAt srcURL: URL, to dstURL: URL) -> Bool {}
public func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, movingItemAtPath srcPath: String, toPath dstPath: String) -> Bool {}
public func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, removingItemAt URL: URL) -> Bool {}
public func fileManager(_ fileManager: FileManager, shouldProceedAfterError error: Error, removingItemAtPath path: String) -> Bool {}
public func fileManager(_ fileManager: FileManager, shouldRemoveItemAt URL: URL) -> Bool {}
public func fileManager(_ fileManager: FileManager, shouldRemoveItemAtPath path: String) -> Bool {}
}
public protocol LocalizedError {
public var errorDescription: String? { get }
public var failureReason: String? { get }
public var helpAnchor: String? { get }
public var recoverySuggestion: String? { get }
}
public protocol NSCacheDelegate {
public func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {}
}
public protocol NSCoding {
public init?(coder aDecoder: NSCoder) {}
public func encode(with aCoder: NSCoder) {}
}
public protocol NSCopying {
public func copy() -> Any {}
public func copy(with zone: NSZone?) -> Any {}
}
public protocol NSDecimalNumberBehaviors {
public func roundingMode() -> NSDecimalNumber.RoundingMode {}
public func scale() -> Int16 {}
}
public protocol NSKeyedArchiverDelegate {
public func archiver(_ archiver: NSKeyedArchiver, didEncode object: Any?) {}
public func archiver(_ archiver: NSKeyedArchiver, willEncode object: Any) -> Any? {}
public func archiver(_ archiver: NSKeyedArchiver, willReplace object: Any?, withObject newObject: Any?) {}
public func archiverDidFinish(_ archiver: NSKeyedArchiver) {}
public func archiverWillFinish(_ archiver: NSKeyedArchiver) {}
}
public protocol NSKeyedUnarchiverDelegate {
public func unarchiver(_ unarchiver: NSKeyedUnarchiver, cannotDecodeObjectOfClassName name: String, originalClasses classNames: [String]) -> AnyClass? {}
public func unarchiver(_ unarchiver: NSKeyedUnarchiver, didDecode object: Any?) -> Any? {}
public func unarchiver(_ unarchiver: NSKeyedUnarchiver, willReplace object: Any, with newObject: Any) {}
public func unarchiverDidFinish(_ unarchiver: NSKeyedUnarchiver) {}
public func unarchiverWillFinish(_ unarchiver: NSKeyedUnarchiver) {}
}
public protocol NSLocking {
public func lock() {}
public func unlock() {}
}
public protocol NSMutableCopying {
public func mutableCopy() -> Any {}
public func mutableCopy(with zone: NSZone?) -> Any {}
}
public protocol NSObjectProtocol {
public var debugDescription: String { get }
public var description: String { get }
public var hash: Int { get }
public func isEqual(_ object: Any?) -> Bool {}
public func isProxy() -> Bool {}
public func self() -> Self {}
}
public protocol NSSecureCoding {
public static var supportsSecureCoding: Bool { get }
}
public protocol PortDelegate {
public func handlePortMessage(_ message: PortMessage) {}
}
public protocol ProgressReporting {
public var progress: Progress { get }
}
public protocol RecoverableError {
public var recoveryOptions: [String] { get }
public func attemptRecovery(optionIndex recoveryOptionIndex: Int) -> Bool {}
public func attemptRecovery(optionIndex recoveryOptionIndex: Int, resultHandler handler: (_ recovered: Bool) -> Void) {}
}
public protocol ReferenceConvertible {
}
public protocol StreamDelegate {
public func stream(_ aStream: Stream, handle eventCode: Stream.Event) {}
}
public protocol URLAuthenticationChallengeSender {
public func cancel(_ challenge: URLAuthenticationChallenge) {}
public func continueWithoutCredential(for challenge: URLAuthenticationChallenge) {}
public func performDefaultHandling(for challenge: URLAuthenticationChallenge) {}
public func rejectProtectionSpaceAndContinue(with challenge: URLAuthenticationChallenge) {}
public func use(_ credential: URLCredential, for challenge: URLAuthenticationChallenge) {}
}
public protocol URLProtocolClient {
public func urlProtocol(_ protocol: URLProtocol, cachedResponseIsValid cachedResponse: CachedURLResponse) {}
public func urlProtocol(_ protocol: URLProtocol, didCancel challenge: URLAuthenticationChallenge) {}
public func urlProtocol(_ protocol: URLProtocol, didFailWithError error: Error) {}
public func urlProtocol(_ protocol: URLProtocol, didLoad data: Data) {}
public func urlProtocol(_ protocol: URLProtocol, didReceive challenge: URLAuthenticationChallenge) {}
public func urlProtocol(_ protocol: URLProtocol, didReceive response: URLResponse, cacheStoragePolicy policy: URLCache.StoragePolicy) {}
public func urlProtocol(_ protocol: URLProtocol, wasRedirectedTo request: URLRequest, redirectResponse: URLResponse) {}
public func urlProtocolDidFinishLoading(_ protocol: URLProtocol) {}
}
public protocol URLSessionDataDelegate {
public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome downloadTask: URLSessionDownloadTask) {}
public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {}
public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {}
public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse, completionHandler: @escaping (CachedURLResponse?) -> Void) {}
}
public protocol URLSessionDelegate {
public func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {}
public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {}
}
public protocol URLSessionDownloadDelegate {
public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {}
public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {}
public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {}
}
public protocol URLSessionStreamDelegate {
public func urlSession(_ session: URLSession, betterRouteDiscoveredFor streamTask: URLSessionStreamTask) {}
public func urlSession(_ session: URLSession, readClosedFor streamTask: URLSessionStreamTask) {}
public func urlSession(_ session: URLSession, streamTask: URLSessionStreamTask, didBecome inputStream: InputStream, outputStream: OutputStream) {}
public func urlSession(_ session: URLSession, writeClosedFor streamTask: URLSessionStreamTask) {}
}
public protocol URLSessionTaskDelegate {
public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {}
public func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {}
public func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {}
public func urlSession(_ session: URLSession, task: URLSessionTask, needNewBodyStream completionHandler: @escaping (InputStream?) -> Void) {}
public func urlSession(_ session: URLSession, task: URLSessionTask, willBeginDelayedRequest request: URLRequest, completionHandler: @escaping (URLSession.DelayedRequestDisposition, URLRequest?) -> Void) {}
public func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {}
}
public protocol XMLParserDelegate {
public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {}
public func parser(_ parser: XMLParser, didEndMappingPrefix prefix: String) {}
public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String]) {}
public func parser(_ parser: XMLParser, didStartMappingPrefix prefix: String, toURI namespaceURI: String) {}
public func parser(_ parser: XMLParser, foundAttributeDeclarationWithName attributeName: String, forElement elementName: String, type: String?, defaultValue: String?) {}
public func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {}
public func parser(_ parser: XMLParser, foundCharacters string: String) {}
public func parser(_ parser: XMLParser, foundComment comment: String) {}
public func parser(_ parser: XMLParser, foundElementDeclarationWithName elementName: String, model: String) {}
public func parser(_ parser: XMLParser, foundExternalEntityDeclarationWithName name: String, publicID: String?, systemID: String?) {}
public func parser(_ parser: XMLParser, foundIgnorableWhitespace whitespaceString: String) {}
public func parser(_ parser: XMLParser, foundInternalEntityDeclarationWithName name: String, value: String?) {}
public func parser(_ parser: XMLParser, foundNotationDeclarationWithName name: String, publicID: String?, systemID: String?) {}
public func parser(_ parser: XMLParser, foundProcessingInstructionWithTarget target: String, data: String?) {}
public func parser(_ parser: XMLParser, foundUnparsedEntityDeclarationWithName name: String, publicID: String?, systemID: String?, notationName: String?) {}
public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {}
public func parser(_ parser: XMLParser, resolveExternalEntityName name: String, systemID: String?) -> Data? {}
public func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {}
public func parserDidEndDocument(_ parser: XMLParser) {}
public func parserDidStartDocument(_ parser: XMLParser) {}
}
extension Array {
}
extension Bool {
public init?(exactly number: NSNumber) {}
public init(truncating number: NSNumber) {}
}
extension CFArray {
}
extension CFCalendar {
}
extension CFCharacterSet {
}
extension CFData {
}
extension CFDate {
}
extension CFDictionary {
}
extension CFError {
}
extension CFKeyedArchiverUID {
}
extension CFLocale {
}
extension CFNumber {
}
extension CFSet {
}
extension CFString {
}
extension CFTimeZone {
}
extension CFURL {
}
extension CFURLSessionEasyCode {
public func ==(lhs: CFURLSessionEasyCode, rhs: CFURLSessionEasyCode) -> Bool {}
}
extension CFURLSessionInfo {
public var debugHeader: String { get }
public func ==(lhs: CFURLSessionInfo, rhs: CFURLSessionInfo) -> Bool {}
}
extension CFURLSessionMultiCode {
public func ==(lhs: CFURLSessionMultiCode, rhs: CFURLSessionMultiCode) -> Bool {}
}
extension CFURLSessionPoll {
public func ==(lhs: CFURLSessionPoll, rhs: CFURLSessionPoll) -> Bool {}
}
extension DecodingError {
}
extension Dictionary {
}
extension Double {
public init(_ value: CGFloat) {}
public init?(exactly number: NSNumber) {}
public init(truncating number: NSNumber) {}
}
extension EncodingError {
}
extension Float {
public init(_ value: CGFloat) {}
public init?(exactly number: NSNumber) {}
public init(truncating number: NSNumber) {}
}
extension Int {
public init(_ value: CGFloat) {}
public init?(exactly number: NSNumber) {}
public init(truncating number: NSNumber) {}
}
extension Int16 {
public init(_ value: CGFloat) {}
public init?(exactly number: NSNumber) {}
public init(truncating number: NSNumber) {}
}
extension Int32 {
public init(_ value: CGFloat) {}
public init?(exactly number: NSNumber) {}
public init(truncating number: NSNumber) {}
}
extension Int64 {
public init(_ value: CGFloat) {}
public init?(exactly number: NSNumber) {}
public init(truncating number: NSNumber) {}
}
extension Int8 {
public init(_ value: CGFloat) {}
public init?(exactly number: NSNumber) {}
public init(truncating number: NSNumber) {}
}
extension Measurement {
public init(from decoder: Decoder) throws {}
public var customMirror: Mirror { get }
public var debugDescription: String { get }
public var description: String { get }
public func *(lhs: Double, rhs: Measurement<UnitType>) -> Measurement<UnitType> {}
public func *(lhs: Measurement<UnitType>, rhs: Double) -> Measurement<UnitType> {}
public func +(lhs: Measurement<UnitType>, rhs: Measurement<UnitType>) -> Measurement<UnitType> {}
public func +(lhs: Measurement<UnitType>, rhs: Measurement<UnitType>) -> Measurement<UnitType>  where UnitType : Dimension {}
public func -(lhs: Measurement<UnitType>, rhs: Measurement<UnitType>) -> Measurement<UnitType>  where UnitType : Dimension {}
public func -(lhs: Measurement<UnitType>, rhs: Measurement<UnitType>) -> Measurement<UnitType> {}
public func /(lhs: Double, rhs: Measurement<UnitType>) -> Measurement<UnitType> {}
public func /(lhs: Measurement<UnitType>, rhs: Double) -> Measurement<UnitType> {}
public func <<LeftHandSideType, RightHandSideType>(lhs: Measurement<LeftHandSideType>, rhs: Measurement<RightHandSideType>) -> Bool {}
public func ==<LeftHandSideType, RightHandSideType>(lhs: Measurement<LeftHandSideType>, rhs: Measurement<RightHandSideType>) -> Bool {}
public mutating func convert(to otherUnit: UnitType)  where UnitType : Dimension {}
public func converted(to otherUnit: UnitType) -> Measurement<UnitType>  where UnitType : Dimension {}
public func encode(to encoder: Encoder) throws {}
}
extension Optional {
}
extension Range {
public init?(_ range: NSRange)  where Bound : BinaryInteger {}
public init?(_ range: NSRange, in string: String)  where Bound == String.Index {}
}
extension Set {
}
extension String {
public static var availableStringEncodings: [Encoding] { get }
public static var defaultCStringEncoding: Encoding { get }
public static func localizedName(of encoding: Encoding) -> String {}
public static func localizedStringWithFormat(_ format: String, _ arguments: CVarArg...) -> String {}
public init?<S>(bytes: S, encoding: Encoding)  where S : Sequence, S.Iterator.Element == UInt8 {}
public init?(bytesNoCopy bytes: UnsafeMutableRawPointer, length: Int, encoding: Encoding, freeWhenDone flag: Bool) {}
public init?(cString: UnsafePointer<CChar>, encoding enc: Encoding) {}
public init(contentsOf url: URL) throws {}
public init(contentsOf url: URL, encoding enc: Encoding) throws {}
public init(contentsOf url: URL, usedEncoding: inout Encoding) throws {}
public init(contentsOfFile path: String) throws {}
public init(contentsOfFile path: String, encoding enc: Encoding) throws {}
public init(contentsOfFile path: String, usedEncoding: inout Encoding) throws {}
public init?(data: Data, encoding: Encoding) {}
public init(format: String, _ arguments: CVarArg...) {}
public init(format: String, arguments: [CVarArg]) {}
public init(format: String, locale: Locale?, _ args: CVarArg...) {}
public init(format: String, locale: Locale?, arguments: [CVarArg]) {}
public init(utf16CodeUnits: UnsafePointer<unichar>, count: Int) {}
public init(utf16CodeUnitsNoCopy: UnsafePointer<unichar>, count: Int, freeWhenDone flag: Bool) {}
public init?(utf8String bytes: UnsafePointer<CChar>) {}
}
extension String.Encoding {
public var description: String { get }
public var hashValue: Int { get }
public func ==(lhs: String.Encoding, rhs: String.Encoding) -> Bool {}
}
extension StringProtocol {
public var capitalized: String { get }  where Index == String.Index
public var decomposedStringWithCanonicalMapping: String { get }  where Index == String.Index
public var decomposedStringWithCompatibilityMapping: String { get }  where Index == String.Index
public var fastestEncoding: String.Encoding { get }  where Index == String.Index
public var hash: Int { get }  where Index == String.Index
@available(macOS10.11, iOS9.0, *) public var localizedCapitalized: String { get }  where Index == String.Index
@available(macOS10.11, iOS9.0, *) public var localizedLowercase: String { get }  where Index == String.Index
@available(macOS10.11, iOS9.0, *) public var localizedUppercase: String { get }  where Index == String.Index
public var precomposedStringWithCanonicalMapping: String { get }  where Index == String.Index
public var precomposedStringWithCompatibilityMapping: String { get }  where Index == String.Index
public var removingPercentEncoding: String? { get }  where Index == String.Index
public var smallestEncoding: String.Encoding { get }  where Index == String.Index
public func addingPercentEncoding(withAllowedCharacters allowedCharacters: CharacterSet) -> String?  where Index == String.Index {}
public func appending<T>(_ aString: T) -> String  where T : StringProtocol, Index == String.Index {}
public func appendingFormat<T>(_ format: T, _ arguments: CVarArg...) -> String  where T : StringProtocol, Index == String.Index {}
#if !DEPLOYMENT_RUNTIME_SWIFT
@available(macOS10.11, iOS9.0, *) public func applyingTransform(_ transform: StringTransform, reverse: Bool) -> String?  where Index == String.Index {}
#endif
public func cString(using encoding: String.Encoding) -> [CChar]?  where Index == String.Index {}
public func canBeConverted(to encoding: String.Encoding) -> Bool  where Index == String.Index {}
public func capitalized(with locale: Locale?) -> String  where Index == String.Index {}
public func caseInsensitiveCompare<T>(_ aString: T) -> ComparisonResult  where T : StringProtocol, Index == String.Index {}
public func commonPrefix<T>(with aString: T, options: String.CompareOptions = x) -> String  where T : StringProtocol, Index == String.Index {}
public func compare<T>(_ aString: T, options mask: String.CompareOptions = x, range: Range<Index>? = x, locale: Locale? = x) -> ComparisonResult  where T : StringProtocol, Index == String.Index {}
public func completePath(into outputName: UnsafeMutablePointer<String>? = x, caseSensitive: Bool, matchesInto outputArray: UnsafeMutablePointer<[String]>? = x, filterTypes: [String]? = x) -> Int  where Index == String.Index {}
public func components(separatedBy separator: CharacterSet) -> [String]  where Index == String.Index {}
public func components<T>(separatedBy separator: T) -> [String]  where T : StringProtocol, Index == String.Index {}
public func contains<T>(_ other: T) -> Bool  where T : StringProtocol, Index == String.Index {}
public func data(using encoding: String.Encoding, allowLossyConversion: Bool = x) -> Data?  where Index == String.Index {}
public func enumerateLines(invoking body: @escaping (_ line: String, _ stop: inout Bool) -> Void)  where Index == String.Index {}
#if !DEPLOYMENT_RUNTIME_SWIFT
public func enumerateLinguisticTags<T, R>(in range: R, scheme tagScheme: T, options opts: NSLinguisticTagger.Options = x, orthography: NSOrthography? = x, invoking body: (String, Range<Index>, Range<Index>, inout Bool) -> Void)  where R : RangeExpression, T : StringProtocol, Index == R.Bound, Index == String.Index {}
#endif
public func enumerateSubstrings<R>(in range: R, options opts: String.EnumerationOptions = x, _ body: @escaping (_ substring: String?, _ substringRange: Range<Index>, _ enclosingRange: Range<Index>, inout Bool) -> Void)  where R : RangeExpression, Index == R.Bound, Index == String.Index {}
public func folding(options: String.CompareOptions = x, locale: Locale?) -> String  where Index == String.Index {}
public func getBytes<R>(_ buffer: inout [UInt8], maxLength maxBufferCount: Int, usedLength usedBufferCount: UnsafeMutablePointer<Int>, encoding: String.Encoding, options: String.EncodingConversionOptions = x, range: R, remaining leftover: UnsafeMutablePointer<Range<Index>>) -> Bool  where R : RangeExpression, Index == R.Bound, Index == String.Index {}
public func getCString(_ buffer: inout [CChar], maxLength: Int, encoding: String.Encoding) -> Bool  where Index == String.Index {}
public func getLineStart<R>(_ start: UnsafeMutablePointer<Index>, end: UnsafeMutablePointer<Index>, contentsEnd: UnsafeMutablePointer<Index>, for range: R)  where R : RangeExpression, Index == R.Bound, Index == String.Index {}
public func getParagraphStart<R>(_ start: UnsafeMutablePointer<Index>, end: UnsafeMutablePointer<Index>, contentsEnd: UnsafeMutablePointer<Index>, for range: R)  where R : RangeExpression, Index == R.Bound, Index == String.Index {}
public func lengthOfBytes(using encoding: String.Encoding) -> Int  where Index == String.Index {}
public func lineRange<R>(for aRange: R) -> Range<Index>  where R : RangeExpression, Index == R.Bound, Index == String.Index {}
#if !DEPLOYMENT_RUNTIME_SWIFT
public func linguisticTags<T, R>(in range: R, scheme tagScheme: T, options opts: NSLinguisticTagger.Options = x, orthography: NSOrthography? = x, tokenRanges: UnsafeMutablePointer<[Range<Index>]>? = x) -> [String]  where R : RangeExpression, T : StringProtocol, Index == R.Bound, Index == String.Index {}
#endif
public func localizedCaseInsensitiveCompare<T>(_ aString: T) -> ComparisonResult  where T : StringProtocol, Index == String.Index {}
public func localizedCaseInsensitiveContains<T>(_ other: T) -> Bool  where T : StringProtocol, Index == String.Index {}
public func localizedCompare<T>(_ aString: T) -> ComparisonResult  where T : StringProtocol, Index == String.Index {}
public func localizedStandardCompare<T>(_ string: T) -> ComparisonResult  where T : StringProtocol, Index == String.Index {}
@available(macOS10.11, iOS9.0, *) public func localizedStandardContains<T>(_ string: T) -> Bool  where T : StringProtocol, Index == String.Index {}
@available(macOS10.11, iOS9.0, *) public func localizedStandardRange<T>(of string: T) -> Range<Index>?  where T : StringProtocol, Index == String.Index {}
public func lowercased(with locale: Locale?) -> String  where Index == String.Index {}
public func maximumLengthOfBytes(using encoding: String.Encoding) -> Int  where Index == String.Index {}
public func padding<T>(toLength newLength: Int, withPad padString: T, startingAt padIndex: Int) -> String  where T : StringProtocol, Index == String.Index {}
#if !DEPLOYMENT_RUNTIME_SWIFT
public func paragraphRange<R>(for aRange: R) -> Range<Index>  where R : RangeExpression, Index == R.Bound, Index == String.Index {}
#endif
#if !DEPLOYMENT_RUNTIME_SWIFT
public func propertyList() -> Any  where Index == String.Index {}
#endif
#if !DEPLOYMENT_RUNTIME_SWIFT
public func propertyListFromStringsFileFormat() -> [String: String]  where Index == String.Index {}
#endif
public func range<T>(of aString: T, options mask: String.CompareOptions = x, range searchRange: Range<Index>? = x, locale: Locale? = x) -> Range<Index>?  where T : StringProtocol, Index == String.Index {}
public func rangeOfCharacter(from aSet: CharacterSet, options mask: String.CompareOptions = x, range aRange: Range<Index>? = x) -> Range<Index>?  where Index == String.Index {}
public func rangeOfComposedCharacterSequence(at anIndex: Index) -> Range<Index>  where Index == String.Index {}
public func rangeOfComposedCharacterSequences<R>(for range: R) -> Range<Index>  where R : RangeExpression, Index == R.Bound, Index == String.Index {}
public func replacingCharacters<T, R>(in range: R, with replacement: T) -> String  where R : RangeExpression, T : StringProtocol, Index == R.Bound, Index == String.Index {}
public func replacingOccurrences<Target, Replacement>(of target: Target, with replacement: Replacement, options: String.CompareOptions = x, range searchRange: Range<Index>? = x) -> String  where Replacement : StringProtocol, Target : StringProtocol, Index == String.Index {}
public func trimmingCharacters(in set: CharacterSet) -> String  where Index == String.Index {}
public func uppercased(with locale: Locale?) -> String  where Index == String.Index {}
public func write(to url: URL, atomically useAuxiliaryFile: Bool, encoding enc: String.Encoding) throws  where Index == String.Index {}
public func write<T>(toFile path: T, atomically useAuxiliaryFile: Bool, encoding enc: String.Encoding) throws  where T : StringProtocol, Index == String.Index {}
}
extension UInt {
public init(_ value: CGFloat) {}
public init?(exactly number: NSNumber) {}
public init(truncating number: NSNumber) {}
}
extension UInt16 {
public init(_ value: CGFloat) {}
public init?(exactly number: NSNumber) {}
public init(truncating number: NSNumber) {}
}
extension UInt32 {
public init(_ value: CGFloat) {}
public init?(exactly number: NSNumber) {}
public init(truncating number: NSNumber) {}
}
extension UInt64 {
public init(_ value: CGFloat) {}
public init?(exactly number: NSNumber) {}
public init(truncating number: NSNumber) {}
}
extension UInt8 {
public init(_ value: CGFloat) {}
public init?(exactly number: NSNumber) {}
public init(truncating number: NSNumber) {}
}
extension _BodyDataSource {
}
extension _BodyFileSource {
}
extension _BridgedStoredNSError {
public init(_ code: Code, userInfo: [String: Any] = x)  where Code : RawRepresentable, Code.RawValue : FixedWidthInteger {}
public var code: Code { get }  where Code : RawRepresentable, Code.RawValue : FixedWidthInteger
public var userInfo: [String: Any] { get }  where Code : RawRepresentable, Code.RawValue : FixedWidthInteger
public func ==(lhs: Self, rhs: Self) -> Bool {}
}
extension _EasyHandle {
}
extension _EasyHandle._PauseState {
}
extension _ErrorCodeProtocol {
public func ~=(match: Self, error: Error) -> Bool {}
}
extension _HTTPURLProtocol {
}
extension _JSONDecoder {
public func decode(_ type: Bool.Type) throws -> Bool {}
public func decodeNil() -> Bool {}
}
extension _JSONEncoder {
public func encode(_ value: Bool) throws {}
public func encodeNil() throws {}
}
extension _ProtocolClient {
}
extension __BridgedNSError {
public init?(rawValue: RawValue)  where RawValue : FixedWidthInteger, Self : RawRepresentable {}
public var hashValue: Int { get }  where RawValue : FixedWidthInteger, Self : RawRepresentable
public func ==(lhs: Self, rhs: Self) -> Bool  where RawValue : FixedWidthInteger, Self : RawRepresentable {}
}
extension __SwiftValue {
}