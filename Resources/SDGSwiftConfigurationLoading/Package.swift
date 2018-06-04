// swift-tools-version:4.0

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
        // [_Warning: Pointing at branch._]
        .package(url: "[*URL*]", .branch("[*branch*]"))
    ],
    targets: [
        .target(name: "configure", dependencies: [
            "[*module*]"
            ]),
        ]
)
