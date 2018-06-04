/*
 Configuration.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The type which represents the overall configuration.
///
/// This is comparable to the `Package` type in a package manifest.
public protocol Configuration : class, Codable {

    /// Creates the default configuration.
    ///
    /// This is the configuration which will be used when there is no configuration file.
    init()
}
