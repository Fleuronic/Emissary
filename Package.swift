// swift-tools-version:5.5
import PackageDescription

let package = Package(
	name: "Emissary",
	platforms: [
		.iOS(.v15)
	],
	products: [
		.library(
			name: "Emissary",
			targets: ["Emissary"]
		)
	],
	dependencies: [],
	targets: [
		.target(
			name: "Emissary",
			dependencies: []
		),
		.testTarget(
			name: "EmissaryTests",
			dependencies: ["Emissary"]
		)
	]
)
