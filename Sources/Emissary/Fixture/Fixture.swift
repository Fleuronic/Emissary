// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
import AnyCodable

struct Fixture<API: Emissary.API> {
	let request: URLRequest
	let statusCode: StatusCode
	let responseName: String
}

// MARK: -
extension Fixture {
	func matches(request: URLRequest) throws -> Bool {
		let requestsEqual = self.request == request
		let bodiesEqual = self.request.httpBody?.count == request.httpBody?.count
		return requestsEqual && bodiesEqual
	}
}

// MARK: -
extension Fixture: Decodable {
	// MARK: Decodable
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let requestContainer = try container.nestedContainer(keyedBy: RequestCodingKeys.self, forKey: .request)
		let urlString = try requestContainer.decode(String.self, forKey: .urlString)
		let method = try requestContainer.decode(String.self, forKey: .method)
		let headers = try requestContainer.decodeIfPresent([String: AnyDecodable].self, forKey: .headers)
		let body = try requestContainer.decodeIfPresent(AnyCodable.self, forKey: .body)

		var request = URLRequest(
			url: try .init(
				fixtureURLString: urlString,
				decoder: decoder
			)
		)

		request.httpMethod = method
		request.httpBody = try body.map { try API.encoder(in: .payload).encode($0) }
		headers?.forEach { request.setValue(String(describing: $1), forHTTPHeaderField: $0) }

		self.request = request
		statusCode = try container.decode(StatusCode.self, forKey: .statusCode)
		responseName = try container.decode(String.self, forKey: .responseName)
	}
}

// MARK: -
private extension Fixture {
	enum CodingKeys: String, CodingKey {
		case request
		case statusCode
		case responseName = "response"
	}

	enum RequestCodingKeys: String, CodingKey {
		case method
		case urlString = "url"
		case headers
		case body
	}
}

// MARK: -
extension StatusCode: Decodable {}
