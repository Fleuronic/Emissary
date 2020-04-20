// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

extension URLRequest {
	struct HTTPHeader {
		let field: String
		let value: String
	}

	init<EncodingAPI>(
		method: Method,
		baseURL: URL,
		path: Path,
		pathEncodingStrategy: PathEncodingStrategy,
		queryItems: [URLQueryItem],
		headers: [Header<EncodingAPI>],
		body: Data?
	) {
		self.init(
			url: .init(
				baseURL: baseURL,
				path: path,
				pathEncodingStrategy: pathEncodingStrategy,
				queryItems: queryItems
			)
		)

		httpMethod = method.rawValue
		httpHeaders = headers.map(URLRequest.HTTPHeader.init)
		httpBody = body
	}
}

// MARK: -
private extension URLRequest {
	var httpHeaders: [HTTPHeader]? {
		get {
			allHTTPHeaderFields?.map(HTTPHeader.init)
		}
		set {
			newValue?.forEach { header in
				setValue(header.value, forHTTPHeaderField: header.field)
			}
		}
	}
}
