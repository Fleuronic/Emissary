// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

#if swift(>=5.5)
#if swift(<5.5.2)
@available(iOS 15, macOS 12, watchOS 8, tvOS 15, *)
actor FixtureCache {
	private var fixtureStorage: [URL: Any] = [:]
	private var responseStorage: [String: Any] = [:]

	private static let shared = FixtureCache()

	private init() {}
}

// MARK: -
@available(iOS 15, macOS 12, watchOS 8, tvOS 15, *)
extension FixtureCache {
	static func fixtures<API: Emissary.API>(for url: URL) async throws -> [Fixture<API>] {
		guard let fixtures = await shared.fixtureStorage[url] as? [Fixture<API>] else {
			let data = try Data(contentsOf: url, options: [])
			let fixtures = try API.decoder.decode([Fixture<API>].self, from: data)
			await shared.set(fixtures, for: url)
			return fixtures
		}

		return fixtures
	}

	static func response<API: Emissary.API, Resource>(for fixture: Fixture<API>, from url: URL, using transform: @escaping (Data) throws -> Resource) async throws -> Result<Resource, NetworkError<API.Error>> {
		let name = fixture.responseName

		guard let response = await shared.responseStorage[name] as? Result<Resource, NetworkError<API.Error>> else {
			let url = url
				.deletingLastPathComponent()
				.appendingPathComponent(name)
				.appendingPathExtension("json")

			let response: Result<Resource, NetworkError<API.Error>>
			let data = try Data(contentsOf: url, options: [])

			if fixture.statusCode.category == .success {
				response = .success(try transform(data))
			} else {
				response = .failure(
					.requestUnsuccessful(
						fixture.statusCode,
						try API.decoder.decode(API.Error.self, from: data)
					)
				)
			}

			await shared.set(response, for: name, using: API.self)
			return response
		}

		return response
	}
}

// MARK: -
@available(iOS 15, macOS 12, watchOS 8, tvOS 15, *)
private extension FixtureCache {
	func set<API: Emissary.API>(_ fixtures: [Fixture<API>], for url: URL) {
		fixtureStorage[url] = fixtures
	}

	func set<API: Emissary.API, Response>(_ response: Result<Response, NetworkError<API.Error>>, for name: String, using _: API.Type) {
		responseStorage[name] = response
	}
}
#else
actor FixtureCache {
	private var fixtureStorage: [URL: Any] = [:]
	private var responseStorage: [String: Any] = [:]

	private static let shared = FixtureCache()

	private init() {}
}

// MARK: -
extension FixtureCache {
	static func fixtures<API: Emissary.API>(for url: URL) async throws -> [Fixture<API>] {
		guard let fixtures = await shared.fixtureStorage[url] as? [Fixture<API>] else {
			let data = try Data(contentsOf: url, options: [])
			let fixtures = try API.decoder.decode([Fixture<API>].self, from: data)
			await shared.set(fixtures, for: url)
			return fixtures
		}

		return fixtures
	}

	static func response<API: Emissary.API, Resource>(for fixture: Fixture<API>, from url: URL, using transform: @escaping (Data) throws -> Resource) async throws -> Result<Resource, NetworkError<API.Error>> {
		let name = fixture.responseName

		guard let response = await shared.responseStorage[name] as? Result<Resource, NetworkError<API.Error>> else {
			let url = url
				.deletingLastPathComponent()
				.appendingPathComponent(name)
				.appendingPathExtension("json")

			let response: Result<Resource, NetworkError<API.Error>>
			let data = try Data(contentsOf: url, options: [])

			if fixture.statusCode.category == .success {
				response = .success(try transform(data))
			} else {
				response = .failure(
					.requestUnsuccessful(
						fixture.statusCode,
						try API.decoder.decode(API.Error.self, from: data)
					)
				)
			}

			await shared.set(response, for: name, using: API.self)
			return response
		}

		return response
	}
}

// MARK: -
private extension FixtureCache {
	func set<API: Emissary.API>(_ fixtures: [Fixture<API>], for url: URL) {
		fixtureStorage[url] = fixtures
	}

	func set<API: Emissary.API, Response>(_ response: Result<Response, NetworkError<API.Error>>, for name: String, using _: API.Type) {
		responseStorage[name] = response
	}
}
#endif
#endif
