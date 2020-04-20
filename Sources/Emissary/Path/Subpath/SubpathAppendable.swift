// Copyright © Fleuronic LLC. All rights reserved.

public protocol SubpathAppendable {
	func appending(_ subpath: Subpath) -> Self
}

// MARK: -
public extension SubpathAppendable {
	func appending(_ pathComponent: PathComponent) -> Self {
		let subpath = Subpath(components: [pathComponent])
		return appending(subpath)
	}

	func appending(_ pathComponent: PathComponent?) -> Self {
		pathComponent.map(appending) ?? self
	}

	func appending(_ subpath: Subpath?) -> Self {
		subpath.map(appending) ?? self
	}
}
