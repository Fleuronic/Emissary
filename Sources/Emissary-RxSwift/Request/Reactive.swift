// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
import Emissary
import RxSwift

extension Reactive: API where Base: API {
	// MARK: API
	public typealias Error = Base.Error
	public typealias HeaderParameters = Base.HeaderParameters

	public var baseURL: URL {
		base.baseURL
	}

	public var customHeaderParameters: HeaderParameters {
		base.customHeaderParameters
	}
}
