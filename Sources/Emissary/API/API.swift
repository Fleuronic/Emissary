// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public protocol API {
	associatedtype Error: APIError
	associatedtype HeaderParameters: Parameters

	var baseURL: URL { get }
	var authorizationType: AuthorizationType? { get }
	var customHeaderParameters: HeaderParameters { get }
	var prefersHeaderParameters: Bool { get }
	var acceptType: MediaType? { get }

	static var dateFormat: String? { get }
	static var codingStrategy: CodingStrategy { get }
}

// MARK: -
public extension API {
	typealias Request<Response: APIResponse> = Emissary.Request<Response, Self>

	var authorizationType: AuthorizationType? { nil }
	var customHeaderParameters: DefaultParameters { .init() }
	var prefersHeaderParameters: Bool { false }
	var acceptType: MediaType? { nil }

	static var dateFormat: String? { nil }
	static var codingStrategy: CodingStrategy { .init() }

	static var decoder: JSONDecoder {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = codingStrategy.keyDecodingStrategy
		decoder.dateDecodingStrategy = codingStrategy.dateDecodingStrategy(using: dateFormatter)
		return decoder
	}

	static func encoder(in context: CodingStrategy.EncodingContext) -> JSONEncoder {
		let encoder = JSONEncoder()
		encoder.keyEncodingStrategy = codingStrategy.keyEncodingStrategy(in: context)
		encoder.dateEncodingStrategy = codingStrategy.dateEncodingStrategy(using: dateFormatter)
		return encoder
	}
}

// MARK: -
extension API {
	func request<Resource, ResourceParameters: Parameters>(
		method: Method,
		path: Path,
		queryParameters: ResourceParameters,
		payload: Payload<Self>? = nil
	) -> Request<Resource> {
		request(
			method: method,
			path: path,
			queryItems: queryParameters.queryItems(sentUsing: Self.self),
			payload: payload
		)
	}

	func request<Resource, ResourceParameters: Parameters>(
		method: Method,
		path: Path,
		headerParameters: ResourceParameters,
		payload: Payload<Self>? = nil
	) -> Request<Resource> {
		request(
			method: method,
			path: path,
			headers: headerParameters.headers(sentUsing: Self.self),
			payload: payload
		)
	}

	func request<Resource>(
		method: Method,
		path: Path,
		queryItems: [URLQueryItem] = [],
		headers: [Header<Self>] = [],
		payload: Payload<Self>? = nil
	) -> Request<Resource> {
		let customHeaders: [Header<Self>] = customHeaderParameters.headers(sentUsing: Self.self)
		let payloadHeaders = payload?.headers ?? []
		let fixturesURL = (self as? FixtureAPI)?.fixturesURL

		return .init(
			urlRequest: .init(
				method: method,
				baseURL: baseURL,
				path: path,
				pathEncodingStrategy: Self.codingStrategy.pathEncodingStrategy,
				queryItems: queryItems,
				headers: headers + baseHeaders + customHeaders + payloadHeaders,
				body: payload?.body
			),
			fixturesURL: fixturesURL
		)
	}
}

// MARK: -
private extension API {
	var baseHeaders: [Header<Self>] {
		[
			acceptType.map(Header.accept),
			authorizationType.map(Header.authorization)
		].compactMap { $0 }
	}

	static var dateFormatter: DateFormatter? {
		dateFormat.map(DateFormatter.init)
	}
}
