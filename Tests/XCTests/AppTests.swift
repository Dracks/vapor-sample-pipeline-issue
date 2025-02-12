import Foundation
import XCTVapor
import XCTest

@testable import App

final class PipelineErrorTests: XCTestCase {
	var group: UserGroup?
	var app: Application?

	override func setUp() async throws {
		try await super.setUp()

		let app = try await Application.make(.testing)
		try await configure(app)

		self.app = app

		let group = UserGroup(name: "Test User Group")
		try await group.save(on: app.db)
		// self.group = group
		print("UserCreated")
	}

	override func tearDown() async throws {
		try await super.tearDown()
		if let app {
			try await app.asyncShutdown()
			print("Async shutdown")
			self.app = nil
			print("Finish")
		}
	}

	func testUpdateWithInvalidDefaultGroupId() async throws {}
}
