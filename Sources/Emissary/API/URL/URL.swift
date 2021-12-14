// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension URL {
	init(
		baseURL: URL,
		path: Path,
		pathEncodingStrategy: PathEncodingStrategy,
		queryItems: [URLQueryItem]
	) {
		let pathComponent = path.stringValue(using: pathEncodingStrategy)
		let url = baseURL.appendingPathComponent(pathComponent)

		var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
		if !queryItems.isEmpty {
			components.queryItems = queryItems
		}

		self = components.url!
	}
}

// MARK: -
extension URL: ExpressibleByStringLiteral {
	public init(stringLiteral value: StringLiteralType) {
		self.init(string: value)!
	}
}
