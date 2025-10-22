// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DragonQuest",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "DragonQuest",
            targets: ["DragonQuest"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DragonQuest",
            dependencies: [],
            path: "DragonQuest"
        )
    ]
)

