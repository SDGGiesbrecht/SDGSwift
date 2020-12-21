/*
 main.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

@testable import SDGSwiftConfigurationTests
@testable import SDGSwiftDocumentationExampleTests
@testable import SDGSwiftPackageManagerTests
@testable import SDGSwiftSourceTests
@testable import SDGSwiftTests
@testable import SDGXcodeTests

extension SDGSwiftConfigurationTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testConfiguration", testConfiguration),
      ("testConfigurationError", testConfigurationError),
      ("testLegacyConfiguration", testLegacyConfiguration),
    ])
  ]
}

extension SDGSwiftConfigurationTests.InternalTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testLocalization", testLocalization)
    ])
  ]
}

extension SDGSwiftDocumentationExampleTests.ReadMeExampleTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testReadMe", testReadMe)
    ])
  ]
}

extension SDGSwiftPackageManagerTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testChangeDetection", testChangeDetection),
      ("testErrors", testErrors),
      ("testIgnoredFileDetection", testIgnoredFileDetection),
      ("testInitialization", testInitialization),
      ("testManifestLoading", testManifestLoading),
      ("testPackageGraphLoading", testPackageGraphLoading),
      ("testPackageLoading", testPackageLoading),
      ("testTestCoverage", testTestCoverage),
      ("testWorkspaceLoading", testWorkspaceLoading),
    ])
  ]
}

extension SDGSwiftPackageManagerTests.RegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testIgnoredFilesPreserveSpecialCharacters", testIgnoredFilesPreserveSpecialCharacters)
    ])
  ]
}

extension SDGSwiftSourceTests.APITests {
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
      ("testPackageAPI", testPackageAPI),
      ("testPackageDocumentation", testPackageDocumentation),
      ("testParsing", testParsing),
      ("testTokenSyntax", testTokenSyntax),
      ("testTree", testTree),
      ("testTriviaPiece", testTriviaPiece),
    ])
  ]
}

extension SDGSwiftSourceTests.InternalTests {
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

extension SDGSwiftSourceTests.RegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testCodeBlockWithCombiningCharacters", testCodeBlockWithCombiningCharacters),
      ("testContinuedCallout", testContinuedCallout),
      ("testMarkdownEntity", testMarkdownEntity),
      ("testMarkdownQuotation", testMarkdownQuotation),
      ("testPackageDeclaration", testPackageDeclaration),
    ])
  ]
}

extension SDGSwiftTests.APITests {
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

extension SDGSwiftTests.RegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testDependencyWarnings", testDependencyWarnings),
      ("testDynamicLinking", testDynamicLinking),
      ("testIgnoredFilesCheckIsStable", testIgnoredFilesCheckIsStable),
    ])
  ]
}

extension SDGXcodeTests.APITests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      ("testDependencyWarnings", testDependencyWarnings),
      ("testSwiftCompiler", testSwiftCompiler),
      ("testXcode", testXcode),
      ("testXcodeCoverage", testXcodeCoverage),
      ("testXcodeError", testXcodeError),
    ])
  ]
}

extension SDGXcodeTests.RegressionTests {
  static let windowsTests: [XCTestCaseEntry] = [
    testCase([
      (
        "testSchemeDetectionWithMutlipleLibrariesAndTool",
        testSchemeDetectionWithMutlipleLibrariesAndTool
      )
    ])
  ]
}

var tests = [XCTestCaseEntry]()
tests += SDGSwiftConfigurationTests.APITests.windowsTests
tests += SDGSwiftConfigurationTests.InternalTests.windowsTests
tests += SDGSwiftDocumentationExampleTests.ReadMeExampleTests.windowsTests
tests += SDGSwiftPackageManagerTests.APITests.windowsTests
tests += SDGSwiftPackageManagerTests.RegressionTests.windowsTests
tests += SDGSwiftSourceTests.APITests.windowsTests
tests += SDGSwiftSourceTests.InternalTests.windowsTests
tests += SDGSwiftSourceTests.RegressionTests.windowsTests
tests += SDGSwiftTests.APITests.windowsTests
tests += SDGSwiftTests.RegressionTests.windowsTests
tests += SDGXcodeTests.APITests.windowsTests
tests += SDGXcodeTests.RegressionTests.windowsTests

XCTMain(tests)
