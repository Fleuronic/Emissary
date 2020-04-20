// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

extension DateFormatter {
	convenience init(dateFormat: String) {
		self.init()
		locale = .init(identifier: .posix)
		timeZone = TimeZone(secondsFromGMT: 0)
		self.dateFormat = dateFormat
	}
}

// MARK: -
private extension String {
	static let posix = "en_US_POSIX"
}
