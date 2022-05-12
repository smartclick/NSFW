// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "NSFW",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .library(
            name: "NSFW",
            targets: ["NSFW"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "NSFW",
            dependencies: [],
            path: "Sources",
            resources: [.copy("NSFW/Resources/NSFWModel.mlmodel")])
    ],
    swiftLanguageVersions: [.v4_2]
)
