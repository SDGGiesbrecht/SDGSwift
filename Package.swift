// swift-tools-version:5.0

/*
 Package.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import PackageDescription

/// SDGSwift enables use of the Swift compiler as a package dependency.
///
/// > [השֹּׁלֵחַ אִמְרָתוֹ אָרֶץ עַד־מְהֵרָה יָרוּץ דְּבָרוֹ׃](https://www.biblegateway.com/passage/?search=Psalm+147:15&version=WLC;NIV)
/// >
/// > [He sends His command to the earth; His word runs swiftly.](https://www.biblegateway.com/passage/?search=Psalm+147:15&version=WLC;NIV)
/// >
/// > ―a psalmist
///
/// ### Features
///
/// - Compiler operations such as building and testing: `SDGSwift`, `SDGXcode`
/// - Package Manager operations such as fetching and manifest loading: `SDGSwiftPackageManager`
/// - Utilities for defining configuration files written in Swift (similar to package manifests): `SDGSwiftConfiguration`, `SDGSwiftConfigurationLoading`
let package = Package(
    name: "SDGSwift",
    platforms: [
        // These must also be updated in Sources/SDGSwiftConfigurationLoading/Configuration.swift.
        .macOS(.v10_13)
    ],
    products: [
        // @documentation(SDGSwift)
        /// A basic interface for the Swift compiler.
        ///
        /// This module includes development‐time tasks such as building and testing. It uses the command‐line interface and provides the command line output in real time.
        .library(name: "SDGSwift", targets: ["SDGSwift"]),

        // @documentation(SDGSwiftPackageManager)
        /// Utilities for working with the Swift package manager.
        ///
        /// This module uses the Swift API and provides more fine‐grained access to the details of a package’s structure than is available from the command line.
        .library(name: "SDGSwiftPackageManager", targets: ["SDGSwiftPackageManager"]),

        // @documentation(SDGSwiftSource)
        /// Utilities for working with Swift source code.
        ///
        /// This module is built on SwiftSyntax and provides utilities such as syntax colouring and API parsing.
        .library(name: "SDGSwiftSource", targets: ["SDGSwiftSource"]),

        // @documentation(SDGXcode)
        /// Xcode‐related utilities for working with Swift packages.
        .library(name: "SDGXcode", targets: ["SDGXcode"]),

        // @documentation(SDGSwiftConfiguration)
        /// Utilities for defining configuration files written in Swift (similar to package manifests).
        .library(name: "SDGSwiftConfiguration", targets: ["SDGSwiftConfiguration"]),

        // @documentation(SDGSwiftConfigurationLoading)
        /// Utilities for loading configuration files written in Swift (similar to package manifests).
        .library(name: "SDGSwiftConfigurationLoading", targets: ["SDGSwiftConfigurationLoading"]),

        // @documentation(SampleConfiguration)
        /// A sample configuration demonstrating the use of `SDGSwiftConfiguration` and `SDGSwiftConfigurationLoading`.
        .library(name: "SampleConfiguration", targets: ["SampleConfiguration"])
    ],
    dependencies: [
        .package(url: "https://github.com/SDGGiesbrecht/SDGCornerstone", .upToNextMinor(from: Version(0, 17, 0))),
        .package(url: "https://github.com/SDGGiesbrecht/swift\u{2D}package\u{2D}manager", .exact(Version(0, 0, 50000))),
        .package(url: "https://github.com/apple/swift\u{2D}syntax", .exact(Version(0, 50000, 0)))
    ],
    targets: [

        // Products

        // #documentation(SDGSwift)
        /// A basic interface for the Swift compiler.
        ///
        /// This module includes development‐time tasks such as building and testing. It uses the command‐line interface and provides the command line output in real time.
        .target(name: "SDGSwift", dependencies: [
            "SDGSwiftLocalizations",
            .product(name: "SDGControlFlow", package: "SDGCornerstone"),
            .product(name: "SDGLogic", package: "SDGCornerstone"),
            .product(name: "SDGCollections", package: "SDGCornerstone"),
            .product(name: "SDGText", package: "SDGCornerstone"),
            .product(name: "SDGLocalization", package: "SDGCornerstone"),
            .product(name: "SDGExternalProcess", package: "SDGCornerstone")
            ]),

        // #documentation(SDGSwiftPackageManager)
        /// Utilities for working with the Swift package manager.
        ///
        /// This module uses the Swift API and provides more fine‐grained access to the details of a package’s structure than is available from the command line.
        .target(name: "SDGSwiftPackageManager", dependencies: [
            "SDGSwift",
            "SDGSwiftLocalizations",
            .product(name: "SwiftPM\u{2D}auto", package: "swift\u{2D}package\u{2D}manager")
            ]),

        // #documentation(SDGSwiftSource)
        /// Utilities for working with Swift source code.
        ///
        /// This module is built on SwiftSyntax and provides utilities such as syntax colouring and API parsing.
        .target(name: "SDGSwiftSource", dependencies: [
            "SDGSwift",
            "SDGSwiftPackageManager",
            "SDGSwiftLocalizations",
            "SDGCMarkShims",
            .product(name: "SDGControlFlow", package: "SDGCornerstone"),
            .product(name: "SDGLogic", package: "SDGCornerstone"),
            .product(name: "SDGMathematics", package: "SDGCornerstone"),
            .product(name: "SDGCollections", package: "SDGCornerstone"),
            .product(name: "SDGText", package: "SDGCornerstone"),
            .product(name: "SDGPersistence", package: "SDGCornerstone"),
            .product(name: "SDGLocalization", package: "SDGCornerstone"),
            .product(name: "SwiftSyntax", package: "swift\u{2D}syntax")
            ], swiftSettings: [
                .define("UNIDENTIFIED_SYNTAX_WARNINGS", .when(configuration: .debug))
            ]),

        // #documentation(SDGXcode)
        /// Xcode‐related utilities for working with Swift packages.
        .target(name: "SDGXcode", dependencies: [
            "SDGSwift",
            "SDGSwiftPackageManager",
            "SDGSwiftLocalizations",
            .product(name: "SDGControlFlow", package: "SDGCornerstone"),
            .product(name: "SDGLogic", package: "SDGCornerstone"),
            .product(name: "SDGMathematics", package: "SDGCornerstone"),
            .product(name: "SDGCollections", package: "SDGCornerstone"),
            .product(name: "SDGText", package: "SDGCornerstone"),
            .product(name: "SDGLocalization", package: "SDGCornerstone"),
            .product(name: "SDGExternalProcess", package: "SDGCornerstone")
            ]),

        // #documentation(SDGSwiftConfiguration)
        /// Utilities for defining configuration files written in Swift (similar to package manifests).
        .target(name: "SDGSwiftConfiguration"),

        // #documentation(SDGSwiftConfigurationLoading)
        /// Utilities for loading configuration files written in Swift (similar to package manifests).
        .target(name: "SDGSwiftConfigurationLoading", dependencies: [
            "SDGSwiftLocalizations",
            "SDGSwiftConfiguration",
            "SDGSwift",
            .product(name: "SDGLogic", package: "SDGCornerstone"),
            .product(name: "SDGLocalization", package: "SDGCornerstone")
            ]),

        // Samples

        // #documentation(SampleConfiguration)
        /// A sample configuration demonstrating the use of `SDGSwiftConfiguration` and `SDGSwiftConfigurationLoading`.
        .target(name: "SampleConfiguration", dependencies: ["SDGSwiftConfiguration"]),

        // Internal

        .target(name: "SDGSwiftLocalizations", dependencies: [
            .product(name: "SDGLocalization", package: "SDGCornerstone")
            ]),

        // This is duplicated from the Swift project itself, since stable releases do not expose the API.
        .target(name: "SDGCMarkShims", dependencies: [
            ], path: "Sources/Shims/SDGCMarkShims"),

        .target(name: "refresh‐core‐libraries", dependencies: [
            "SDGSwiftPackageManager",
            "SDGSwiftSource",
            .product(name: "SDGControlFlow", package: "SDGCornerstone"),
            .product(name: "SDGLogic", package: "SDGCornerstone"),
            .product(name: "SDGPersistence", package: "SDGCornerstone"),
            .product(name: "SDGExternalProcess", package: "SDGCornerstone")
            ]),

        // Tests
        .target(name: "SDGSwiftTestUtilities", dependencies: [
            "SDGSwift",
            "SDGSwiftPackageManager",
            .product(name: "SDGPersistence", package: "SDGCornerstone"),
            .product(name: "SDGExternalProcess", package: "SDGCornerstone")
            ], path: "Tests/SDGSwiftTestUtilities"),
        .testTarget(name: "SDGSwiftTests", dependencies: [
            "SDGSwiftLocalizations",
            "SDGSwift",
            "SDGSwiftTestUtilities",
            .product(name: "SDGCollections", package: "SDGCornerstone"),
            .product(name: "SDGLocalization", package: "SDGCornerstone"),
            .product(name: "SDGLogicTestUtilities", package: "SDGCornerstone"),
            .product(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone"),
            .product(name: "SDGXCTestUtilities", package: "SDGCornerstone")
            ]),
        .testTarget(name: "SDGSwiftPackageManagerTests", dependencies: [
            "SDGSwiftPackageManager",
            "SDGSwiftLocalizations",
            "SDGSwiftTestUtilities",
            .product(name: "SDGText", package: "SDGCornerstone"),
            .product(name: "SDGPersistence", package: "SDGCornerstone"),
            .product(name: "SDGPersistenceTestUtilities", package: "SDGCornerstone"),
            .product(name: "SDGXCTestUtilities", package: "SDGCornerstone")
            ]),
        .testTarget(name: "SDGSwiftSourceTests", dependencies: [
            "SDGSwiftLocalizations",
            "SDGSwiftSource",
            "SDGSwiftTestUtilities",
            .product(name: "SDGLogic", package: "SDGCornerstone"),
            .product(name: "SDGCollections", package: "SDGCornerstone"),
            .product(name: "SDGLogicTestUtilities", package: "SDGCornerstone"),
            .product(name: "SDGPersistenceTestUtilities", package: "SDGCornerstone"),
            .product(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone"),
            .product(name: "SDGXCTestUtilities", package: "SDGCornerstone")
            ]),
        .testTarget(name: "SDGXcodeTests", dependencies: [
            "SDGXcode",
            "SDGSwift",
            "SDGSwiftLocalizations",
            "SDGSwiftTestUtilities",
            .product(name: "SDGLogic", package: "SDGCornerstone"),
            .product(name: "SDGCollections", package: "SDGCornerstone"),
            .product(name: "SDGPersistence", package: "SDGCornerstone"),
            .product(name: "SDGPersistenceTestUtilities", package: "SDGCornerstone"),
            .product(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone"),
            .product(name: "SDGXCTestUtilities", package: "SDGCornerstone")
            ]),
        .testTarget(name: "SDGSwiftConfigurationTests", dependencies: [
            "SDGSwiftConfiguration",
            "SDGSwiftConfigurationLoading",
            "SampleConfiguration",
            .product(name: "SDGLogic", package: "SDGCornerstone"),
            .product(name: "SDGCollections", package: "SDGCornerstone"),
            .product(name: "SDGPersistenceTestUtilities", package: "SDGCornerstone"),
            .product(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone"),
            .product(name: "SDGXCTestUtilities", package: "SDGCornerstone")
            ]),
        .testTarget(name: "SDGSwiftDocumentationExampleTests", dependencies: [
            "SDGSwift",
            .product(name: "SDGXCTestUtilities", package: "SDGCornerstone")
            ])
    ],
    cxxLanguageStandard: .cxx14
)
