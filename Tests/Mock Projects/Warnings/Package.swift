// swift-tools-version:5.0

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
  name: "Warnings",
  products: [
    .library(
      name: "Warnings",
      targets: ["Warnings"]
    )
  ],
  targets: [
    .target(
      name: "Warnings",
      dependencies: []
    )
  ]
)
