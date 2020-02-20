/*
 WindowsMain.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

@testable import SDGSwiftDocumentationExampleTests
@testable import SDGSwiftPackageManagerTests
@testable import SDGSwiftTests
@testable import SDGXcodeTests
@testable import SDGSwiftConfigurationTests
@testable import SDGSwiftSourceTests

extension ReadMeExampleTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testReadMe", testReadMe),
    ])
  ]
}

extension SDGSwiftPackageManagerAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testChangeDetection", testChangeDetection),
      ("testErrors", testErrors),
      ("testIgnoredFileDetection", testIgnoredFileDetection),
      ("testInitialization", testInitialization),
      ("testManifestLoading", testManifestLoading),
      ("testPackageGraphLoading", testPackageGraphLoading),
      ("testTestCoverage", testTestCoverage),
    ])
  ]
}

extension SDGSwiftAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testBuild", testBuild),
      ("testGit", testGit),
      ("testGitError", testGitError),
      ("testLocalizations", testLocalizations),
      ("testPackage", testPackage),
      ("testPackageError", testPackageError),
      ("testPackageRepository", testPackageRepository),
      ("testSwiftCompiler", testSwiftCompiler),
      ("testSwiftCompilerError", testSwiftCompilerError),
      ("testVersion", testVersion),
      ("testVersionedExternalProcess", testVersionedExternalProcess),
    ])
  ]
}

extension SDGSwiftRegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testDependencyWarnings", testDependencyWarnings),
      ("testDynamicLinking", testDynamicLinking),
      ("testIgnoredFilesCheckIsStable", testIgnoredFilesCheckIsStable),
    ])
  ]
}

extension SDGXcodeAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testDependencyWarnings", testDependencyWarnings),
      ("testXcode", testXcode),
      ("testXcodeCoverage", testXcodeCoverage),
      ("testXcodeError", testXcodeError),
    ])
  ]
}

extension SDGXcodeRegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      (
        "testSchemeDetectionWithMutlipleLibrariesAndTool",
        testSchemeDetectionWithMutlipleLibrariesAndTool
      ),
    ])
  ]
}

extension SDGSwiftConfigurationAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testConfiguration", testConfiguration),
      ("testConfigurationError", testConfigurationError),
    ])
  ]
}

extension SDGSwiftConfigurationInternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testLocalization", testLocalization),
    ])
  ]
}

extension SDGSwiftSourceAPITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testAPIParsing", testAPIParsing),
      ("testCallout", testCallout),
      ("testCodeFragmentSyntax", testCodeFragmentSyntax),
      ("testCoreLibraries", testCoreLibraries),
      ("testCSS", testCSS),
      ("testExtension", testExtension),
      ("testFunctionalSyntaxScanner", testFunctionalSyntaxScanner),
      ("testLineDeveloperCommentSyntax", testLineDeveloperCommentSyntax),
      ("testLineDocumentationCommentSyntax", testLineDocumentationCommentSyntax),
      ("testLocations", testLocations),
      ("testPackageDocumentation", testPackageDocumentation),
      ("testParsing", testParsing),
      ("testTokenSyntax", testTokenSyntax),
      ("testTree", testTree),
      ("testTriviaPiece", testTriviaPiece),
    ])
  ]
}

extension SDGSwiftSourceInternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testEmptySyntax", testEmptySyntax),
      ("testExtendedSyntaxContext", testExtendedSyntaxContext),
      ("testLocalizations", testLocalizations),
      ("testStringLiteral", testStringLiteral),
      ("testTokenNormalization", testTokenNormalization),
    ])
  ]
}

extension SDGSwiftSourceRegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testContinuedCallout", testContinuedCallout),
      ("testMarkdownEntity", testMarkdownEntity),
      ("testMarkdownQuotation", testMarkdownQuotation),
      ("testPackageDeclaration", testPackageDeclaration),
    ])
  ]
}

var tests = [XCTestCaseEntry]()
tests += ReadMeExampleTests.windowsTests
tests += SDGSwiftPackageManagerAPITests.windowsTests
tests += SDGSwiftAPITests.windowsTests
tests += SDGSwiftRegressionTests.windowsTests
tests += SDGXcodeAPITests.windowsTests
tests += SDGXcodeRegressionTests.windowsTests
tests += SDGSwiftConfigurationAPITests.windowsTests
tests += SDGSwiftConfigurationInternalTests.windowsTests
tests += SDGSwiftSourceAPITests.windowsTests
tests += SDGSwiftSourceInternalTests.windowsTests
tests += SDGSwiftSourceRegressionTests.windowsTests

XCTMain(tests)
