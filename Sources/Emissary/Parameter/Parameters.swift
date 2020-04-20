// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public protocol Parameters: Encodable {}

// MARK: -
extension Parameters {
	func queryItems<EncodingAPI: API>(sentUsing apiType: EncodingAPI.Type) -> [URLQueryItem] {
		encodedObject(sentUsing: apiType)
			.flatMap(Array.init)
	}

	func queryString<EncodingAPI: API>(sentUsing apiType: EncodingAPI.Type) -> String {
		encodedObject(sentUsing: apiType)
			.flatMap(Array.init)
			.joined(separator: .ampersand)
	}

	func headers<EncodingAPI: API>(sentUsing apiType: EncodingAPI.Type) -> [Header<EncodingAPI>] {
		encodedObject(sentUsing: apiType)
			.map(Parameter.init)
			.map(Header.custom)
	}
}

// MARK: -
private extension Parameters {
	func encodedObject<EncodingAPI: API>(sentUsing apiType: EncodingAPI.Type) -> [String: Any] {
		let data = try! apiType.encoder(in: .parameters).encode(self)
		let object = try! JSONSerialization.jsonObject(with: data, options: [])
		return object as! [String: Any]
	}
}

// MARK: -
private extension String {
	static let ampersand = "&"
}
