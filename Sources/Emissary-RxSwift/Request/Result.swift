// Copyright © Fleuronic LLC. All rights reserved.

import Emissary
import Combine
import RxSwift
import RxCombine

import UIKit

public extension Request where Response: Decodable {
	var returnedResult: Single<Result<Resource, NetworkError>> {
		publisher.asResultSingle()
	}
}

public extension Request where Response: DataDecodable {
	var returnedResult: Single<Result<Resource, NetworkError>> {
		publisher.asResultSingle()
	}
}

public extension Request where Resource == Void {
	var returnedResult: Single<Result<Void, NetworkError>> {
		publisher.asResultSingle()
	}
}

private extension Publisher {
	func asResultSingle() -> Single<Result<Output, Failure>> {
		map(Result.success)
			.catch { Just(.failure($0)) }
			.asObservable()
			.asSingle()
	}
}
