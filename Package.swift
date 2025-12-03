// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "advent-of-code-2025",
    targets: [
        .executableTarget(
            name: "advent-of-code-2025",
            resources: [
                .process("Resources")
            ]
        ),
    ]
)
