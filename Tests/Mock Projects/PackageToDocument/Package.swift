// swift-tools-version:4.2

/*
 Package.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import PackageDescription

/// Package documentation.
let package = Package(
  name: "PackageToDocument",
  products: [
    /// Library documentation.
    .library(name: "PrimaryProduct", targets: ["PrimaryModule"]),

    .executable(name: "executable", targets: ["executable"]),

    .library(name: "_Hidden", targets: ["Hidden"]),
  ],
  dependencies: [
    .package(path: "../Dependency"),
    .package(path: "../Dependency2"),
  ],
  targets: [
    .target(name: "executable"),

    /// Module documentation.
    .target(name: "PrimaryModule", dependencies: ["Dependency", "Dependency2", "Hidden"]),

    .target(name: "Hidden"),
  ]
)
