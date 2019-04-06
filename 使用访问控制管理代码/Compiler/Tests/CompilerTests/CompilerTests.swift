import XCTest
@testable import Compiler

final class CompilerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Compiler().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
