// Copyright © Fleuronic LLC. All rights reserved.

#if swift(>=5.5)
#if canImport(Combine)
import Combine
#else
import CombineX
#endif

import Foundation
import AsyncOptional

extension Request {
#if swift(<5.5.2)
	@available(iOS 15, macOS 12, watchOS 8, tvOS 15, *)
	func fixturePublisher(for url: URL, using transform: @escaping (Data) throws -> Resource) async throws -> AnyPublisher<Resource, NetworkError> {
		let fixtures: [Fixture<DecodingAPI>] = try await FixtureCache.fixtures(for: url)
		let fixture = try fixtures.first { try $0.matches(request: urlRequest) }
		let result: Result<Resource, NetworkError>? = try await fixture.asyncMap {
			try await FixtureCache.response(for: $0, from: url, using: transform)
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
#else
	func fixturePublisher(for url: URL, using transform: @escaping (Data) throws -> Resource) async throws -> AnyPublisher<Resource, NetworkError> {
		let fixtures: [Fixture<DecodingAPI>] = try await FixtureCache.fixtures(for: url)
		let fixture = try fixtures.first { try $0.matches(request: urlRequest) }
		let result: Result<Resource, NetworkError>? = try await fixture.asyncMap {
			try await FixtureCache.response(for: $0, from: url, using: transform)
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
#endif

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
#endif
