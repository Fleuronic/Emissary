// Copyright © Fleuronic LLC. All rights reserved.

public enum NetworkError<APIErrorType: APIError>: Error {
	case noData
	case noResponse
	case couldNotParseData(DecodingError)
	case requestUnsuccessful(StatusCode, APIErrorType)
	case other(Error)
}

// MARK: -
extension NetworkError {
	init(error: Error) {
		self = error as? NetworkError ?? .other(error)
	}
}
