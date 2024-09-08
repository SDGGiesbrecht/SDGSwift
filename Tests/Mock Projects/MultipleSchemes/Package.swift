// swift-tools-version:5.1

/*
 Package.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import PackageDescription

let package = Package(
  name: "SomePackage",
  products: [
    .library(name: "SomeLibrary", targets: ["SomeLibrary"]),
    .library(name: "SomeOtherLibrary", targets: ["SomeOtherLibrary"]),
  ],
  targets: [
    .target(
      name: "SomeLibrary"
    ),
    .target(
      name: "SomeOtherLibrary"
    ),
    .target(
      name: "some‐tool"
    ),
    .testTarget(
      name: "SomeTests",
      dependencies: [
        "SomeLibrary"
      ]
    ),
  ]
)
