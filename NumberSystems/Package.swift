// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NumberSystems",
    products: [
        .library(
            name: "NumberSystems",
            targets: ["NumberSystems"]
        ),
    ],
    targets: [
        .target(
            name: "NumberSystems"
        ),
        .testTarget(
            name: "NumberSystemsTests",
            dependencies: ["NumberSystems"]
        ),
    ]
)
