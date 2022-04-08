// swift-tools-version:5.3

import PackageDescription

var dependencies: [Package.Dependency] = [
	.package(url: "https://github.com/Flight-School/AnyCodable", from: "0.6.0"),
	.package(url: "https://github.com/ReactiveCocoa/ReactiveSwift.git", from: "6.1.0"),
	.package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.5.0"),
	.package(url: "https://github.com/Fleuronic/RxCombine.git", .branch("linux"))
]
var mainTargetDependencies: [Target.Dependency] = ["AnyCodable"]

#if os(Linux)
dependencies.append(.package(url: "https://github.com/cx-org/CombineX", from: "0.4.0"))
mainTargetDependencies.append("CombineX")
#endif

var targets: [Target] = [
	.target(
		name: "Emissary",
		dependencies: mainTargetDependencies
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

#if swift(>=5.4)
targets.append(.testTarget(name: "EmissaryTests", dependencies: ["Emissary"]))
#endif

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
	dependencies: dependencies,
	targets: targets
)
