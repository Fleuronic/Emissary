// Copyright © Fleuronic LLC. All rights reserved.

public struct Subpath {
	let components: [PathComponent]
}

// MARK: -
extension Subpath: SubpathAppendable {
	// MARK: SubpathAppendable
	public func appending(_ subpath: Subpath) -> Subpath {
		.init(components: components + subpath.components)
	}
}
