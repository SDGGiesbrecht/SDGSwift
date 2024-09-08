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
  name: "DynamicallyLinkedTool",
  products: [
    .executable(name: "tool", targets: ["tool"])
  ],
  dependencies: [
    .package(url: "/tmp/DynamicLibraryB", .branch("master"))
  ],
  targets: [
    .target(
      name: "tool",
      dependencies: ["LibraryB"]
    )
  ]
)
