// Copyright © Fleuronic LLC. All rights reserved.

import Combine

#if swift(>=5.5)
#if swift(<5.5.2)
@available(iOS 15, macOS 12, watchOS 8, tvOS 15, *)
#endif
public extension Request where Response: Decodable {
	var returnedResource: Resource {
		get async throws {
			try await returnedResult.get()
		}
	}
}

#if swift(<5.5.2)
@available(iOS 15, macOS 12, watchOS 8, tvOS 15, *)
#endif
public extension Request where Response: DataDecodable {
	var returnedResource: Resource {
		get async throws {
			try await returnedResult.get()
		}
	}
}
#endif
