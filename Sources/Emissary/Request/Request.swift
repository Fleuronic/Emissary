// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public struct Request<Response: APIResponse, DecodingAPI: API> {
	let urlRequest: URLRequest
	let fixturesURL: URL?
}

// MARK: -
public extension Request {
	typealias Resource = Response.Data
	typealias NetworkError = Emissary.NetworkError<DecodingAPI.Error>
}
