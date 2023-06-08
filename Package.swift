// swift-tools-version:5.7

/*
 Package.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import PackageDescription

// #example(1, readMe🇨🇦EN) #example(2, conditions)
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
///
/// ### Example Usage
///
/// ```swift
/// let package = Package(
///   url: URL(string: "https://github.com/apple/example\u{2D}package\u{2D}dealer")!
/// )
/// try package.build(.version(Version(2, 0, 0)), to: temporaryDirectory).get()
/// ```
///
/// Some platforms lack certain features. The compilation conditions which appear throughout the documentation are defined as follows:
///
/// ```swift
/// .define("PLATFORM_LACKS_FOUNDATION_FILE_MANAGER", .when(platforms: [.wasi])),
/// .define("PLATFORM_LACKS_FOUNDATION_PROCESS", .when(platforms: [.wasi, .tvOS, .iOS, .watchOS])),
/// .define(
///   "PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN",  // @exempt(from: marks)
///   .when(platforms: [.wasi])
/// ),
/// .define(
///   "PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM",
///   .when(platforms: [.windows, .wasi, .tvOS, .iOS, .android, .watchOS])
/// ),
/// .define(
///   "PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER",
///   .when(platforms: [.wasi])
/// ),
/// ```
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

    // @documentation(SDGSwiftDocumentation)
    /// Utilities for working with Swift documentation.
    ///
    /// This module is built on DocC and provides utilities such as API parsing.
    .library(name: "SDGSwiftDocumentation", targets: ["SDGSwiftDocumentation"]),

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
    ///
    /// (`SampleConfiguration` is not intended as a real product. It is does not factor into the SDGSwift’s semantic version and should not be used as a real dependency.)
    .library(name: "SampleConfiguration", targets: ["SampleConfiguration"]),
  ],
  dependencies: [
    .package(
      url: "https://github.com/SDGGiesbrecht/SDGCornerstone",
      from: Version(10, 1, 2)
    ),
    .package(
      url: "https://github.com/apple/swift\u{2D}collections",
      from: Version(1, 0, 1)
    ),
    .package(
      url: "https://github.com/SDGGiesbrecht/swift\u{2D}package\u{2D}manager",
      exact: Version(0, 50800, 0)
    ),
    .package(
      url: "https://github.com/apple/swift\u{2D}tools\u{2D}support\u{2D}core",
      exact: Version(0, 5, 2)
    ),
    .package(
      url: "https://github.com/SDGGiesbrecht/swift\u{2D}syntax",
      exact: Version(0, 50800, 0)
    ),
    .package(
      url: "https://github.com/SDGGiesbrecht/swift\u{2D}docc\u{2D}symbolkit",
      exact: Version(0, 50800, 0)
    ),
    .package(
      url: "https://github.com/SDGGiesbrecht/swift\u{2D}markdown",
      exact: Version(0, 50800, 0)
    ),
    // #workaround(Possibly dead after markdown refactor?)
    .package(
      url: "https://github.com/SDGGiesbrecht/swift\u{2D}cmark",
      exact: Version(0, 50800, 0)
    ),
    .package(
      url: "https://github.com/SDGGiesbrecht/SDGWeb",
      from: Version(6, 1, 0)
    ),
  ],
  targets: [

    // Products

    // #documentation(SDGSwift)
    /// A basic interface for the Swift compiler.
    ///
    /// This module includes development‐time tasks such as building and testing. It uses the command‐line interface and provides the command line output in real time.
    .target(
      name: "SDGSwift",
      dependencies: [
        "SDGSwiftLocalizations",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGCollections", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGExternalProcess", package: "SDGCornerstone"),
        .product(name: "SDGVersioning", package: "SDGCornerstone"),
      ]
    ),

    // #documentation(SDGSwiftPackageManager)
    /// Utilities for working with the Swift package manager.
    ///
    /// This module uses the Swift API and provides more fine‐grained access to the details of a package’s structure than is available from the command line.
    .target(
      name: "SDGSwiftPackageManager",
      dependencies: [
        "SDGSwift",
        "SDGSwiftLocalizations",
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGCollections", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGVersioning", package: "SDGCornerstone"),
        .product(name: "SwiftPMDataModel\u{2D}auto", package: "swift\u{2D}package\u{2D}manager"),
        .product(name: "SwiftToolsSupport\u{2D}auto", package: "swift\u{2D}tools\u{2D}support\u{2D}core"),
      ]
    ),

    // #documentation(SDGSwiftSource)
    /// Utilities for working with Swift source code.
    ///
    /// This module is built on SwiftSyntax and provides utilities such as syntax colouring and API parsing.
    .target(
      name: "SDGSwiftSource",
      dependencies: [
        "SDGSwift",
        "SDGSwiftPackageManager",
        "SDGSwiftLocalizations",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGCollections", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGPersistence", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SwiftSyntax", package: "swift\u{2D}syntax"),
        .product(name: "SwiftSyntaxParser", package: "swift\u{2D}syntax"),
        .product(name: "cmark\u{2D}gfm", package: "swift\u{2D}cmark"),
        .product(name: "SwiftPMDataModel\u{2D}auto", package: "swift\u{2D}package\u{2D}manager"),
        .product(name: "SDGHTML", package: "SDGWeb"),
      ],
      resources: [
        .copy("Syntax Highlighting.css")
      ]
    ),
    // #workaround(Until complete.)
    .target(
      name: "SDGSwiftSource2",
      dependencies: [
        "SDGSwift",
        "SDGSwiftLocalizations",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGCollections", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SwiftSyntax", package: "swift\u{2D}syntax"),
        .product(name: "SwiftSyntaxParser", package: "swift\u{2D}syntax"),
        .product(name: "Markdown", package: "swift\u{2D}markdown"),
      ]
    ),

    // #documentation(SDGSwiftDocumentation)
    /// Utilities for working with Swift documentation.
    ///
    /// This module is built on DocC and provides utilities such as API parsing.
    .target(
      name: "SDGSwiftDocumentation",
      dependencies: [
        "SDGSwift",
        "SDGSwiftPackageManager",
        "SDGSwiftSource",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGCollections", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "OrderedCollections", package: "swift\u{2D}collections"),
        .product(name: "SymbolKit", package: "swift\u{2D}docc\u{2D}symbolkit"),
        .product(name: "SwiftPMDataModel\u{2D}auto", package: "swift\u{2D}package\u{2D}manager"),
        .product(name: "SwiftSyntax", package: "swift\u{2D}syntax"),
        .product(name: "SwiftSyntaxParser", package: "swift\u{2D}syntax"),
      ]
    ),

    // #documentation(SDGXcode)
    /// Xcode‐related utilities for working with Swift packages.
    .target(
      name: "SDGXcode",
      dependencies: [
        "SDGSwift",
        "SDGSwiftLocalizations",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGCollections", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGExternalProcess", package: "SDGCornerstone"),
        .product(name: "SDGVersioning", package: "SDGCornerstone"),
      ]
    ),

    // #documentation(SDGSwiftConfiguration)
    /// Utilities for defining configuration files written in Swift (similar to package manifests).
    .target(name: "SDGSwiftConfiguration"),

    // #documentation(SDGSwiftConfigurationLoading)
    /// Utilities for loading configuration files written in Swift (similar to package manifests).
    .target(
      name: "SDGSwiftConfigurationLoading",
      dependencies: [
        "SDGSwiftLocalizations",
        "SDGSwiftConfiguration",
        "SDGSwift",
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGCollections", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGVersioning", package: "SDGCornerstone"),
      ],
      resources: [
        .copy("Package.swift.txt")
      ]
    ),

    // Samples

    // #documentation(SampleConfiguration)
    /// A sample configuration demonstrating the use of `SDGSwiftConfiguration` and `SDGSwiftConfigurationLoading`.
    ///
    /// (`SampleConfiguration` is not intended as a real product. It is does not factor into the SDGSwift’s semantic version and should not be used as a real dependency.)
    .target(name: "SampleConfiguration", dependencies: ["SDGSwiftConfiguration"]),

    // Internal

    .target(
      name: "SDGSwiftLocalizations",
      dependencies: [
        .product(name: "SDGLocalization", package: "SDGCornerstone")
      ]
    ),

    // Tests
    .target(
      name: "SDGSwiftTestUtilities",
      dependencies: [
        "SDGSwift",
        "SDGSwiftPackageManager",
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGPersistence", package: "SDGCornerstone"),
        .product(name: "SDGExternalProcess", package: "SDGCornerstone"),
        .product(name: "SDGVersioning", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
        .product(name: "SDGPersistenceTestUtilities", package: "SDGCornerstone"),
      ],
      path: "Tests/SDGSwiftTestUtilities"
    ),
    .testTarget(
      name: "SDGSwiftTests",
      dependencies: [
        "SDGSwiftLocalizations",
        "SDGSwift",
        "SDGSwiftTestUtilities",
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGCollections", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGVersioning", package: "SDGCornerstone"),
        .product(name: "SDGLogicTestUtilities", package: "SDGCornerstone"),
        .product(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
      ]
    ),
    .testTarget(
      name: "SDGSwiftPackageManagerTests",
      dependencies: [
        "SDGSwift",
        "SDGSwiftPackageManager",
        "SDGSwiftLocalizations",
        "SDGSwiftTestUtilities",
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGPersistence", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone"),
        .product(name: "SDGPersistenceTestUtilities", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
      ]
    ),
    .testTarget(
      name: "SDGSwiftSourceTests",
      dependencies: [
        "SDGSwift",
        "SDGSwiftLocalizations",
        "SDGSwiftSource",
        "SDGSwiftTestUtilities",
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGCollections", package: "SDGCornerstone"),
        .product(name: "SDGLogicTestUtilities", package: "SDGCornerstone"),
        .product(name: "SDGPersistenceTestUtilities", package: "SDGCornerstone"),
        .product(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
        .product(name: "SwiftSyntax", package: "swift\u{2D}syntax"),
        .product(name: "SwiftSyntaxParser", package: "swift\u{2D}syntax"),
      ]
    ),
    .testTarget(
      name: "SDGSwiftSource2Tests",
      dependencies: [
        "SDGSwiftSource2",
        "SDGSwiftLocalizations",
        "SDGSwiftTestUtilities",
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGCollections", package: "SDGCornerstone"),
        .product(name: "SDGPersistence", package: "SDGCornerstone"),
        .product(name: "SDGPersistenceTestUtilities", package: "SDGCornerstone"),
        .product(name: "SwiftSyntax", package: "swift\u{2D}syntax"),
        .product(name: "SwiftSyntaxParser", package: "swift\u{2D}syntax"),
      ]
    ),
    .testTarget(
      name: "SDGSwiftDocumentationTests",
      dependencies: [
        "SDGSwift",
        "SDGSwiftSource",
        "SDGSwiftDocumentation",
        "SDGSwiftLocalizations",
        "SDGSwiftTestUtilities",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGMathematics", package: "SDGCornerstone"),
        .product(name: "SDGCollections", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGPersistenceTestUtilities", package: "SDGCornerstone"),
        .product(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
        .product(name: "SwiftSyntax", package: "swift\u{2D}syntax"),
        .product(name: "SwiftSyntaxParser", package: "swift\u{2D}syntax"),
        .product(name: "SwiftPMDataModel\u{2D}auto", package: "swift\u{2D}package\u{2D}manager"),
        .product(name: "SymbolKit", package: "swift\u{2D}docc\u{2D}symbolkit"),
      ]
    ),
    .testTarget(
      name: "SDGXcodeTests",
      dependencies: [
        "SDGXcode",
        "SDGSwift",
        "SDGSwiftLocalizations",
        "SDGSwiftTestUtilities",
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGCollections", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGPersistence", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGVersioning", package: "SDGCornerstone"),
        .product(name: "SDGPersistenceTestUtilities", package: "SDGCornerstone"),
        .product(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
      ]
    ),
    .testTarget(
      name: "SDGSwiftConfigurationTests",
      dependencies: [
        "SDGSwift",
        "SDGSwiftConfiguration",
        "SDGSwiftConfigurationLoading",
        "SDGSwiftTestUtilities",
        "SampleConfiguration",
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGCollections", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGVersioning", package: "SDGCornerstone"),
        .product(name: "SDGPersistenceTestUtilities", package: "SDGCornerstone"),
        .product(name: "SDGLocalizationTestUtilities", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
      ]
    ),
    .testTarget(
      name: "SDGSwiftDocumentationExampleTests",
      dependencies: [
        "SDGSwift",
        "SDGSwiftTestUtilities",
        .product(name: "SDGVersioning", package: "SDGCornerstone"),
        .product(name: "SDGXCTestUtilities", package: "SDGCornerstone"),
      ]
    ),
  ]
)

for target in package.targets {
  var swiftSettings = target.swiftSettings ?? []
  defer { target.swiftSettings = swiftSettings }
  swiftSettings.append(contentsOf: [
    // #workaround(Swift 5.8.0, Web lacks Foundation.FileManager.)
    // #workaround(Swift 5.8.0, Web lacks Foundation.Process.)
    // #workaround(Swift 5.8.0, SwiftPM does not compile on Windows.)
    // @example(conditions)
    .define("PLATFORM_LACKS_FOUNDATION_FILE_MANAGER", .when(platforms: [.wasi])),
    .define("PLATFORM_LACKS_FOUNDATION_PROCESS", .when(platforms: [.wasi, .tvOS, .iOS, .watchOS])),
    .define(
      "PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN",  // @exempt(from: marks)
      .when(platforms: [.wasi])
    ),
    .define(
      "PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM",
      .when(platforms: [.windows, .wasi, .tvOS, .iOS, .android, .watchOS])
    ),
    .define(
      "PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER",
      .when(platforms: [.wasi])
    ),
    // @endExample

    // Internal‐only:
    .define("PLATFORM_HAS_XCODE", .when(platforms: [.macOS])),
    .define("PLATFORM_LACKS_GIT", .when(platforms: [.wasi, .tvOS, .iOS, .android, .watchOS])),
  ])

  target.dependencies = target.dependencies.map { dependency in
    switch dependency {
    case .productItem(let name, let package, let moduleAliases, _):
      switch name {
      // #workaround(swift-markdown 0.50800.0, Does not compile for web.) @exempt(from: unicode)
      case "Markdown":
        return .productItem(
          name: name,
          package: package,
          moduleAliases: moduleAliases,
          condition: .when(platforms: [.macOS, .windows, .linux, .tvOS, .iOS, .android, .watchOS])
        )
      // #workaround(SwiftPM 0.50800.0, Does not compile for many platforms.)
      case "SwiftPMDataModel\u{2D}auto":
        return .productItem(
          name: name,
          package: package,
          moduleAliases: moduleAliases,
          condition: .when(platforms: [.macOS, .linux])
        )
      // #workaround(SwiftSyntax 0.50800.0, Does not compile for web.)
      case "SwiftSyntaxParser":
        return .productItem(
          name: name,
          package: package,
          moduleAliases: moduleAliases,
          condition: .when(platforms: [.macOS, .windows, .linux, .tvOS, .iOS, .android, .watchOS])
        )
      // #workaround(swift-tools-support-core 0.5.2, Does not compile for web or Android.) @exempt(from: unicode)
      case "SwiftToolsSupport\u{2D}auto":
        return .productItem(
          name: name,
          package: package,
          moduleAliases: moduleAliases,
          condition: .when(platforms: [.macOS, .windows, .linux, .tvOS, .iOS, .watchOS])
        )
      default:
        return dependency
      }
    default:
      return dependency
    }
  }
}

// #warning(Temporary to minimize diff.)
let oneIndex = package.targets.firstIndex(where: { $0.name == "SDGSwiftSource" })!
let one = package.targets.remove(at: oneIndex)
let twoIndex = package.targets.firstIndex(where: { $0.name == "SDGSwiftSource2" })!
let two = package.targets.remove(at: twoIndex)
package.targets.append(
  .target(
    name: one.name,
    dependencies: two.dependencies,
    path: "Sources/SDGSwiftSource2",
    resources: two.resources
  )
)
package.targets.append(
  .target(
    name: two.name,
    dependencies: one.dependencies,
    path: "Sources/SDGSwiftSource",
    resources: one.resources
  )
)

// #warning(Temporary to minimize diff.)
let testOneIndex = package.targets.firstIndex(where: { $0.name == "SDGSwiftSourceTests" })!
let testOne = package.targets.remove(at: testOneIndex)
let testTwoIndex = package.targets.firstIndex(where: { $0.name == "SDGSwiftSource2Tests" })!
let testTwo = package.targets.remove(at: testTwoIndex)
