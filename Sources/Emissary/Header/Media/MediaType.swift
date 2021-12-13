// Copyright © Fleuronic LLC. All rights reserved.

public enum MediaType {
	case application(Application)
}

// MARK: -
public extension MediaType {
	enum Application: String, MediaTypeComponent {
		case json
		case url = "x-www-form-urlencoded"
	}
}

// MARK: -
extension MediaType: HeaderValue {
	// MARK: HeaderValue
	public var stringValue: String {
		let components: [MediaTypeComponent] = [topLevelType, subtype]
		return components
			.map { $0.rawValue }
			.joined(separator: .slash)
	}
}

// MARK: -
private extension MediaType {
	enum TopLevelType: String, MediaTypeComponent {
		case application
	}

	var topLevelType: TopLevelType {
		switch self {
		case .application:
			return .application
		}
	}

	var subtype: Application {
		switch self {
		case let .application(application):
			return application
		}
	}
}

// MARK: -
private extension String {
	static let slash = "/"
}
