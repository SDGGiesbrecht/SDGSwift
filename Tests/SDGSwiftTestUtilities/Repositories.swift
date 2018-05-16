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

import SDGExternalProcess

import SDGSwift
import SDGSwiftPackageManager

public let thisRepository = PackageRepository(at: URL(fileURLWithPath: #file).deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent())

private func withMock(file: StaticString = #file, line: UInt = #line, test: (URL) throws -> Void) throws {
    let mock = URL(fileURLWithPath: "/tmp/Mock") // Fixed path to prevent run‐away growth of Xcode’s derived data.
    try? FileManager.default.removeItem(at: mock)
    defer { try? FileManager.default.removeItem(at: mock) }

    try test(mock)
}

public func withDefaultMockRepository(file: StaticString = #file, line: UInt = #line, test: (PackageRepository) throws -> Void) {
    do {
        return try withMock(file: file, line: line) { mock in
            let repository = try PackageRepository(initializingAt: mock, type: .library)
            try test(repository)
        }
    } catch {
        XCTFail("\(error)", file: file, line: line)
    }
}

public func withMockDynamicLinkedExecutable(file: StaticString = #file, line: UInt = #line, test: (PackageRepository) throws -> Void) {
    do {
        let mocksDirectory = thisRepository.location.appendingPathComponent("Tests/Mock Projects")

        var mocks: [PackageRepository] = []
        defer {
            for mock in mocks {
                try? FileManager.default.removeItem(at: mock.location)
            }
        }
        @discardableResult func setUpMock(named name: String) throws -> PackageRepository {
            let mock = PackageRepository(at: URL(fileURLWithPath: "/tmp/" + name))
            try? FileManager.default.removeItem(at: mock.location)
            mocks.append(mock)
            try FileManager.default.copy(mocksDirectory.appendingPathComponent(name), to: mock.location)
            try Shell.default.run(command: ["git", "init"], in: mock.location)
            try Shell.default.run(command: ["git", "add", "."], in: mock.location)
            try Shell.default.run(command: ["git", "commit", "\u{2D}m", "Initialized."], in: mock.location)
            return mock
        }

        try setUpMock(named: "DynamicLibraryA")
        try setUpMock(named: "DynamicLibraryB")
        let tool = try setUpMock(named: "DynamicallyLinkedTool")

        try test(tool)
    } catch {
        XCTFail("\(error)", file: file, line: line)
    }
}
