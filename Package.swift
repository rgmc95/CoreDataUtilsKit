// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreDataUtilsKit",
    platforms: [.iOS("10.0")],
    products: [
        .library(
            name: "CoreDataUtilsKit",
            targets: ["CoreDataUtilsKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/rgmc95/UtilsKit.git", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "CoreDataUtilsKit",
            dependencies: ["UtilsKit"],
            path: "./CoreDataUtilsKit"),
    ]
)
