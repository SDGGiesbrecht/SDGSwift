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

import SDGControlFlow
import SDGLogic

/// A Swift file.
public class File : Exerpt {

    // MARK: - Initialization

    /// Loads a Swift file.
    ///
    /// Throws: A `SourceKit.Error`.
    public init(from location: URL) throws {
        self.location = location
        let variant = try SourceKit.parse(file: location)
        let source = try String(from: location)

        let tokens = try Exerpt.tokens(fromVariant: variant, source: source)
        try super.init(substructureInformation: variant, source: source, tokens: tokens)
        postProcess(source: source)
    }

    // MARK: - Properties

    /// The location of the file.
    public var location: URL
}
