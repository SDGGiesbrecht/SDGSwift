// swift-tools-version:5.6

/*
 Package.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

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
/// .define("PLATFORM_LACKS_FOUNDATION_PROCESS_INFO", .when(platforms: [.wasi])),
/// .define(
///   "PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM",
///   .when(platforms: [.windows, .wasi, .tvOS, .iOS, .android, .watchOS])
/// ),
/// .define(
///   "PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX",
///   .when(platforms: [.windows, .wasi, .tvOS, .iOS, .android, .watchOS])
/// ),
/// ```
let package = Package(
  name: "SDGSwift",
  platforms: [
    // These must also be updated in Sources/SDGSwiftConfigurationLoading/Configuration.swift.
    .macOS(.v10_10)
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
    ///
    /// (`SampleConfiguration` is not intended as a real product. It is does not factor into the SDGSwift’s semantic version and should not be used as a real dependency.)
    .library(name: "SampleConfiguration", targets: ["SampleConfiguration"]),
  ],
  dependencies: [
    .package(
      url: "https://github.com/SDGGiesbrecht/SDGCornerstone",
      from: Version(9, 0, 0)
    ),
    .package(
      url: "https://github.com/SDGGiesbrecht/swift\u{2D}package\u{2D}manager",
      // Remember to update the compatible compiler versions in SDGSwiftPackageManager too.
      exact: Version(0, 50600, 3)
    ),
    .package(
      url: "https://github.com/SDGGiesbrecht/swift\u{2D}tools\u{2D}support\u{2D}core",
      .upToNextMinor(from: Version(0, 50600, 0))
    ),
    .package(
      url: "https://github.com/apple/swift\u{2D}syntax",
      exact: Version(0, 50600, 1)
    ),
    .package(
      url: "https://github.com/SDGGiesbrecht/swift\u{2D}cmark",
      exact: Version(0, 50302, 0)
    ),
    .package(
      url: "https://github.com/SDGGiesbrecht/SDGWeb",
      from: Version(6, 0, 0)
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
        .product(name: "SDGCollections", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGVersioning", package: "SDGCornerstone"),
        .product(
          name: "SwiftPMDataModel\u{2D}auto",
          package: "swift\u{2D}package\u{2D}manager",
          // #workaround(SwiftPM 0.50500.2, Does not support Windows yet.)
          condition: .when(platforms: [.macOS, .linux])
        ),
        .product(
          name: "SwiftToolsSupport\u{2D}auto",
          package: "swift\u{2D}tools\u{2D}support\u{2D}core",
          // #workaround(SwiftPM 0.50500.2, Does not support Windows yet.)
          condition: .when(platforms: [.macOS, .linux])
        ),
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
        .product(
          name: "SwiftSyntax",
          package: "swift\u{2D}syntax",
          // #workaround(SwiftSyntax 0.50500.0, Does not support Windows yet.)
          condition: .when(platforms: [.macOS, .linux])
        ),
        .product(
          name: "SwiftSyntaxParser",
          package: "swift\u{2D}syntax",
          // #workaround(SwiftSyntax 0.50500.0, Does not support Windows yet.)
          condition: .when(platforms: [.macOS, .linux])
        ),
        .product(name: "cmark", package: "swift\u{2D}cmark"),
        .product(name: "SDGHTML", package: "SDGWeb"),
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

    .testTarget(
      // #workaround(xcodebuild -version 13.3.1, Should be executable, but for interference with tvOS etc.) @exempt(from: unicode)
      name: "SDGCoreLibraryRefresherTests",
      dependencies: [
        "SDGSwiftPackageManager",
        "SDGSwiftSource",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGCollections", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGPersistence", package: "SDGCornerstone"),
        .product(name: "SDGExternalProcess", package: "SDGCornerstone"),
        .product(
          name: "SwiftSyntax",
          package: "swift\u{2D}syntax",
          // #workaround(SwiftSyntax 0.50500.0, Does not support Windows yet.)
          condition: .when(platforms: [.macOS, .linux])
        ),
      ],
      path: "Sources/SDGCoreLibraryRefresherTests"
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
        .product(
          name: "SwiftSyntax",
          package: "swift\u{2D}syntax",
          // #workaround(SwiftSyntax 0.50500.0, Does not support Windows yet.)
          condition: .when(platforms: [.macOS, .linux])
        ),
        .product(
          name: "SwiftSyntaxParser",
          package: "swift\u{2D}syntax",
          // #workaround(SwiftSyntax 0.50500.0, Does not support Windows yet.)
          condition: .when(platforms: [.macOS, .linux])
        ),
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
    // #workaround(Swift 5.5.2, Web lacks Foundation.FileManager.)
    // #workaround(Swift 5.5.2, Web lacks Foundation.Process.)
    // #workaround(Swift 5.5.2, Web lacks Foundation.ProcessInfo.)
    // #workaround(Swift 5.5.2, SwiftPM does not compile on Windows.)
    // #workaround(Swift 5.5.2, SwiftSyntax does not compile on Windows.)
    // @example(conditions)
    .define("PLATFORM_LACKS_FOUNDATION_FILE_MANAGER", .when(platforms: [.wasi])),
    .define("PLATFORM_LACKS_FOUNDATION_PROCESS", .when(platforms: [.wasi, .tvOS, .iOS, .watchOS])),
    .define("PLATFORM_LACKS_FOUNDATION_PROCESS_INFO", .when(platforms: [.wasi])),
    .define(
      "PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM",
      .when(platforms: [.windows, .wasi, .tvOS, .iOS, .android, .watchOS])
    ),
    .define(
      "PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX",
      .when(platforms: [.windows, .wasi, .tvOS, .iOS, .android, .watchOS])
    ),
    // @endExample

    // Internal‐only:
    .define("PLATFORM_HAS_XCODE", .when(platforms: [.macOS])),
    // #workaround(Swift 5.5.2, Web lacks Foundation.URL.init(fileURLWithPath:).)
    .define("PLATFORM_LACKS_FOUNDATION_URL_INIT_FILE_URL_WITH_PATH", .when(platforms: [.wasi])),
    .define("PLATFORM_LACKS_GIT", .when(platforms: [.wasi, .tvOS, .iOS, .android, .watchOS])),
    // #workaround(SDGCornerstone 8.0.1, Windows suffers unexplained segmentation faults.)
    .define("PLATFORM_SUFFERS_SEGMENTATION_FAULTS", .when(platforms: [.windows])),
  ])
}

import Foundation

var impossibleDependencyPackages: [String] = []
var impossibleDependencyProducts: [String] = []

// #workaround(Swift 5.6, Conditional dependencies fail to skip for Windows and Android.)
if ["WINDOWS", "ANDROID"]
  .contains(where: { ProcessInfo.processInfo.environment["TARGETING_\($0)"] == "true" })
{
  impossibleDependencyProducts.append("SwiftSyntaxParser")
}

// #workaround(Swift 5.6, Web toolchain rejects manifest due to dynamic library.)
if ProcessInfo.processInfo.environment["TARGETING_WEB"] == "true" {
  impossibleDependencyPackages.append(contentsOf: [
    "swift\u{2D}package\u{2D}manager",
    "swift\u{2D}tools\u{2D}support\u{2D}core",
  ])
}

// #workaround(xcodebuild -version 13.3.1, Xcode goes hunting for unused binary.) @exempt(from: unicode)
if ["TVOS", "IOS", "WATCHOS"]
  .contains(where: { ProcessInfo.processInfo.environment["TARGETING_\($0)"] == "true" })
{
  impossibleDependencyProducts.append("SwiftSyntaxParser")
}

package.dependencies.removeAll(where: { dependency in
  return impossibleDependencyPackages.contains(where: { impossible in
    switch dependency.kind {
    case .sourceControl(name: _, let location, requirement: _):
      return (location).contains(impossible)
    default:
      return false
    }
  })
})
for target in package.targets {
  target.dependencies.removeAll(where: { dependency in
    switch dependency {
    case .productItem(let name, let package, condition: _):
      if let package = package,
        impossibleDependencyPackages.contains(package)
      {
        return true
      } else {
        return impossibleDependencyProducts.contains(name)
      }
    default:
      return false
    }
  })
}
