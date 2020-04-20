// Copyright © Fleuronic LLC. All rights reserved.

extension Array: KeyValueInitializable where Element: KeyValueInitializable {
	init(key: String, value: Any) {
		if let array = value as? [Any] {
			let bracketedKey = key.appending(String.brackets)
			self = array.map { value in
				.init(key: bracketedKey, value: value)
			}
		} else {
			self = [.init(key: key, value: value)]
		}
	}
}

// MARK: -
private extension String {
	static let brackets = "[]"
}
