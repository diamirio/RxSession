// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "RxSession",
    products: [
        .library(
            name: "RxSession",
            targets: ["RxSession"]),
    ],
    dependencies: [
        .package(url: "git@github.com:tailoredmedia/Endpoints.git", .upToNextMajor(from: "0.5.0")),
        .package(url: "git@github.com:ReactiveX/RxSwift.git", .upToNextMajor(from: "5.0.0"))
    ],
    targets: [
        .target(
            name: "RxSession",
            dependencies: [],
            path: "RxSession"
        ),
        .testTarget(
            name: "RxSessionTests",
            dependencies: ["RxSession"],
            path: "RxSessionTests"
        ),
    ]
)
