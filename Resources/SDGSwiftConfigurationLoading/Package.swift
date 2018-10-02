// swift-tools-version:4.2

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

let package = Package(
    name: "configure",
    dependencies: [
        .package(url: "[*URL*]", .exact("[*version*]")),
[*packages*]
    ],
    targets: [
        .target(name: "configure", dependencies: [
            "[*product*]",
[*products*]
            ])
        ]
)
