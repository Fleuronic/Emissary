// Copyright © Fleuronic LLC. All rights reserved.

public protocol APIResponse {
	associatedtype ResponseData

	var data: ResponseData { get }
}
