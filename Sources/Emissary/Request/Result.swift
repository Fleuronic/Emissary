// Copyright © Fleuronic LLC. All rights reserved.

#if canImport(Combine)
import Combine
#elseif canImport(CombineX)
import CombineX
#endif

#if swift(>=5.5)
public extension Request where Response: Decodable {
	var returnedResult: Result<Resource, NetworkError> {
		get async {
			var cancellable: AnyCancellable?

			let publisher = await asyncPublisher
			return await withCheckedContinuation { continuation in
				cancellable = publisher.sink { completion in
					guard case let .failure(error) = completion else { return }
					continuation.resume(returning: .failure(error))
				} receiveValue: { value in
					cancellable?.cancel()
					continuation.resume(returning: .success(value))
				}
			}
		}
	}
}

public extension Request where Response: DataDecodable {
	var returnedResult: Result<Resource, NetworkError> {
		get async {
			var cancellable: AnyCancellable?

			let publisher = await asyncPublisher
			return await withCheckedContinuation { continuation in
				cancellable = publisher.sink { completion in
					guard case let .failure(error) = completion else { return }
					continuation.resume(returning: .failure(error))
				} receiveValue: { value in
					cancellable?.cancel()
					continuation.resume(returning: .success(value))
				}
			}
		}
	}
}
#endif
