@testable import NoiseKit
import XCTest

final class NoiseKitTests: XCTestCase {
  func testConstantNoiseOutputImageNotNil() {
    let noise = AHNGeneratorConstant()
    XCTAssertNotNil(noise.uiImage())
  }

  func testSimplexNoiseOutputImageNotNil() {
    let noise = AHNGeneratorSimplex()
    XCTAssertNotNil(noise.uiImage())
  }

  static var allTests = [
    ("testConstantNoiseOutputImageNotNil", testConstantNoiseOutputImageNotNil),
    ("testSimplexNoiseOutputImageNotNil", testSimplexNoiseOutputImageNotNil),
  ]
}
