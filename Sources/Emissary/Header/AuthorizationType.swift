// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public enum AuthorizationType {
	case basic(username: String, password: String)
	case bearer(accessToken: String)
}

// MARK: -
extension AuthorizationType: HeaderValue {
	// MARK: HeaderValue
	public var stringValue: String {
		let components = [name.rawValue.capitalized, credentialsString]
		return components.joined(separator: .space)
	}
}

// MARK: -
private extension AuthorizationType {
	enum Name: String {
		case basic
		case bearer
	}

	var name: Name {
		switch self {
		case .basic:
			return .basic
		case .bearer:
			return .bearer
		}
	}

	var credentialsString: String {
		switch self {
		case let .basic(username, password):
			let string = [username, password].joined(separator: .colon)
			let data = Data(string.utf8)
			return data.base64EncodedString()
		case let .bearer(accessToken):
			return accessToken
		}
	}
}

// MARK: -
private extension String {
	static let space = " "
	static let colon = ":"
}
