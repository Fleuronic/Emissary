// Copyright © Fleuronic LLC. All rights reserved.

public protocol HeaderValue {
	var stringValue: String { get }
}

// MARK: -
extension HeaderValue where Self: CustomStringConvertible {
	public var stringValue: String { description }
}

// MARK: -
extension Int: HeaderValue {}

// MARK: -
extension String: HeaderValue {}
