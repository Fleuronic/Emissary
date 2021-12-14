// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public struct Request<Response: APIResponse, DecodingAPI: API> {
	let urlRequest: URLRequest
	let fixturesURL: URL?
}

// MARK: -
public extension Request {
	typealias Resource = Response.ResponseData
	typealias NetworkError = Emissary.NetworkError<DecodingAPI.Error>
}
