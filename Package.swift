// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "release-crash",
    platforms: [.macOS(.v11)],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms.git", from: "1.2.0"),
        .package(url: "https://github.com/vapor/vapor.git", from: "4.96.0"),
    ],
    targets: [
        .executableTarget(name: "release-crash", dependencies: [
            .product(name: "Algorithms", package: "swift-algorithms"),
            .product(name: "Vapor", package: "vapor")
        ]),
    ]
)
