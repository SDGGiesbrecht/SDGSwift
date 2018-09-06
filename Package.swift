// swift-tools-version:4.1

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
    products: [
        // @documentation(SDGSwift)
        /// A basic interface for the Swift compiler.
        ///
        /// This module includes development time tasks such as building and testing. It uses the command‐line interface and provides the command line output in real time.
        .library(name: "SDGSwift", targets: ["SDGSwift"]),

        // @documentation(SDGSwiftPackageManager)
        /// Utilities for working with the Swift package manager.
        ///
        /// This module uses the Swift API and provides more fine‐grained access to the details of a package’s structure than is available from the command line.
        .library(name: "SDGSwiftPackageManager", targets: ["SDGSwiftPackageManager"]),

        // @documentation(SDGSwiftSource)
        /// Utilities for working with Swift source code.
        // SDGSwiftSource is NOT YET READY FOR EXTERNAL USE. It is not a documented part of the package API, and the semantic versioning of releases does not take changes to it into account.
        // #workaround(Until SDGSwiftSource is ready to publish.)
        .library(name: /* NOT FOR EXTERNAL USE YET */"_SDGSwiftSource", targets: ["SDGSwiftSource"]),

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
        .package(url: "https://github.com/SDGGiesbrecht/SDGCornerstone", .upToNextMinor(from: Version(0, 10, 0))),
        .package(url: "https://github.com/apple/swift\u{2D}package\u{2D}manager", .exact(Version(0, 2, 0)))
    ],
    targets: [

        // Products

        // #documentation(SDGSwift)
        /// A basic interface for the Swift compiler.
        ///
        /// This module includes development time tasks such as building and testing. It uses the command‐line interface and provides the command line output in real time.
        .target(name: "SDGSwift", dependencies: [
            "SDGSwiftLocalizations",
            .productItem(name: "SDGControlFlow", package: "SDGCornerstone"),
            .productItem(name: "SDGLogic", package: "SDGCornerstone"),
            .productItem(name: "SDGCollections", package: "SDGCornerstone"),
            .productItem(name: "SDGText", package: "SDGCornerstone"),
            .productItem(name: "SDGLocalization", package: "SDGCornerstone"),
            .productItem(name: "SDGExternalProcess", package: "SDGCornerstone")
            ]),

        // #documentation(SDGSwiftPackageManager)
        /// Utilities for working with the Swift package manager.
        ///
        /// This module uses the Swift API and provides more fine‐grained access to the details of a package’s structure than is available from the command line.
        .target(name: "SDGSwiftPackageManager", dependencies: [
            "SDGSwift",
            "SDGSwiftLocalizations",
            .productItem(name: "SwiftPM", package: "swift\u{2D}package\u{2D}manager")
            ]),

        // #documentation(SDGSwiftSource)
        /// Utilities for working with Swift source code.
        .target(name: "SDGSwiftSource", dependencies: [
            "SDGSwift",
            "SDGSwiftPackageManager",
            "SDGSwiftLocalizations",
            "SDGSwiftSyntaxShims",
            "SDGCMarkShims",
            .productItem(name: "SDGControlFlow", package: "SDGCornerstone"),
            .productItem(name: "SDGLogic", package: "SDGCornerstone"),
            .productItem(name: "SDGMathematics", package: "SDGCornerstone"),
            .productItem(name: "SDGCollections", package: "SDGCornerstone"),
            .productItem(name: "SDGText", package: "SDGCornerstone"),
            .productItem(name: "SDGPersistence", package: "SDGCornerstone"),
            .productItem(name: "SDGLocalization", package: "SDGCornerstone")
            ]),

        // #documentation(SDGXcode)
        /// Xcode‐related utilities for working with Swift packages.
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

        // #documentation(SDGSwiftConfiguration)
        /// Utilities for defining configuration files written in Swift (similar to package manifests).
        .target(name: "SDGSwiftConfiguration"),

        // #documentation(SDGSwiftConfigurationLoading)
        /// Utilities for loading configuration files written in Swift (similar to package manifests).
        .target(name: "SDGSwiftConfigurationLoading", dependencies: [
            "SDGSwiftLocalizations",
            "SDGSwiftConfiguration",
            "SDGSwift",
            .productItem(name: "SDGLogic", package: "SDGCornerstone"),
            .productItem(name: "SDGLocalization", package: "SDGCornerstone")
            ]),

        // Samples

        // #documentation(SampleConfiguration)
        /// A sample configuration demonstrating the use of `SDGSwiftConfiguration` and `SDGSwiftConfigurationLoading`.
        .target(name: "SampleConfiguration", dependencies: ["SDGSwiftConfiguration"]),

        // Internal

        .target(name: "SDGSwiftLocalizations", dependencies: [
            .productItem(name: "SDGLocalization", package: "SDGCornerstone")
            ]),

        // These are duplicated from the Swift project itself, since stable releases do not expose the API yet.
        .target(name: "SDGSwiftSyntaxShims", dependencies: [
            "SDGSwift",
            .productItem(name: "SDGControlFlow", package: "SDGCornerstone"),
            .productItem(name: "SDGExternalProcess", package: "SDGCornerstone")
            ], path: "Sources/Shims/SDGSwiftSyntaxShims"),
        .target(name: "SDGCMarkShims", dependencies: [
            ], path: "Sources/Shims/SDGCMarkShims"),

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
            "SDGSwiftTestUtilities",
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
            .productItem(name: "SDGLogic", package: "SDGCornerstone"),
            .productItem(name: "SDGCollections", package: "SDGCornerstone"),
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
