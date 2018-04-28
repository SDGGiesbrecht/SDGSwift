/*
 ReadMeExampleTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGXCTestUtilities

import SDGSwift

class SDGReadMeExampleTests : TestCase {

    func testReadMe() {
        let temporaryDirectory = FileManager.default.url(in: .temporary, at: "Example")
        defer { FileManager.default.delete(.temporary) }

        func print(_ string: String) {} // Prevent test clutter.

        // [_Define Example: Read‐Me 🇨🇦EN_]
        do {
            let package = Package(url: URL(string: "https://github.com/apple/example-package-dealer")!)
            try package.build(.version(Version(2, 0, 0)), to: temporaryDirectory, reportProgress: { print($0) })
        } catch {
            XCTFail("\(error)")
        }
        // [_End_]
    }

    static var allTests = [
        ("testReadMe", testReadMe)
    ]
}
