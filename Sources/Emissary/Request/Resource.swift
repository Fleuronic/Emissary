// Copyright © Fleuronic LLC. All rights reserved.

#if swift(>=5.5)
public extension Request where Response: Decodable {
	var returnedResource: Resource {
		get async throws {
			try await returnedResult.get()
		}
	}
}

public extension Request where Response: DataDecodable {
	var returnedResource: Resource {
		get async throws {
			try await returnedResult.get()
		}
	}
}

#endif
