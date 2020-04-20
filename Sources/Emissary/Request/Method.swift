// Copyright © Fleuronic LLC. All rights reserved.

enum Method: String {
	case get = "GET"
	case post = "POST"
	case put = "PUT"
	case delete = "DELETE"
}

// MARK: -
extension Method: CustomStringConvertible {
	// MARK: CustomStringConvertible
	public var description: String { rawValue }
}
