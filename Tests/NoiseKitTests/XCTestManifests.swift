import XCTest

#if !canImport(ObjectiveC)
  public func allTests() -> [XCTestCaseEntry] {
    [
      testCase(NoiseKitTests.allTests),
    ]
  }
#endif
