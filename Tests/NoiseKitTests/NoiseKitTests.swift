import XCTest
@testable import NoiseKit

final class NoiseKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(NoiseKit2().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
