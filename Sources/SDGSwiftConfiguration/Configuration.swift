/*
 Configuration.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An abstract superclass for a type representing an overall configuration.
///
/// The concrete subclass is comparable to the `Package` type in a package manifest.
open class Configuration : Codable {

    // MARK: - Static Properties

    internal static var registered: Configuration?

    // MARK: - Initialization

    /// Creates a configuration and registers it for export.
    ///
    /// The result of this initializer represents the default configuration, and will also be used if no configuration file exists.
    public required init() { // [_Exempt from Test Coverage_] False coverage result in Xcode 9.4.
        Configuration.registered = self
    }
}
