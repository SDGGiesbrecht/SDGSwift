public protocol DispatchSourceFileSystemObject {
#if !os(Linux) && !os(Android) && !os(Windows)
    var data: DispatchSource.FileSystemEvent { get }
#endif
#if !os(Linux) && !os(Android) && !os(Windows)
    var handle: Int32 { get }
#endif
#if !os(Linux) && !os(Android) && !os(Windows)
    var mask: DispatchSource.FileSystemEvent { get }
#endif
}
public protocol DispatchSourceMachReceive {
#if HAVE_MACH
    var handle: mach_port_t { get }
#endif
}
public protocol DispatchSourceMachSend {
#if HAVE_MACH
    var data: DispatchSource.MachSendEvent { get }
#endif
#if HAVE_MACH
    var handle: mach_port_t { get }
#endif
#if HAVE_MACH
    var mask: DispatchSource.MachSendEvent { get }
#endif
}
public protocol DispatchSourceMemoryPressure {
#if HAVE_MACH
    var data: DispatchSource.MemoryPressureEvent { get }
#endif
#if HAVE_MACH
    var mask: DispatchSource.MemoryPressureEvent { get }
#endif
}
public protocol DispatchSourceProcess {
#if !os(Linux) && !os(Android) && !os(Windows)
    var data: DispatchSource.ProcessEvent { get }
#endif
#if !os(Linux) && !os(Android) && !os(Windows)
    var handle: pid_t { get }
#endif
#if !os(Linux) && !os(Android) && !os(Windows)
    var mask: DispatchSource.ProcessEvent { get }
#endif
}
public protocol DispatchSourceProtocol {
    var data: UInt { get }
    var handle: UInt { get }
    var isCancelled: Bool { get }
    var mask: UInt { get }
    @available(macOS10.12, iOS10.0, tvOS10.0, watchOS3.0, *) func activate()
    func cancel()
    func resume()
    @available(macOS10.10, iOS8.0, *) func setCancelHandler(handler: DispatchWorkItem)
    func setCancelHandler(qos: DispatchQoS = x, flags: DispatchWorkItemFlags = x, handler: DispatchSourceHandler?)
    @available(macOS10.10, iOS8.0, *) func setEventHandler(handler: DispatchWorkItem)
    func setEventHandler(qos: DispatchQoS = x, flags: DispatchWorkItemFlags = x, handler: DispatchSourceHandler?)
    @available(macOS10.10, iOS8.0, *) func setRegistrationHandler(handler: DispatchWorkItem)
    func setRegistrationHandler(qos: DispatchQoS = x, flags: DispatchWorkItemFlags = x, handler: DispatchSourceHandler?)
    func suspend()
}
public protocol DispatchSourceRead {
}
public protocol DispatchSourceSignal {
}
public protocol DispatchSourceTimer {
    @available(swift, introduced: 4) func schedule(deadline: DispatchTime, repeating interval: DispatchTimeInterval = x, leeway: DispatchTimeInterval = x)
    @available(swift, introduced: 4) func schedule(deadline: DispatchTime, repeating interval: Double, leeway: DispatchTimeInterval = x)
    @available(swift, introduced: 4) func schedule(wallDeadline: DispatchWallTime, repeating interval: DispatchTimeInterval = x, leeway: DispatchTimeInterval = x)
    @available(swift, introduced: 4) func schedule(wallDeadline: DispatchWallTime, repeating interval: Double, leeway: DispatchTimeInterval = x)
    func scheduleOneshot(deadline: DispatchTime, leeway: DispatchTimeInterval)
    func scheduleOneshot(wallDeadline: DispatchWallTime, leeway: DispatchTimeInterval)
    func scheduleRepeating(deadline: DispatchTime, interval: DispatchTimeInterval, leeway: DispatchTimeInterval)
    func scheduleRepeating(wallDeadline: DispatchWallTime, interval: DispatchTimeInterval, leeway: DispatchTimeInterval)
}
public protocol DispatchSourceUserDataAdd {
    func add(data: UInt)
}
public protocol DispatchSourceUserDataOr {
    func or(data: UInt)
}
public protocol DispatchSourceUserDataReplace {
    func replace(data: UInt)
}
public protocol DispatchSourceWrite {
}