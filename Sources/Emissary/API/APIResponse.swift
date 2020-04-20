// Copyright © Fleuronic LLC. All rights reserved.

public protocol APIResponse {
	associatedtype Data

	var data: Data { get }
}
