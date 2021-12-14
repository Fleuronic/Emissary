// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public protocol FixtureAPI {
	var fixturesURL: URL { get }
}
