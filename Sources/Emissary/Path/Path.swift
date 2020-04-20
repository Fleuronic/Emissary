// Copyright © Fleuronic LLC. All rights reserved.

public struct Path {
	let components: [PathComponent]
}

// MARK: -
extension Path {
	func stringValue(using encodingStrategy: PathEncodingStrategy) -> String {
		components
			.map(\.rawValue)
			.map(encodingStrategy.encode)
			.joined(separator: .slash)
	}
}

// MARK: -
extension Path: SubpathAppendable {
	// MARK: SubpathAppendable
	public func appending(_ subpath: Subpath) -> Self {
		.init(components: components + subpath.components)
	}
}

// MARK: -
private extension String {
	static let slash = "/"
}
