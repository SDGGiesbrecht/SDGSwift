// swift-tools-version:5.3

/*
 Package.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import PackageDescription

// #example(1, readMe🇨🇦EN)
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
      from: Version(6, 0, 0)
    ),
    .package(
      name: "SwiftPM",
      url: "https://github.com/SDGGiesbrecht/swift\u{2D}package\u{2D}manager",
      // Remember to update the compatible compiler versions in SDGSwiftPackageManager too.
      .exact(Version(0, 50300, 0))
    ),
    .package(
      name: "SwiftSyntax",
      url: "https://github.com/apple/swift\u{2D}syntax",
      .exact(Version(0, 50300, 0))
    ),
    .package(
      name: "cmark",
      url: "https://github.com/SDGGiesbrecht/swift\u{2D}cmark",
      .exact(Version(0, 0, 50200))
    ),
    .package(
      url: "https://github.com/SDGGiesbrecht/SDGWeb",
      from: Version(5, 4, 1)
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
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGLocalization", package: "SDGCornerstone"),
        .product(name: "SDGVersioning", package: "SDGCornerstone"),
        .product(name: "SwiftPM\u{2D}auto", package: "SwiftPM"),
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
        .product(name: "SwiftSyntax", package: "SwiftSyntax"),
        .product(name: "cmark", package: "cmark"),
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

    .target(
      name: "refresh‐core‐libraries",
      dependencies: [
        "SDGSwiftPackageManager",
        "SDGSwiftSource",
        .product(name: "SDGControlFlow", package: "SDGCornerstone"),
        .product(name: "SDGLogic", package: "SDGCornerstone"),
        .product(name: "SDGCollections", package: "SDGCornerstone"),
        .product(name: "SDGText", package: "SDGCornerstone"),
        .product(name: "SDGPersistence", package: "SDGCornerstone"),
        .product(name: "SDGExternalProcess", package: "SDGCornerstone"),
        .product(name: "SwiftSyntax", package: "SwiftSyntax"),
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
      ],
      path: "Tests/SDGSwiftTestUtilities"
    ),
    .testTarget(
      name: "SDGSwiftTests",
      dependencies: [
        "SDGSwiftLocalizations",
        "SDGSwift",
        "SDGSwiftTestUtilities",
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
        .product(name: "SwiftSyntax", package: "SwiftSyntax"),
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

import Foundation
if ProcessInfo.processInfo.environment["TARGETING_MACOS"] == "true" {
  // #workaround(Swift 5.3, There is no way to set deployment targets on a per‐target basis.)
  package.targets.removeAll(where: { $0.name.hasPrefix("refresh‐") })
}

if ProcessInfo.processInfo.environment["TARGETING_WINDOWS"] == "true" {
  let impossibleDependencies = [
    // #workaround(SwiftSyntax 0.50200.0, Does not support Windows yet.)
    "SwiftSyntax",
  ]
  for target in package.targets {
    target.dependencies.removeAll(where: { dependency in
      return impossibleDependencies.contains(where: { impossible in
        return "\(dependency)".contains(impossible)
      })
    })
  }
}

if ProcessInfo.processInfo.environment["TARGETING_WEB"] == "true" {
  let impossibleDependencies = [
    // #workaround(Swift 5.2.4, Cannot build for web.)
    "cmark",
    "SwiftPM",
    "SwiftSyntax",
  ]
  package.dependencies.removeAll(where: { dependency in
    return impossibleDependencies.contains(where: { impossible in
      return (dependency.name ?? dependency.url).contains(impossible)
    })
  })
  for target in package.targets {
    target.dependencies.removeAll(where: { dependency in
      return impossibleDependencies.contains(where: { impossible in
        return "\(dependency)".contains(impossible)
      })
    })
  }
  for target in package.targets {
    // #workaround(Swift 5.2.4, Web doesn’t have Foundation yet.)
    target.exclude.append("Resources.swift")
  }
}

if ProcessInfo.processInfo.environment["TARGETING_ANDROID"] == "true" {
  let impossibleDependencies = [
    // #workaround(Swift 5.2.4, Cannot build for Android.)
    "SwiftPM",
    "SwiftSyntax",
  ]
  for target in package.targets {
    target.dependencies.removeAll(where: { dependency in
      return impossibleDependencies.contains(where: { impossible in
        return "\(dependency)".contains(impossible)
      })
    })
  }
}

// Windows Tests (Generated automatically by Workspace.)
import Foundation
if ProcessInfo.processInfo.environment["TARGETING_WINDOWS"] == "true" {
  var tests: [Target] = []
  var other: [Target] = []
  for target in package.targets {
    if target.type == .test {
      tests.append(target)
    } else {
      other.append(target)
    }
  }
  package.targets = other
  package.targets.append(
    contentsOf: tests.map({ test in
      return .target(
        name: test.name,
        dependencies: test.dependencies,
        path: test.path ?? "Tests/\(test.name)",
        exclude: test.exclude,
        sources: test.sources,
        publicHeadersPath: test.publicHeadersPath,
        cSettings: test.cSettings,
        cxxSettings: test.cxxSettings,
        swiftSettings: test.swiftSettings,
        linkerSettings: test.linkerSettings
      )
    })
  )
  package.targets.append(
    .target(
      name: "WindowsTests",
      dependencies: tests.map({ Target.Dependency.target(name: $0.name) }),
      path: "Tests/WindowsTests"
    )
  )
}
// End Windows Tests
