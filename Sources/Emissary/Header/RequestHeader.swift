// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

enum Header<EncodingAPI: API> {
	case authorization(AuthorizationType)
	case accept(MediaType)
	case contentType(MediaType)
	case contentLength(Int)
	case custom(Parameter)
}

// MARK: -
extension URLRequest.HTTPHeader {
	init<EncodingAPI>(header: Header<EncodingAPI>) {
		field = header.fieldName
		value = header.value.stringValue
	}
}

// MARK: -
private extension Header {
	enum StandardField: String {
		case authorization = "Authorization"
		case accept = "Accept"
		case contentType = "Content-Type"
		case contentLength = "Content-Length"
	}

	var fieldName: String {
		switch self {
		case .authorization:
			return name(of: .authorization)
		case .accept:
			return name(of: .accept)
		case .contentType:
			return name(of: .contentType)
		case .contentLength:
			return name(of: .contentLength)
		case let .custom(parameter):
			return parameter.name
		}
	}

	var value: HeaderValue {
		switch self {
		case let .authorization(accessToken):
			return accessToken
		case let .accept(value), let .contentType(value):
			return value
		case let .contentLength(value):
			return value
		case let .custom(parameter):
			return parameter.value
		}
	}

	func name(of standardField: StandardField) -> String {
		standardField.rawValue
	}
}
