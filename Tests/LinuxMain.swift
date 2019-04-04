import XCTest

import SDGSwiftConfigurationTests
import SDGSwiftDocumentationExampleTests
import SDGSwiftPackageManagerTests
import SDGSwiftSourceTests
import SDGSwiftTests
import SDGXCTestUtilities
import SDGXcodeTests

var tests = [XCTestCaseEntry]()
tests += SDGSwiftConfigurationTests.__allTests()
tests += SDGSwiftDocumentationExampleTests.__allTests()
tests += SDGSwiftPackageManagerTests.__allTests()
tests += SDGSwiftSourceTests.__allTests()
tests += SDGSwiftTests.__allTests()
tests += SDGXCTestUtilities.__allTests()
tests += SDGXcodeTests.__allTests()

XCTMain(tests)
