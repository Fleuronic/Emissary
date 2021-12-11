// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Emissary",
	platforms: [
		.iOS(.v13),
		.macOS(.v11),
		.watchOS(.v6),
		.tvOS(.v13)
	],
	products: [
		.library(
			name: "Emissary",
			targets: ["Emissary"]
		)
	],
	dependencies: [
		.package(url: "https://github.com/Flight-School/AnyCodable", from: "0.6.0"),
		.package(url: "https://github.com/Fleuronic/AsyncOptional", from: "0.1.0")
	],
	targets: [
		.target(
			name: "Emissary",
			dependencies: [
				"AnyCodable",
				"AsyncOptional"
			]
		),
		.testTarget(
			name: "EmissaryTests",
			dependencies: ["Emissary"]
		)
	]
)
