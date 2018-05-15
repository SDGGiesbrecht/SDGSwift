// swift-tools-version:4.1

import PackageDescription

let package = Package(
    name: "DynamicLibraryA",
    products: [
        .library(name: "LibraryA", type: .dynamic, targets: ["LibraryA"])
    ],
    targets: [
        .target(
            name: "LibraryA",
            dependencies: [])
    ]
)
