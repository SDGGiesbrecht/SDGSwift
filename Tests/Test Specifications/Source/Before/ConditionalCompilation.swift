/*
 ConditionalCompilation.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if os(macOS)
/// Falls on Newton.
func fallOnNewton() {}
#elseif os(Linux)
/// Waddles.
func waddle() {}
#endif

#if canImport(AppKit)
public typealias WithAppKit = Bool
public typealias Universal = Bool
#elseif canImport(UIKit)
public typealias WithUIKit = Bool
public typealias Universal = Bool
#else
public typealias Fallback = Bool
public typealias Universal = Bool
#endif

public struct NestingStructure {

    #if canImport(AppKit)
    public typealias WithAppKit = Bool
    public typealias Universal = Bool
    #elseif canImport(UIKit)
    public typealias WithUIKit = Bool
    public typealias Universal = Bool
    #else
    public typealias Fallback = Bool
    public typealias Universal = Bool
    #endif
}
