/*
 Package.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import PackageDescription

let package = Package(
    name: "Package",
    products: [
        /// A library.
        .library(name: "Library", targets: ["Library"])
    ],
    dependencies: [
        .package(url: "https://domain.tld/Package", from: Version(1, 0, 0))
    ],
    targets: [

        /// A library.
        .target(name: "Library", dependencies: [
            "Target"
            ]),
        /// A target.
        .target(name: "Target", dependencies: []),
        .testTarget(name: "Tests", dependencies: [
            "Library",
            "Target"
            ])
    ]
)
