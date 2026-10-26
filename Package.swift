// swift-tools-version: 6.0

import PackageDescription

/// Годы, для которых есть решения. Новый год: добавить сюда и создать
/// `Sources/AoC<год>` и `Tests/AoC<год>Tests` (это делает `./new-day.sh`).
let years = [2022, 2023, 2024]

let libraries: [Target.Dependency] = [
    .product(name: "Collections", package: "swift-collections"),
    .product(name: "Algorithms", package: "swift-algorithms"),
]

let package = Package(
    name: "advent-of-code",
    platforms: [.macOS(.v14)],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections.git", from: "1.1.4"),
        .package(url: "https://github.com/apple/swift-algorithms.git", from: "1.2.0"),
    ],
    targets: [
        .target(name: "AoCKit", dependencies: libraries),
        .testTarget(name: "AoCKitTests", dependencies: ["AoCKit"]),
    ] + years.flatMap { year -> [Target] in
        [
            .target(name: "AoC\(year)", dependencies: ["AoCKit"] + libraries),
            .testTarget(name: "AoC\(year)Tests", dependencies: [.target(name: "AoC\(year)"), "AoCKit"]),
        ]
    }
)
