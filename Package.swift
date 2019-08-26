// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CGCircularProgressView",
    platforms: [
        .iOS(.v8),
        .tvOS(.v9)
    ],
    products: [
        .library(
            name: "CGCircularProgressView",
            targets: ["CGCircularProgressView"]),
    ],
    targets: [
        .target(
            name: "CGCircularProgressView",
            path: ".",
            sources: ["Sources"])
    ],
    swiftLanguageVersions: [.v5]
)
