/*
 SDGSwiftTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGPersistence
import SDGXCTestUtilities

import SDGSwiftPackageManager

let thisRepository = PackageRepository(at: URL(fileURLWithPath: #file).deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent())

class SDGSwiftPackageManagerTests : TestCase {

    func testInitialization() {
        do {
            // [_Warning: Move to sane location._]
            let location = URL(fileURLWithPath: NSHomeDirectory() + "/Desktop/Experiment")
            try? FileManager.default.removeItem(at: location)
            // [_Warning: Restore clean‐up._]
            //defer { try? FileManager.default.removeItem(at: location) }

            _ = try PackageRepository(initializingAt: location, type: .library)
        } catch {
            XCTFail("\(error)")
        }
    }

    static var allTests = [
        ("testInitialization", testInitialization)
    ]
}
