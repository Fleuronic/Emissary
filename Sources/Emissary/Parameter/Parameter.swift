// Copyright © Fleuronic LLC. All rights reserved.

struct Parameter {
	let name: String
	let value: String
}

// MARK: -
extension Parameter: KeyValueInitializable {
	init(key: String, value: Any) {
		let boolValue = value as? Bool
		let value = boolValue.map(String.init) ?? .init(describing: value)
		self.init(name: key, value: value)
	}
}
