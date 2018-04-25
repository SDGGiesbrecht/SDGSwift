/*
 Repositories.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
import XCTest

import SDGSwift
import SDGSwiftPackageManager

public let thisRepository = PackageRepository(at: URL(fileURLWithPath: #file).deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent())

public func withDefaultMockRepository(file: StaticString = #file, line: UInt = #line, test: (PackageRepository) throws -> Void) {
    let mock = FileManager.default.url(in: .temporary, at: "Mock")
    defer { try? FileManager.default.removeItem(at: mock) }

    do {
        let repository = try PackageRepository(initializingAt: mock, type: .library)
        try test(repository)
    } catch {
        XCTFail("\(error)", file: file, line: line)
    }
}
