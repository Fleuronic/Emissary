// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

extension URL {
	init(
		fixtureURLString: String,
		decoder: Decoder
	) throws {
		guard
			let string = fixtureURLString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
			let url = URL(string: string)
		else {
			throw DecodingError.dataCorrupted(
				DecodingError.Context(
					codingPath: decoder.codingPath,
					debugDescription: "Invalid URL string."
				)
			)
		}

		self = url
	}
}
