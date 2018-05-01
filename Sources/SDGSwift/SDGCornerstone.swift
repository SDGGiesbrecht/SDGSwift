
// [_Workaround: This belongs in SDGCornerstone_]

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

            let isDirectory = (try url.resourceValues(forKeys: [.isDirectoryKey])).isDirectory!

            if ¬isDirectory, // Skip directories.
                url.lastPathComponent ≠ ".DS_Store", // Skip irrelevant operating system files.
                ¬url.lastPathComponent.hasSuffix("~") {

                result.append(url)
            }
        }

        if let error = failureReason { // [_Exempt from Test Coverage_] It is unknown what circumstances would actually cause an error.
            throw error
        }

        return result
    }
}
