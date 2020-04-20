// Copyright © Fleuronic LLC. All rights reserved.

protocol MediaTypeComponent {
	var rawValue: String { get }
}

// MARK: -
extension RawRepresentable where Self: MediaTypeComponent, RawValue == String {}
