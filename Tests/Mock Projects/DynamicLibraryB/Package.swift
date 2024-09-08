// swift-tools-version:4.1

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

let package = Package(
  name: "DynamicLibraryB",
  products: [
    .library(name: "LibraryB", type: .dynamic, targets: ["LibraryB"])
  ],
  dependencies: [
    .package(url: "/tmp/DynamicLibraryA", .branch("master"))
  ],
  targets: [
    .target(
      name: "LibraryB",
      dependencies: ["LibraryA"]
    )
  ]
)
