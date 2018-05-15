// swift-tools-version:4.1

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
            dependencies: ["LibraryB"])
    ]
)
