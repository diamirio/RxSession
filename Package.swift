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
        .package(url: "https://github.com/tailoredmedia/Endpoints.git", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0")),
    ],
    targets: [
        .target(
            name: "RxSession",
            dependencies: [
                "Endpoints",
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxCocoa", package: "RxSwift"),
            ],
            path: "RxSession"
        ),
        .testTarget(
            name: "RxSessionTests",
            dependencies: ["RxSession"],
            path: "RxSessionTests"
        ),
    ]
)
