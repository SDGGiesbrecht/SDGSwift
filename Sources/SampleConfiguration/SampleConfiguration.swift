/*
 SampleConfiguration.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwiftConfiguration

/// A sample configuration.
public final class SampleConfiguration : Configuration, Equatable {

    // MARK: - Properties

    /// A customizable option.
    public var option: String = "Default"

    // MARK: - Codable

    private enum CodingKeys : CodingKey {
        case option
    }

    /// Encodes the configuration.
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(option, forKey: .option)

        try super.encode(to: container.superEncoder())
    }

    /// Decodes a configuration.
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try super.init(from: container.superDecoder())

        if let option = try container.decodeIfPresent(String.self, forKey: .option) {
            self.option = option // @exempt(from: tests) False coverage result in Xcode 9.4.
        }
    }

    // MARK: - Configuration

    /// Creates the default configuration.
    public required init() {
        super.init()
    }

    // MARK: - Equatable

    /// Compares the configurations for equality.
    public static func == (precedingValue: SampleConfiguration, followingValue: SampleConfiguration) -> Bool {
        return precedingValue.option == followingValue.option
    }
}
