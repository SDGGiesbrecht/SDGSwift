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
        /// A basic interface for the Swift compiler.
        ///
        /// This module includes development time tasks such as building and testing. It uses the command‐line interface and provides the command line output in real time.
        .library(name: "SDGSwift", targets: ["SDGSwift"]),

        /// Utilities for working with the Swift package manager.
        ///
        /// This module uses the Swift API and provides more fine‐grained access to the details of a package’s structure than is available from the command line.
        .library(name: "SDGSwiftPackageManager", targets: ["SDGSwiftPackageManager"]),

        /// Utilities for working with Swift source code.
        // [_Workaround: SDGSwiftSource is still not ready to publish._]
        //.library(name: "SDGSwiftSource", targets: ["SDGSwiftSource"]),

        /// Xcode‐related utilities for working with Swift packages.
        .library(name: "SDGXcode", targets: ["SDGXcode"]),

        /// Utilities for defining configuration files written in Swift (similar to package manifests).
        .library(name: "SDGSwiftConfiguration", targets: ["SDGSwiftConfiguration"]),
        /// Utilities for loading configuration files written in Swift (similar to package manifests).
        .library(name: "SDGSwiftConfigurationLoading", targets: ["SDGSwiftConfigurationLoading"]),
        /// A sample configuration demonstrating the use of `SDGSwiftConfiguration` and `SDGSwiftConfigurationLoading`.
        .library(name: "SampleConfiguration", targets: ["SampleConfiguration"])
    ],
    dependencies: [
        .package(url: "https://github.com/SDGGiesbrecht/SDGCornerstone", .upToNextMinor(from: Version(0, 10, 0))),
        .package(url: "https://github.com/apple/swift\u{2D}package\u{2D}manager", .exact(Version(0, 2, 0)))
    ],
    targets: [

        // Products
        .target(name: "SDGSwift", dependencies: [
            "SDGSwiftLocalizations",
            .productItem(name: "SDGControlFlow", package: "SDGCornerstone"),
            .productItem(name: "SDGLogic", package: "SDGCornerstone"),
            .productItem(name: "SDGCollections", package: "SDGCornerstone"),
            .productItem(name: "SDGText", package: "SDGCornerstone"),
            .productItem(name: "SDGLocalization", package: "SDGCornerstone"),
            .productItem(name: "SDGExternalProcess", package: "SDGCornerstone")
            ]),
        .target(name: "SDGSwiftPackageManager", dependencies: [
            "SDGSwift",
            "SDGSwiftLocalizations",
            .productItem(name: "SwiftPM", package: "swift\u{2D}package\u{2D}manager")
            ]),
        .target(name: "SDGSwiftSource", dependencies: [
            "SDGSwift",
            "SDGSwiftLocalizations",
            "SDGSourceKitShims",
            .productItem(name: "SDGControlFlow", package: "SDGCornerstone"),
            .productItem(name: "SDGLogic", package: "SDGCornerstone"),
            .productItem(name: "SDGMathematics", package: "SDGCornerstone"),
            .productItem(name: "SDGCollections", package: "SDGCornerstone"),
            .productItem(name: "SDGLocalization", package: "SDGCornerstone")
            ]),
        .target(name: "SDGXcode", dependencies: [
            "SDGSwift",
            "SDGSwiftLocalizations",
            .productItem(name: "SDGControlFlow", package: "SDGCornerstone"),
            .productItem(name: "SDGLogic", package: "SDGCornerstone"),
            .productItem(name: "SDGMathematics", package: "SDGCornerstone"),
            .productItem(name: "SDGCollections", package: "SDGCornerstone"),
            .productItem(name: "SDGText", package: "SDGCornerstone"),
            .productItem(name: "SDGLocalization", package: "SDGCornerstone"),
            .productItem(name: "SDGExternalProcess", package: "SDGCornerstone")
            ]),
        .target(name: "SDGSwiftConfiguration"),
        .target(name: "SDGSwiftConfigurationLoading", dependencies: [
            "SDGSwiftLocalizations",
            "SDGSwiftConfiguration",
            "SDGSwift",
            .productItem(name: "SDGLogic", package: "SDGCornerstone"),
            .productItem(name: "SDGLocalization", package: "SDGCornerstone")
            ]),

        // Samples
        .target(name: "SampleConfiguration", dependencies: ["SDGSwiftConfiguration"]),

        // Internal
        .target(name: "SDGSwiftLocalizations", dependencies: [
            .productItem(name: "SDGLocalization", package: "SDGCornerstone")
            ]),
        .target(name: "SDGSourceKitShims"),

        // Tests
        .target(name: "SDGSwiftTestUtilities", dependencies: [
            "SDGSwift",
            "SDGSwiftPackageManager",
            .productItem(name: "SDGPersistence", package: "SDGCornerstone"),
            .productItem(name: "SDGExternalProcess", package: "SDGCornerstone")
            ], path: "Tests/SDGSwiftTestUtilities"),
        .testTarget(name: "SDGSwiftTests", dependencies: [
            "SDGSwiftLocalizations",
            "SDGSwift",
            "SDGSwiftTestUtilities",
            .productItem(name: "SDGCollections", package: "SDGCornerstone"),
            .productItem(name: "SDGLocalization", package: "SDGCornerstone"),
            .productItem(name: "SDGLogicTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGXCTestUtilities", package: "SDGCornerstone")
            ]),
        .testTarget(name: "SDGSwiftPackageManagerTests", dependencies: [
            "SDGSwiftPackageManager",
            "SDGSwiftLocalizations",
            "SDGSwiftTestUtilities",
            .productItem(name: "SDGText", package: "SDGCornerstone"),
            .productItem(name: "SDGPersistence", package: "SDGCornerstone"),
            .productItem(name: "SDGXCTestUtilities", package: "SDGCornerstone")
            ]),
        .testTarget(name: "SDGSwiftSourceTests", dependencies: [
            "SDGSwiftLocalizations",
            "SDGSwiftSource",
            .productItem(name: "SDGLogic", package: "SDGCornerstone"),
            .productItem(name: "SDGCollections", package: "SDGCornerstone"),
            .productItem(name: "SDGLogicTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGPersistenceTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGXCTestUtilities", package: "SDGCornerstone")
            ]),
        .testTarget(name: "SDGXcodeTests", dependencies: [
            "SDGXcode",
            "SDGSwift",
            "SDGSwiftLocalizations",
            "SDGSwiftTestUtilities",
            .productItem(name: "SDGLogic", package: "SDGCornerstone"),
            .productItem(name: "SDGCollections", package: "SDGCornerstone"),
            .productItem(name: "SDGPersistence", package: "SDGCornerstone"),
            .productItem(name: "SDGPersistenceTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGXCTestUtilities", package: "SDGCornerstone")
            ]),
        .testTarget(name: "SDGSwiftConfigurationTests", dependencies: [
            "SDGSwiftConfiguration",
            "SDGSwiftConfigurationLoading",
            "SampleConfiguration",
            .productItem(name: "SDGPersistenceTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone"),
            .productItem(name: "SDGXCTestUtilities", package: "SDGCornerstone")
            ]),
        .testTarget(name: "SDGSwiftDocumentationExampleTests", dependencies: [
            "SDGSwift",
            .productItem(name: "SDGXCTestUtilities", package: "SDGCornerstone")
            ])
    ]
)
