/*
 SampleConfiguration.swift

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
    public var option: String = "Default"

    // MARK: - Coding

    private enum CodingKeys: CodingKey {
        case option
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(option, forKey: .option)

        try super.encode(to: container.superEncoder())
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try super.init(from: container.superDecoder())

        if let option = try container.decodeIfPresent(String.self, forKey: .option) {
            self.option = option
        }
    }

    // MARK: - Configuration

    public required init() {
        super.init()
    }
}
