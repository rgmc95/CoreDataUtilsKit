// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "CoreDataUtilsKit",
	platforms: [.iOS("13.0"), .macOS("13.0")],
	products: [
		.library(name: "CoreDataUtilsKit", targets: ["CoreDataUtilsKit"])
	],
	dependencies: [
		.package(url: "https://github.com/rgmc95/UtilsKit.git", from: "3.0.0"),
	],
	targets: [
		.target(
			name: "CoreDataUtilsKit",
			dependencies: ["UtilsKitCore"])
	]
)
