// swift-tools-version:6.0
import PackageDescription

let package = Package(
	name: "vapor-sample-pipeline-issue",
	platforms: [
		.macOS(.v13)
	],
	dependencies: [
		// 💧 A server-side Swift web framework.
		.package(url: "https://github.com/vapor/vapor.git", from: "4.110.1"),
		// 🔵 Non-blocking, event-driven networking for Swift. Used for custom executors
		.package(url: "https://github.com/apple/swift-nio.git", from: "2.65.0"),
		.package(url: "https://github.com/vapor/fluent.git", from: "4.12.0"),
		.package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.8.0"),
	],
	targets: [
		.executableTarget(
			name: "App",
			dependencies: [
				.product(name: "Vapor", package: "vapor"),
				.product(name: "NIOCore", package: "swift-nio"),
				.product(name: "NIOPosix", package: "swift-nio"),
				.product(name: "Fluent", package: "fluent"),
				.product(
					name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
			],
			swiftSettings: swiftSettings
		),
		.testTarget(
			name: "SwiftTests",
			dependencies: [
				.target(name: "App"),
				.product(name: "VaporTesting", package: "vapor"),
			],
			swiftSettings: swiftSettings
		),
		.testTarget(
			name: "XCTests",
			dependencies: [
				.target(name: "App"),
				.product(name: "XCTVapor", package: "vapor"),
			],
			swiftSettings: swiftSettings
		),
	],
	swiftLanguageModes: [.v5]
)

var swiftSettings: [SwiftSetting] {
	[
		.enableUpcomingFeature("DisableOutwardActorInference"),
		.enableExperimentalFeature("StrictConcurrency"),
	]
}
