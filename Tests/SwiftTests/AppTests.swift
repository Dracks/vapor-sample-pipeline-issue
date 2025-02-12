import Testing
import VaporTesting

@testable import App

@Suite("App Tests")
struct AppTests {
	private func withApp(_ test: (Application) async throws -> Void) async throws {
		let app = try await Application.make(.testing)
		do {
			try await configure(app)
			let group = UserGroup(name: "Test User Group")
			try await group.save(on: app.db)

			try await test(app)
		} catch {
			try await app.asyncShutdown()
			throw error
		}
		try await app.asyncShutdown()
	}

	@Test("Test Hello World Route")
	func helloWorld() async throws {
		try await withApp { app in
			try await app.testing().test(
				.GET, "hello",
				afterResponse: { res async in
					#expect(res.status == .ok)
					#expect(res.body.string == "Hello, world!")
				})
		}
	}
}
