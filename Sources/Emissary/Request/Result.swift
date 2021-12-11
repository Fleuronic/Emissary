// Copyright © Fleuronic LLC. All rights reserved.

import Combine

#if swift(>=5.5)
	#if swift(<5.5.2)
		@available(iOS 15, macOS 12, watchOS 8, tvOS 15, *)
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
	#else
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
	#endif

	#if swift(<5.5.2)
		@available(iOS 15, macOS 12, watchOS 8, tvOS 15, *)
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
	#else
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
#endif
