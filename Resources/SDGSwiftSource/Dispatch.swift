public protocol DispatchSourceFileSystemObject {
}
public protocol DispatchSourceMachReceive {
}
public protocol DispatchSourceMachSend {
}
public protocol DispatchSourceMemoryPressure {
}
public protocol DispatchSourceProcess {
}
public protocol DispatchSourceProtocol {
public var data: UInt { get }
public var handle: UInt { get }
public var isCancelled: Bool { get }
public var mask: UInt { get }
public func cancel() {}
public func resume() {}
public func setCancelHandler(handler: DispatchWorkItem) {}
public func setCancelHandler(qos: DispatchQoS, flags: DispatchWorkItemFlags, handler: DispatchSourceHandler?) {}
public func setEventHandler(handler: DispatchWorkItem) {}
public func setEventHandler(qos: DispatchQoS, flags: DispatchWorkItemFlags, handler: DispatchSourceHandler?) {}
public func setRegistrationHandler(handler: DispatchWorkItem) {}
public func setRegistrationHandler(qos: DispatchQoS, flags: DispatchWorkItemFlags, handler: DispatchSourceHandler?) {}
public func suspend() {}
}
public protocol DispatchSourceRead {
}
public protocol DispatchSourceSignal {
}
public protocol DispatchSourceTimer {
public func scheduleOneshot(deadline: DispatchTime, leeway: DispatchTimeInterval) {}
public func scheduleOneshot(wallDeadline: DispatchWallTime, leeway: DispatchTimeInterval) {}
public func scheduleRepeating(deadline: DispatchTime, interval: DispatchTimeInterval, leeway: DispatchTimeInterval) {}
public func scheduleRepeating(wallDeadline: DispatchWallTime, interval: DispatchTimeInterval, leeway: DispatchTimeInterval) {}
}
public protocol DispatchSourceUserDataAdd {
public func add(data: UInt) {}
}
public protocol DispatchSourceUserDataOr {
public func or(data: UInt) {}
}
public protocol DispatchSourceUserDataReplace {
public func replace(data: UInt) {}
}
public protocol DispatchSourceWrite {
}
extension DispatchGroup {
public func notify(qos: DispatchQoS = default, flags: DispatchWorkItemFlags = default, queue: DispatchQueue, execute work: @escaping () -> Void) {}
@available(macOS10.10, iOS8.0, *) public func notify(queue: DispatchQueue, work: DispatchWorkItem) {}
public func wait() {}
public func wait(timeout: DispatchTime) -> DispatchTimeoutResult {}
public func wait(wallTimeout timeout: DispatchWallTime) -> DispatchTimeoutResult {}
}
extension DispatchIO {
public class func read(fromFileDescriptor: Int32, maxLength: Int, runningHandlerOn queue: DispatchQueue, handler: @escaping (_ data: DispatchData, _ error: Int32) -> Void) {}
public class func write(toFileDescriptor: Int32, data: DispatchData, runningHandlerOn queue: DispatchQueue, handler: @escaping (_ data: DispatchData?, _ error: Int32) -> Void) {}
public convenience init(type: StreamType, fileDescriptor: Int32, queue: DispatchQueue, cleanupHandler: @escaping (_ error: Int32) -> Void) {}
public convenience init(type: StreamType, io: DispatchIO, queue: DispatchQueue, cleanupHandler: @escaping (_ error: Int32) -> Void) {}
@available(swift, introduced: 4) public convenience init?(type: StreamType, path: UnsafePointer<Int8>, oflag: Int32, mode: mode_t, queue: DispatchQueue, cleanupHandler: @escaping (_ error: Int32) -> Void) {}
public func close(flags: CloseFlags = default) {}
public func read(offset: off_t, length: Int, queue: DispatchQueue, ioHandler: @escaping (_ done: Bool, _ data: DispatchData?, _ error: Int32) -> Void) {}
public func setInterval(interval: DispatchTimeInterval, flags: IntervalFlags = default) {}
public func write(offset: off_t, data: DispatchData, queue: DispatchQueue, ioHandler: @escaping (_ done: Bool, _ data: DispatchData?, _ error: Int32) -> Void) {}
}
extension DispatchQueue {
public class var main: DispatchQueue { get }
public class func concurrentPerform(iterations: Int, execute work: (Int) -> Void) {}
public class func getSpecific<T>(key: DispatchSpecificKey<T>) -> T? {}
@available(macOS10.10, iOS8.0, *) public class func global(qos: DispatchQoS.QoSClass = default) -> DispatchQueue {}
#if os(Android)
public static func setThreadDetachCallback(_ cb: @escaping () -> Void) {}
#endif
public convenience init(label: String, qos: DispatchQoS = default, attributes: Attributes = default, autoreleaseFrequency: AutoreleaseFrequency = default, target: DispatchQueue? = default) {}
public var label: String { get }
@available(macOS10.10, iOS8.0, *) public var qos: DispatchQoS { get }
@available(macOS10.10, iOS8.0, *) public func async(execute workItem: DispatchWorkItem) {}
@available(macOS10.10, iOS8.0, *) public func async(group: DispatchGroup, execute workItem: DispatchWorkItem) {}
public func async(group: DispatchGroup? = default, qos: DispatchQoS = default, flags: DispatchWorkItemFlags = default, execute work: @escaping () -> Void) {}
@available(macOS10.10, iOS8.0, *) public func asyncAfter(deadline: DispatchTime, execute: DispatchWorkItem) {}
public func asyncAfter(deadline: DispatchTime, qos: DispatchQoS = default, flags: DispatchWorkItemFlags = default, execute work: @escaping () -> Void) {}
@available(macOS10.10, iOS8.0, *) public func asyncAfter(wallDeadline: DispatchWallTime, execute: DispatchWorkItem) {}
public func asyncAfter(wallDeadline: DispatchWallTime, qos: DispatchQoS = default, flags: DispatchWorkItemFlags = default, execute work: @escaping () -> Void) {}
public func getSpecific<T>(key: DispatchSpecificKey<T>) -> T? {}
public func setSpecific<T>(key: DispatchSpecificKey<T>, value: T?) {}
@available(macOS10.10, iOS8.0, *) public func sync(execute workItem: DispatchWorkItem) {}
public func sync<T>(execute work: () throws -> T) rethrows -> T {}
public func sync<T>(flags: DispatchWorkItemFlags, execute work: () throws -> T) rethrows -> T {}
}
extension DispatchSemaphore {
@discardableResult public func signal() -> Int {}
public func wait() {}
public func wait(timeout: DispatchTime) -> DispatchTimeoutResult {}
public func wait(wallTimeout: DispatchWallTime) -> DispatchTimeoutResult {}
}
extension DispatchSource {
#if !os(Linux) && !os(Android) && !os(Windows)
public class func makeFileSystemObjectSource(fileDescriptor: Int32, eventMask: FileSystemEvent, queue: DispatchQueue? = default) -> DispatchSourceFileSystemObject {}
#endif
#if HAVE_MACH
public class func makeMachReceiveSource(port: mach_port_t, queue: DispatchQueue? = default) -> DispatchSourceMachReceive {}
#endif
#if HAVE_MACH
public class func makeMachSendSource(port: mach_port_t, eventMask: MachSendEvent, queue: DispatchQueue? = default) -> DispatchSourceMachSend {}
#endif
#if HAVE_MACH
public class func makeMemoryPressureSource(eventMask: MemoryPressureEvent, queue: DispatchQueue? = default) -> DispatchSourceMemoryPressure {}
#endif
#if !os(Linux) && !os(Android) && !os(Windows)
public class func makeProcessSource(identifier: pid_t, eventMask: ProcessEvent, queue: DispatchQueue? = default) -> DispatchSourceProcess {}
#endif
public class func makeReadSource(fileDescriptor: Int32, queue: DispatchQueue? = default) -> DispatchSourceRead {}
public class func makeSignalSource(signal: Int32, queue: DispatchQueue? = default) -> DispatchSourceSignal {}
public class func makeTimerSource(flags: TimerFlags = default, queue: DispatchQueue? = default) -> DispatchSourceTimer {}
public class func makeUserDataAddSource(queue: DispatchQueue? = default) -> DispatchSourceUserDataAdd {}
public class func makeUserDataOrSource(queue: DispatchQueue? = default) -> DispatchSourceUserDataOr {}
public class func makeUserDataReplaceSource(queue: DispatchQueue? = default) -> DispatchSourceUserDataReplace {}
public class func makeWriteSource(fileDescriptor: Int32, queue: DispatchQueue? = default) -> DispatchSourceWrite {}
}
extension DispatchSourceFileSystemObject {
#if !os(Linux) && !os(Android) && !os(Windows)
public var data: DispatchSource.FileSystemEvent { get }
#endif
#if !os(Linux) && !os(Android) && !os(Windows)
public var handle: Int32 { get }
#endif
#if !os(Linux) && !os(Android) && !os(Windows)
public var mask: DispatchSource.FileSystemEvent { get }
#endif
}
extension DispatchSourceMachReceive {
#if HAVE_MACH
public var handle: mach_port_t { get }
#endif
}
extension DispatchSourceMachSend {
#if HAVE_MACH
public var data: DispatchSource.MachSendEvent { get }
#endif
#if HAVE_MACH
public var handle: mach_port_t { get }
#endif
#if HAVE_MACH
public var mask: DispatchSource.MachSendEvent { get }
#endif
}
extension DispatchSourceMemoryPressure {
#if HAVE_MACH
public var data: DispatchSource.MemoryPressureEvent { get }
#endif
#if HAVE_MACH
public var mask: DispatchSource.MemoryPressureEvent { get }
#endif
}
extension DispatchSourceProcess {
#if !os(Linux) && !os(Android) && !os(Windows)
public var data: DispatchSource.ProcessEvent { get }
#endif
#if !os(Linux) && !os(Android) && !os(Windows)
public var handle: pid_t { get }
#endif
#if !os(Linux) && !os(Android) && !os(Windows)
public var mask: DispatchSource.ProcessEvent { get }
#endif
}
extension DispatchSourceProtocol {
public var data: UInt { get }
public var handle: UInt { get }
public var isCancelled: Bool { get }
public var mask: UInt { get }
@available(macOS10.12, iOS10.0, tvOS10.0, watchOS3.0, *) public func activate() {}
public func cancel() {}
public func resume() {}
@available(macOS10.10, iOS8.0, *) public func setCancelHandler(handler: DispatchWorkItem) {}
public func setCancelHandler(qos: DispatchQoS = default, flags: DispatchWorkItemFlags = default, handler: DispatchSourceHandler?) {}
@available(macOS10.10, iOS8.0, *) public func setEventHandler(handler: DispatchWorkItem) {}
public func setEventHandler(qos: DispatchQoS = default, flags: DispatchWorkItemFlags = default, handler: DispatchSourceHandler?) {}
@available(macOS10.10, iOS8.0, *) public func setRegistrationHandler(handler: DispatchWorkItem) {}
public func setRegistrationHandler(qos: DispatchQoS = default, flags: DispatchWorkItemFlags = default, handler: DispatchSourceHandler?) {}
public func suspend() {}
}
extension DispatchSourceTimer {
@available(swift, introduced: 4) public func schedule(deadline: DispatchTime, repeating interval: DispatchTimeInterval = default, leeway: DispatchTimeInterval = default) {}
@available(swift, introduced: 4) public func schedule(deadline: DispatchTime, repeating interval: Double, leeway: DispatchTimeInterval = default) {}
@available(swift, introduced: 4) public func schedule(wallDeadline: DispatchWallTime, repeating interval: DispatchTimeInterval = default, leeway: DispatchTimeInterval = default) {}
@available(swift, introduced: 4) public func schedule(wallDeadline: DispatchWallTime, repeating interval: Double, leeway: DispatchTimeInterval = default) {}
}
extension DispatchSourceUserDataAdd {
public func add(data: UInt) {}
}
extension DispatchSourceUserDataOr {
public func or(data: UInt) {}
}
extension DispatchSourceUserDataReplace {
public func replace(data: UInt) {}
}
