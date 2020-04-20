// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public struct CodingStrategy {
	let pathEncodingStrategy: PathEncodingStrategy
	let keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy

	private let keyEncodingStrategy: [EncodingContext: JSONEncoder.KeyEncodingStrategy]
	private let dateEncodingStrategy: JSONEncoder.DateEncodingStrategy?
	private let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy?

	public init(
		pathEncodingStrategy: PathEncodingStrategy = .useDefaultComponents,
		keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase,
		keyEncodingStrategy: [EncodingContext: JSONEncoder.KeyEncodingStrategy] = [:],
		dateDecodingStrategy: JSONDecoder.DateDecodingStrategy? = nil,
		dateEncodingStrategy: JSONEncoder.DateEncodingStrategy? = nil
	) {
		self.pathEncodingStrategy = pathEncodingStrategy
		self.keyEncodingStrategy = keyEncodingStrategy
		self.keyDecodingStrategy = keyDecodingStrategy
		self.dateEncodingStrategy = dateEncodingStrategy
		self.dateDecodingStrategy = dateDecodingStrategy
	}
}

// MARK: -
extension CodingStrategy {
	func keyEncodingStrategy(in context: EncodingContext) -> JSONEncoder.KeyEncodingStrategy {
		keyEncodingStrategy[context] ?? .convertToSnakeCase
	}

	func dateDecodingStrategy(using formatter: DateFormatter?) -> JSONDecoder.DateDecodingStrategy {
		formatter.map(JSONDecoder.DateDecodingStrategy.formatted) ?? .iso8601
	}

	func dateEncodingStrategy(using formatter: DateFormatter?) -> JSONEncoder.DateEncodingStrategy {
		formatter.map(JSONEncoder.DateEncodingStrategy.formatted) ?? .iso8601
	}
}
