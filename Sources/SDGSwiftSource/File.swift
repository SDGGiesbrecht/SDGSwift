/*
 File.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

/// A Swift file.
public struct File {

    // MARK: - Initialization

    /// Loads a Swift file.
    ///
    /// Throws: A `SourceKit.Error`.
    public init(from location: URL) throws {
        self = try SourceKit.parse(file: location)
    }

    internal init(variant: SourceKit.Variant) throws {
        let dictionary: [String: SourceKit.Variant]
        switch variant {
        case .dictionary(let contents):
            dictionary = contents
        default:
            throw SourceKit.Error.unknownResponse(contents: variant.asAny())
        }

        let entities: [SourceKit.Variant]
        if let entitiesVariant = dictionary["key.entities"] {
            switch entitiesVariant {
            case .array(let array):
                entities = array
            default:
                throw SourceKit.Error.unknownResponse(contents: entitiesVariant.asAny())
            }
        } else {
            entities = []
        }

        // [_Warning: Not finished._]

        print("Entities:")
        print(entities.map({ $0.asAny() }))
    }
}
