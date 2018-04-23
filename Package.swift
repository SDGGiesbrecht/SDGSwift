// swift-tools-version:4.0

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
    name: "SDGSwift",
    products: [
        .library(name: "SDGSwift", targets: ["SDGSwift"])
    ],
    dependencies: [
        .package(url: "https://github.com/SDGGiesbrecht/SDGCornerstone", .upToNextMinor(from: Version(0, 9, 0)))
    ],
    targets: [
        // Products
        .target(name: "SDGSwift", dependencies: [
            "SDGSwiftLocalizations",
            .productItem(name: "SDGControlFlow", package: "SDGCornerstone"),
            .productItem(name: "SDGLogic", package: "SDGCornerstone"),
            .productItem(name: "SDGLocalization", package: "SDGCornerstone"),
            .productItem(name: "SDGExternalProcess", package: "SDGCornerstone")
            ]),

        // Internal
        .target(name: "SDGSwiftLocalizations", dependencies: [
            .productItem(name: "SDGLocalization", package: "SDGCornerstone")
            ]),

        // Tests
        .testTarget(name: "SDGSwiftTests", dependencies: [
            "SDGSwiftLocalizations",
            "SDGSwift",
            .productItem(name: "SDGCollections", package: "SDGCornerstone"),
            .productItem(name: "SDGLocalization", package: "SDGCornerstone"),
            .productItem(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGXCTestUtilities", package: "SDGCornerstone")
            ])
    ]
)
