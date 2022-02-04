// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if os(Linux)
let package = Package(
	name: "Emissary",
	platforms: [
		.iOS(.v13),
		.macOS(.v10_15),
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
		.package(url: "https://github.com/Fleuronic/AsyncExtensions", from: "0.3.1"),
		.package(url: "https://github.com/cx-org/CombineX", from: "0.4.0"),
	],
	targets: [
		.target(
			name: "Emissary",
			dependencies: [
				"AnyCodable",
				"AsyncExtensions",
				"CombineX"
			]
		)
	]
)
#elseif swift(>=5.5)
let package = Package(
	name: "Emissary",
	platforms: [
		.iOS(.v13),
		.macOS(.v10_15),
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
		.package(url: "https://github.com/Fleuronic/AsyncExtensions", from: "0.1.0"),
	],
	targets: [
		.target(
			name: "Emissary",
			dependencies: [
				"AnyCodable",
				"AsyncExtensions"
			]
		),
		.testTarget(
			name: "EmissaryTests",
			dependencies: ["Emissary"]
		)
	]
)
#else
let package = Package(
	name: "Emissary",
	platforms: [
		.iOS(.v13),
		.macOS(.v10_15),
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
		.package(url: "https://github.com/Fleuronic/AsyncExtensions", from: "0.1.0")
	],
	targets: [
		.target(
			name: "Emissary",
			dependencies: [
				"AnyCodable",
				"AsyncExtensions"
			]
		)
	]
)
#endif
