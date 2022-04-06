// swift-tools-version:5.4
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
		.package(url: "https://github.com/cx-org/CombineX", from: "0.4.0"),
		.package(url: "https://github.com/ReactiveCocoa/ReactiveSwift.git", from: "6.1.0"),
		.package(url: "https://github.com/ReactiveX/RxSwift.git", .exact("6.5.0")),
		.package(url: "https://github.com/CombineCommunity/RxCombine.git", from: "2.0.0")
	],
	targets: [
		.target(
			name: "Emissary",
			dependencies: [
				"AnyCodable",
				"CombineX"
			]
		),
		.target(
			name: "Emissary-ReactiveSwift",
			dependencies: [
				"Emissary",
				"ReactiveSwift"
			]
		),
		.target(
			name: "Emissary-RxSwift",
			dependencies: [
				"Emissary",
				"RxSwift",
				"RxCombine"
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
		.package(url: "https://github.com/ReactiveCocoa/ReactiveSwift.git", from: "6.1.0"),
		.package(url: "https://github.com/ReactiveX/RxSwift.git", .exact("6.5.0")),
		.package(url: "https://github.com/CombineCommunity/RxCombine.git", from: "2.0.0")
	],
	targets: [
		.target(
			name: "Emissary",
			dependencies: [
				"AnyCodable"
			]
		),
		.target(
			name: "Emissary-ReactiveSwift",
			dependencies: [
				"Emissary",
				"ReactiveSwift"
			]
		),
		.target(
			name: "Emissary-RxSwift",
			dependencies: [
				"Emissary",
				"RxSwift",
				"RxCombine"
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
		.package(url: "https://github.com/ReactiveCocoa/ReactiveSwift.git", from: "6.1.0"),
		.package(url: "https://github.com/ReactiveX/RxSwift.git", .exact("6.5.0")),
		.package(url: "https://github.com/CombineCommunity/RxCombine.git", from: "2.0.0")
	],
	targets: [
		.target(
			name: "Emissary",
			dependencies: [
				"AnyCodable",
			]
		),
		.target(
			name: "Emissary-ReactiveSwift",
			dependencies: [
				"Emissary",
				"ReactiveSwift"
			]
		),
		.target(
			name: "Emissary-RxSwift",
			dependencies: [
				"Emissary",
				"RxSwift",
				"RxCombine"
			]
		)
	]
)
#endif
