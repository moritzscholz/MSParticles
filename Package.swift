// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
// swiftlint:disable trailing_comma
let package = Package(
    name: "MSParticles",
    platforms: [
        .macOS(.v11), .iOS(.v14), .tvOS(.v14)
    ],
    products: [
        .library(
            name: "MSParticles",
            targets: ["MSParticles"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MSParticles",
            dependencies: []),
    ]
)
