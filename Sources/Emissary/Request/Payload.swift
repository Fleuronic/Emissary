// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public struct Payload<EncodingAPI: API> {
	let body: Data
	let headers: [Header<EncodingAPI>]
}

// MARK: -
extension Payload {
	init<Resource: Encodable>(resource: Resource) {
		body = try! EncodingAPI.encoder(in: .payload).encode(resource)
		headers = [.contentType(.application(.json))]
	}

	init(urlEncodedParameters: Parameters) {
		let queryString = urlEncodedParameters.queryString(sentUsing: EncodingAPI.self)

		body = .init(queryString.utf8)
		headers = [.contentType(.application(.url))]
	}
}
