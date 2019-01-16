public protocol DispatchSourceFileSystemObject {
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
public protocol DispatchSourceMachReceive {
#if HAVE_MACH
public var handle: mach_port_t { get }
#endif
}
public protocol DispatchSourceMachSend {
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
public protocol DispatchSourceMemoryPressure {
#if HAVE_MACH
public var data: DispatchSource.MemoryPressureEvent { get }
#endif
#if HAVE_MACH
public var mask: DispatchSource.MemoryPressureEvent { get }
#endif
}
public protocol DispatchSourceProcess {
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
public protocol DispatchSourceProtocol {
public var data: UInt { get }
public var handle: UInt { get }
public var isCancelled: Bool { get }
public var mask: UInt { get }
@available(macOS10.12, iOS10.0, tvOS10.0, watchOS3.0, *) public func activate() {}
public func cancel() {}
public func resume() {}
@available(macOS10.10, iOS8.0, *) public func setCancelHandler(handler: DispatchWorkItem) {}
public func setCancelHandler(qos: DispatchQoS = x, flags: DispatchWorkItemFlags = x, handler: DispatchSourceHandler?) {}
@available(macOS10.10, iOS8.0, *) public func setEventHandler(handler: DispatchWorkItem) {}
public func setEventHandler(qos: DispatchQoS = x, flags: DispatchWorkItemFlags = x, handler: DispatchSourceHandler?) {}
@available(macOS10.10, iOS8.0, *) public func setRegistrationHandler(handler: DispatchWorkItem) {}
public func setRegistrationHandler(qos: DispatchQoS = x, flags: DispatchWorkItemFlags = x, handler: DispatchSourceHandler?) {}
public func suspend() {}
}
public protocol DispatchSourceRead {
}
public protocol DispatchSourceSignal {
}
public protocol DispatchSourceTimer {
@available(swift, introduced: 4) public func schedule(deadline: DispatchTime, repeating interval: DispatchTimeInterval = x, leeway: DispatchTimeInterval = x) {}
@available(swift, introduced: 4) public func schedule(deadline: DispatchTime, repeating interval: Double, leeway: DispatchTimeInterval = x) {}
@available(swift, introduced: 4) public func schedule(wallDeadline: DispatchWallTime, repeating interval: DispatchTimeInterval = x, leeway: DispatchTimeInterval = x) {}
@available(swift, introduced: 4) public func schedule(wallDeadline: DispatchWallTime, repeating interval: Double, leeway: DispatchTimeInterval = x) {}
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