// Copyright © Fleuronic LLC. All rights reserved.

public protocol PathAccessible: SubpathRepresentable {}

// MARK: -
public extension PathAccessible {
	var pathToResource: Path {
		.init(components: subpathToResource.components)
	}

	static var path: Path {
		.init(components: subpath.components)
	}

	func pathToResource(to pathComponent: PathComponents) -> Path {
		let subPath = subpathToResource(to: pathComponent)
		return .init(components: subPath.components)
	}

	static func path(to pathComponent: PathComponents) -> Path {
		let subpath = subpath(to: pathComponent)
		return .init(components: subpath.components)
	}

	static func path(to pathComponents: PathComponents...) -> Path {
		.init(components: pathComponents)
	}

	static func path<Value: PathComponent>(to value: Value, to pathComponents: PathComponents...) -> Path {
		let subpath = self.subpath(to: value, to: pathComponents)
		return .init(components: subpath.components)
	}
}
