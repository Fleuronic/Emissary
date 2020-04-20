// Copyright © Fleuronic LLC. All rights reserved.

public extension API {
	func getResource<Resource: Decodable & PathAccessible>() -> Request<Resource> {
		let path = Resource.path
		return getResource(at: path)
	}

	func getResource<Resource: Decodable>(at path: Path) -> Request<Resource> {
		request(
			method: .get,
			path: path
		)
	}

	func getResource<Resource: Decodable & PathAccessible, ResourceParameters: Parameters>(specifiedBy parameters: ResourceParameters) -> Request<Resource> {
		let path = Resource.path
		return getResource(at: path, specifiedBy: parameters)
	}

	func getResource<Resource: Decodable, ResourceParameters: Parameters>(at path: Path, specifiedBy parameters: ResourceParameters) -> Request<Resource> {
		if prefersHeaderParameters {
			return request(
				method: .get,
				path: path,
				headerParameters: parameters
			)
		}

		return request(
			method: .get,
			path: path,
			queryParameters: parameters
		)
	}

	func getResource<Resource: DataDecodable & PathAccessible>() -> Request<Resource> {
		let path = Resource.path
		return getResource(at: path)
	}

	func getResource<Resource: DataDecodable>(at path: Path) -> Request<Resource> {
		request(
			method: .get,
			path: path
		)
	}

	func getResource<Resource: DataDecodable & PathAccessible, ResourceParameters: Parameters>(specifiedBy parameters: ResourceParameters) -> Request<Resource> {
		let path = Resource.path
		return getResource(at: path, specifiedBy: parameters)
	}

	func getResource<Resource: DataDecodable, ResourceParameters: Parameters>(at path: Path, specifiedBy parameters: ResourceParameters) -> Request<Resource> {
		if prefersHeaderParameters {
			return request(
				method: .get,
				path: path,
				headerParameters: parameters
			)
		}

		return request(
			method: .get,
			path: path,
			queryParameters: parameters
		)
	}

	func getResourceCollection<ResourceCollection: Decodable & Collection>() -> Request<ResourceCollection> where ResourceCollection.Element: PathAccessible {
		let path = ResourceCollection.Element.path
		return getResource(at: path)
	}

	func getResourceCollection<ResourceCollection: Decodable & Collection, ResourceParameters: Parameters>(specifiedBy parameters: ResourceParameters) -> Request<ResourceCollection> where ResourceCollection.Element: PathAccessible {
		let path = ResourceCollection.Element.path
		return getResource(at: path, specifiedBy: parameters)
	}
}
