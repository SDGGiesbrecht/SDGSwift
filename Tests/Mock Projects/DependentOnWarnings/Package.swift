// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "DependentOnWarnings",
    products: [
        .library(
            name: "DependentOnWarnings",
            targets: ["DependentOnWarnings"]),
    ],
    dependencies: [
        .package(path: "../Warnings"),
    ],
    targets: [
        .target(
            name: "DependentOnWarnings",
            dependencies: ["Warnings"]),
    ]
)
