// swift-tools-version:4.1

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
            dependencies: ["LibraryA"])
    ]
)
