// Copyright © Fleuronic LLC. All rights reserved.

public extension API {
	func put<ReturnedResource: Decodable>(at path: Path) -> Request<ReturnedResource> {
		request(
			method: .put,
			path: path
		)
	}

	func put<RequestParameters: Parameters, ReturnedResource: Decodable>(at path: Path, specifying parameters: RequestParameters) -> Request<ReturnedResource> {
		request(
			method: .put,
			path: path,
			headerParameters: parameters
		)
	}

	func put<Resource: Encodable, ReturnedResource: Decodable>(_ resource: Resource, at path: Path) -> Request<ReturnedResource> {
		request(
			method: .put,
			path: path,
			payload: .init(resource: resource)
		)
	}

	func put<Resource: Encodable, ResourceParameters: Parameters, ReturnedResource: Decodable>(_ resource: Resource, at path: Path, specifying parameters: ResourceParameters) -> Request<ReturnedResource> {
		request(
			method: .put,
			path: path,
			headerParameters: parameters,
			payload: .init(resource: resource)
		)
	}
}
