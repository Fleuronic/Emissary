// Copyright © Fleuronic LLC. All rights reserved.

public protocol SubpathRepresentable {
	associatedtype PathComponents: PathComponent

	var idComponent: PathComponent? { get }

	static var component: PathComponents { get }
}

// MARK: -
public extension SubpathRepresentable {
	var idComponent: PathComponent? {
		nil
	}

	var subpathToResource: Subpath {
		let components = [Self.component, idComponent].compactMap { $0 }
		return .init(components: components)
	}

	static var subpath: Subpath {
		.init(components: [component])
	}

	func subpathToResource(to pathComponent: PathComponents) -> Subpath {
		.init(components: subpathToResource.components + [pathComponent])
	}

	static func subpath(to pathComponent: PathComponents) -> Subpath {
		let components = [component, pathComponent]
		return .init(components: components)
	}

	static func subpath(to pathComponents: PathComponents...) -> Subpath {
		.init(components: pathComponents)
	}

	static func subpath<Value: PathComponent>(to value: Value, to pathComponents: PathComponents...) -> Subpath {
		subpath(to: value, to: pathComponents)
	}

	static func subpath<Value: PathComponent>(to value: Value, to pathComponents: [PathComponents]) -> Subpath {
		let components: [PathComponent] = [component, value.rawValue] + pathComponents
		return .init(components: components)
	}
}
