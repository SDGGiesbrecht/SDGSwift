/*
 Exports.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwiftConfiguration

/// A sample configuration.
public final class SampleConfiguration : Configuration {

    // MARK: - Properties

    /// A customizable option.
    public var option: String

    // MARK: - Configuration

    public init() {
        option = "Default"
    }
}
