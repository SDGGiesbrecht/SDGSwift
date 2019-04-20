/*
 SyntaxTreeParser.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGPersistence

extension SyntaxTreeParser {

    /// Parses the Swift file at the provided URL, retrying in the event of an error.
    ///
    /// SwiftSyntax sporadically encounters errors in its communication with the compiler. In these cases, retrying often succeeds. This utility method calls `parse(_:)` over again if the first attempt encounters an error. Only if the error persists will it be thrown back to the caller.
    ///
    /// - Parameters:
    ///     - url: The URL of a Swift file.
    public static func parseAndRetry(_ url: URL) throws -> SourceFileSyntax {
        if let result = try? parse(url) {
            return result
        }
        return try parse(url) // @exempt(from: tests)
    }

    /// Parses the provided Swift source.
    ///
    /// - Parameters:
    ///     - source: A string with Swift source.
    public static func parse(_ source: String) throws -> SourceFileSyntax {
        return try FileManager.default.withTemporaryDirectory(appropriateFor: nil) { temporaryDirectory in
            let temporary = temporaryDirectory.appendingPathComponent(UUID().uuidString + ".swift")
            try? FileManager.default.removeItem(at: temporary)

            try source.save(to: temporary)
            defer { try? FileManager.default.removeItem(at: temporary) }

            return try parseAndRetry(temporary)
        }
    }
}
