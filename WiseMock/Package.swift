// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WiseMock",
    platforms: [
          .macOS(.v10_10), .iOS(.v9), .tvOS(.v9)
        ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "WiseMock",
            targets: ["WiseMock"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMinor(from: "9.2.1")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "WiseMock",
            dependencies: [
                .product(name: "Nimble", package: "Nimble",
                                         condition: .when(platforms: [.macOS, .iOS])),
            ]),
        .testTarget(
            name: "WiseMockTests",
            dependencies: ["WiseMock"]),
    ]
)
