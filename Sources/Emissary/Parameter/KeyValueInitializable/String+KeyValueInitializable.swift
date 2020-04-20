// Copyright © Fleuronic LLC. All rights reserved.

extension String: KeyValueInitializable {
	init(key: String, value: Any) {
		let valueString = String(describing: value)
		self = [key, valueString].joined(separator: .equalsSign)
	}
}

// MARK: -
private extension String {
	static let equalsSign = "="
}
