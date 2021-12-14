// Copyright © Fleuronic LLC. All rights reserved.

#if canImport(Combine)
import Combine
#else
import CombineX
#endif

public extension Request where Response: Decodable {
	func execute(
		success: @escaping (Resource) -> Void = { _ in },
		failure: @escaping (NetworkError) -> Void = { _ in }
	) {
		var cancellable: AnyCancellable?
		cancellable = publisher.sink(receiveCompletion: {
			guard case let .failure(error) = $0 else { return }
			failure(error)
		}, receiveValue: {
			cancellable?.cancel()
			success($0)
		})
	}

	func callAsFunction(
		success: @escaping (Resource) -> Void = { _ in },
		failure: @escaping (NetworkError) -> Void = { _ in }
	) {
		execute(
			success: success,
			failure: failure
		)
	}
}

public extension Request where Response: DataDecodable {
	func execute(
		success: @escaping (Resource) -> Void = { _ in },
		failure: @escaping (NetworkError) -> Void = { _ in }
	) {
		var cancellable: AnyCancellable?
		cancellable = publisher.sink(receiveCompletion: {
			guard case let .failure(error) = $0 else { return }
			failure(error)
		}, receiveValue: {
			cancellable?.cancel()
			success($0)
		})
	}

	func callAsFunction(
		success: @escaping (Resource) -> Void = { _ in },
		failure: @escaping (NetworkError) -> Void = { _ in }
	) {
		execute(
			success: success,
			failure: failure
		)
	}
}

public extension Request where Resource == Void {
	func execute(
		success: @escaping () -> Void = {},
		failure: @escaping (NetworkError) -> Void = { _ in }
	) {
		var cancellable: AnyCancellable?
		cancellable = publisher.sink(receiveCompletion: {
			guard case let .failure(error) = $0 else { return }
			failure(error)
		}, receiveValue: {
			cancellable?.cancel()
			success()
		})
	}

	func callAsFunction(
		success: @escaping () -> Void = {},
		failure: @escaping (NetworkError) -> Void = { _ in }
	) {
		execute(
			success: success,
			failure: failure
		)
	}
}
