// Copyright © Fleuronic LLC. All rights reserved.

public protocol PathComponent {
	var rawValue: String { get }
}

// MARK: -
public extension RawRepresentable where RawValue == String {}

// MARK: -
extension Int: PathComponent {
	// MARK: PathComponent
	public var rawValue: String {
		.init(describing: self)
	}
}

// MARK: -
extension String: PathComponent {
	// MARK: PathComponent
	public var rawValue: String {
		self
	}
}
