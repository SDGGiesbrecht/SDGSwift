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

extension APITests {
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

extension APITests {
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

extension RegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testDependencyWarnings", testDependencyWarnings),
      ("testDynamicLinking", testDynamicLinking),
      ("testIgnoredFilesCheckIsStable", testIgnoredFilesCheckIsStable),
    ])
  ]
}

extension APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testDependencyWarnings", testDependencyWarnings),
      ("testXcode", testXcode),
      ("testXcodeCoverage", testXcodeCoverage),
      ("testXcodeError", testXcodeError),
    ])
  ]
}

extension RegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      (
        "testSchemeDetectionWithMutlipleLibrariesAndTool",
        testSchemeDetectionWithMutlipleLibrariesAndTool
      ),
    ])
  ]
}

extension APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testConfiguration", testConfiguration),
      ("testConfigurationError", testConfigurationError),
    ])
  ]
}

extension InternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testLocalization", testLocalization),
    ])
  ]
}

extension APITests {
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

extension Highlighter {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ])
  ]
}

extension TextFreedomHighlighter {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ])
  ]
}

extension InternalTests {
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

extension RegressionTests {
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
tests += APITests.windowsTests
tests += APITests.windowsTests
tests += RegressionTests.windowsTests
tests += APITests.windowsTests
tests += RegressionTests.windowsTests
tests += APITests.windowsTests
tests += InternalTests.windowsTests
tests += APITests.windowsTests
tests += Highlighter.windowsTests
tests += TextFreedomHighlighter.windowsTests
tests += InternalTests.windowsTests
tests += RegressionTests.windowsTests

XCTMain(tests)
