// Copyright © Fleuronic LLC. All rights reserved.

public extension API {
	func post<ReturnedResource: Decodable>(to path: Path) -> Request<ReturnedResource> {
		request(
			method: .post,
			path: path
		)
	}

	func post<RequestParameters: Parameters, ReturnedResource: Decodable>(to path: Path, specifying parameters: RequestParameters) -> Request<ReturnedResource> {
		if prefersHeaderParameters {
			return request(
				method: .post,
				path: path,
				headerParameters: parameters
			)
		}

		return request(
			method: .post,
			path: path,
			payload: .init(urlEncodedParameters: parameters)
		)
	}

	func post<Resource: Encodable, ReturnedResource: Decodable>(_ resource: Resource, to path: Path) -> Request<ReturnedResource> {
		request(
			method: .post,
			path: path,
			payload: .init(resource: resource)
		)
	}

	func post<Resource: Encodable, ResourceParameters: Parameters, ReturnedResource: Decodable>(_ resource: Resource, to path: Path, specifying parameters: ResourceParameters) -> Request<ReturnedResource> {
		request(
			method: .post,
			path: path,
			headerParameters: parameters,
			payload: .init(resource: resource)
		)
	}

	func post<Resource: Encodable, ReturnedResource: Decodable & PathAccessible>(_ resource: Resource) -> Request<ReturnedResource> {
		let path = ReturnedResource.path
		return post(resource, to: path)
	}

	func post<Resource: Encodable, ResourceParameters: Parameters, ReturnedResource: Decodable & PathAccessible>(_ resource: Resource, specifying parameters: ResourceParameters) -> Request<ReturnedResource> {
		let path = ReturnedResource.path
		return post(resource, to: path, specifying: parameters)
	}
}
