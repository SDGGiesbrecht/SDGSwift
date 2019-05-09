/*
 ReadMeExampleTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGXCTestUtilities

import SDGSwift

class ReadMeExampleTests : TestCase {

    func testReadMe() throws {
        try FileManager.default.withTemporaryDirectory(appropriateFor: nil) { temporaryDirectory in

            func print(_ string: String) {} // Prevent test clutter.

            // @example(readMe🇨🇦EN)
            let package = Package(url: URL(string: "https://github.com/apple/example\u{2D}package\u{2D}dealer")!)
            try package.build(.version(Version(2, 0, 0)), to: temporaryDirectory).get()
            // @endExample
        }
    }
}
