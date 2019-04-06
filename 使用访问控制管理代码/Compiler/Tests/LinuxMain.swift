import XCTest

import CompilerTests

var tests = [XCTestCaseEntry]()
tests += CompilerTests.allTests()
XCTMain(tests)
