// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension URLQueryItem: KeyValueInitializable {
	init(key: String, value: Any) {
		let value = String(describing: value)
		self.init(name: key, value: value)
	}
}
