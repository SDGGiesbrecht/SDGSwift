/*
 SDGCornerstone.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Workaround: This belongs in SDGCornerstone. (SDGCornerstone 0.9.2)_]

import Foundation

import SDGLogic

extension FileManager {

    static let unknownFileReadingError = NSError(domain: NSCocoaErrorDomain, code: NSFileReadUnknownError, userInfo: nil)

    func deepFileEnumeration(in directory: URL) throws -> [URL] {

        var failureReason: Error? // Thrown after enumeration stops. (See below.)
        guard let enumerator = FileManager.default.enumerator(at: directory, includingPropertiesForKeys: [.isDirectoryKey], options: [], errorHandler: { (_, error: Error) -> Bool in // [_Exempt from Test Coverage_] It is unknown what circumstances would actually cause an error.
            failureReason = error
            return false // Stop.
        }) else { // [_Exempt from Test Coverage_] It is unknown what circumstances would actually result in a `nil` enumerator being returned.
            throw FileManager.unknownFileReadingError
        }

        var result: [URL] = []
        for object in enumerator {
            guard let url = object as? URL else { // [_Exempt from Test Coverage_] It is unknown why something other than a URL would be returned.
                throw FileManager.unknownFileReadingError
            }

            let isDirectory: Bool
            #if os(Linux)
            var objCBool: ObjCBool = false
            isDirectory = FileManager.default.fileExists(atPath: url.path, isDirectory: &objCBool) ∧ objCBool.boolValue
            #else
            isDirectory = (try url.resourceValues(forKeys: [.isDirectoryKey])).isDirectory!
            #endif

            if ¬isDirectory { // Skip directories.
                result.append(url)
            }
        }

        if let error = failureReason { // [_Exempt from Test Coverage_] It is unknown what circumstances would actually cause an error.
            throw error
        }

        return result
    }
}
