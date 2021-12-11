// Copyright © Fleuronic LLC. All rights reserved.

public protocol HeaderValue {
	var stringValue: String { get }
}

// MARK: -
public extension HeaderValue where Self: CustomStringConvertible {
	var stringValue: String { description }
}

// MARK: -
extension Int: HeaderValue {}

// MARK: -
extension String: HeaderValue {}
