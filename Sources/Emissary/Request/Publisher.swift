// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

#if canImport(Combine)
import Combine
#else
import CombineX
import CXFoundation
#endif

public extension Request where Response: Decodable {
	var publisher: AnyPublisher<Resource, NetworkError> {
		publisher(using: parse)
	}
}

public extension Request where Response: DataDecodable {
	var publisher: AnyPublisher<Resource, NetworkError> {
		publisher(using: parse)
	}
}

public extension Request where Resource == Void {
	var publisher: AnyPublisher<Void, NetworkError> {
		publisher(using: discard)
	}
}

#if swift(>=5.5)
// MARK: -
extension Request where Response: Decodable {
#if swift(<5.5.2)
	@available(iOS 15, macOS 12, watchOS 8, tvOS 15, *)
	var asyncPublisher: AnyPublisher<Resource, NetworkError> {
		get async {
			await publisher(using: parse)
		}
	}
#else
	var asyncPublisher: AnyPublisher<Resource, NetworkError> {
		get async {
			await publisher(using: parse)
		}
	}
#endif
}

extension Request where Response: DataDecodable {
#if swift(<5.5.2)
	@available(iOS 15, macOS 12, watchOS 8, tvOS 15, *)
	var asyncPublisher: AnyPublisher<Resource, NetworkError> {
		get async {
			await publisher(using: parse)
		}
	}
#else
	var asyncPublisher: AnyPublisher<Resource, NetworkError> {
		get async {
			await publisher(using: parse)
		}
	}
#endif
}
#endif

// MARK: -
private extension Request {
	func publisher(using transform: @escaping (Data) throws -> Resource) -> AnyPublisher<Resource, NetworkError> {
		dataTaskPublisher(using: transform)
	}

#if swift(>=5.5)
#if swift(<5.5.2)
	@available(iOS 15, macOS 12, watchOS 8, tvOS 15, *)
	func publisher(using transform: @escaping (Data) throws -> Resource) async -> AnyPublisher<Resource, NetworkError> {
		if let url = fixturesURL {
			do {
				return try await fixturePublisher(for: url, using: transform)
			} catch {
				return fixturePublisher(for: .other(error))
			}
		}
		return dataTaskPublisher(using: transform)
	}
#else
	func publisher(using transform: @escaping (Data) throws -> Resource) async -> AnyPublisher<Resource, NetworkError> {
		if let url = fixturesURL {
			do {
				return try await fixturePublisher(for: url, using: transform)
			} catch {
				return fixturePublisher(for: .other(error))
			}
		}
		return dataTaskPublisher(using: transform)
	}
#endif
#endif

#if canImport(Combine)
	func dataTaskPublisher(using transform: @escaping (Data) throws -> Resource) -> AnyPublisher<Resource, NetworkError> {
		URLSession.shared
			.dataTaskPublisher(for: urlRequest)
			.tryMap(process)
			.tryMap(transform)
			.mapError(NetworkError.init)
			.receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()
	}
#else
	func dataTaskPublisher(using transform: @escaping (Data) throws -> Resource) -> AnyPublisher<Resource, NetworkError> {
		URLSession.shared.cx
			.dataTaskPublisher(for: urlRequest)
			.tryMap(process)
			.tryMap(transform)
			.mapError(NetworkError.init)
			.receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()
	}
#endif

	func process(_ data: Data?, with response: URLResponse?) throws -> Data {
		guard let data = data else {
			throw NetworkError.noData
		}
		guard let statusCode = (response as? HTTPURLResponse).flatMap(StatusCode.init) else {
			throw NetworkError.noResponse
		}
		guard statusCode.category == .success else {
			let error = try parseErrorData(data)
			throw NetworkError.requestUnsuccessful(statusCode, error)
		}
		return data
	}

	func parseErrorData(_ data: Data) throws -> DecodingAPI.Error {
		do {
			let decoder = DecodingAPI.decoder
			return try decoder.decode(DecodingAPI.Error.self, from: data)
		} catch {
			throw NetworkError.couldNotParseData(error as! DecodingError)
		}
	}
}

private extension Request where Response: Decodable {
	func parse(_ data: Data) throws -> Resource {
		do {
			let decoder = DecodingAPI.decoder
			let response = try decoder.decode(Response.self, from: data)
			return response.data
		} catch {
			throw NetworkError.couldNotParseData(error as! DecodingError)
		}
	}
}

private extension Request where Response: DataDecodable {
	func parse(_ data: Data) throws -> Resource {
		Response(from: data).data
	}
}

private extension Request where Resource == Void {
	func discard(_: Data) throws {}
}
