// Copyright © Fleuronic LLC. All rights reserved.

#if canImport(Combine)
import Combine
#elseif canImport(CombineX)
import CombineX
#endif

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension Request {
	func fixturePublisher(for url: URL, using transform: @escaping (Data) throws -> Resource) throws -> AnyPublisher<Resource, NetworkError> {
		let fixtures: [Fixture<DecodingAPI>] = try FixtureCache.fixtures(for: url)
		let fixture = try fixtures.first { try $0.matches(request: urlRequest) }
		let result: Result<Resource, NetworkError>? = try fixture.map {
			try FixtureCache.response(for: $0, from: url, using: transform)
		}

		switch result {
		case .none:
			return noDataPublisher
		case let .success(resource):
			return fixturePublisher(for: resource)
		case let .failure(error):
			return fixturePublisher(for: error)
		}
	}

	func fixturePublisher(for error: NetworkError) -> AnyPublisher<Resource, NetworkError> {
		Fail(error: error).eraseToAnyPublisher()
	}
}

// MARK: -
private extension Request {
	var noDataPublisher: AnyPublisher<Resource, NetworkError> {
		Fail(error: .noData).eraseToAnyPublisher()
	}

	func fixturePublisher(for resource: Resource) -> AnyPublisher<Resource, NetworkError> {
		Just(resource).setFailureType(to: NetworkError.self).eraseToAnyPublisher()
	}
}
