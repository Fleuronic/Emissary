// Copyright © Fleuronic LLC. All rights reserved.

public extension API {
	func deleteResource<ReturnedResource: Decodable>(at path: Path) -> Request<ReturnedResource> {
		request(
			method: .delete,
			path: path
		)
	}

	func deleteResource<ResourceParameters: Parameters, ReturnedResource: Decodable>(at path: Path, specifying parameters: ResourceParameters) -> Request<ReturnedResource> {
		if prefersHeaderParameters {
			return request(
				method: .delete,
				path: path,
				headerParameters: parameters
			)
		}

		return request(
			method: .delete,
			path: path,
			queryParameters: parameters
		)
	}


	func deleteResource<ResourceParameters: Parameters, Resource: PathAccessible, ReturnedResource: Decodable>(ofType type: Resource.Type, specifying parameters: ResourceParameters) -> Request<ReturnedResource> {
		let path = type.path
		return deleteResource(at: path, specifying: parameters)
	}
}
