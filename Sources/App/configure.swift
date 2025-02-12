import Fluent
import FluentSQLiteDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
	// uncomment to serve files from /Public folder
	// app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
	// register routes
	//
	app.databases.use(
		DatabaseConfigurationFactory.sqlite(
			.memory), as: .sqlite)

	app.migrations.add(InitialMigration())

	if app.environment == .testing {
		try await app.autoMigrate()
	}

	try routes(app)
}
