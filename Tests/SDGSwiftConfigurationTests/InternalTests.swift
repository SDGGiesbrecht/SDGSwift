/*
 InternalTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLocalization

import SDGSwiftConfiguration
@testable import SDGSwiftConfigurationLoading

import SDGSwiftLocalizations

import SDGXCTestUtilities

import SDGSwiftTestUtilities

class InternalTests: SDGSwiftTestUtilities.TestCase {

  func testLocalization() {
    for localization in InterfaceLocalization.allCases {
      LocalizationSetting(orderOfPrecedence: [localization.code]).do {
        _ = Configuration.reportForNoConfigurationFound().resolved()
        _ = Configuration.reportForLoading(file: URL(fileURLWithPath: #filePath)).resolved()
      }
    }
  }

  func testResources() {
    _ = Resources.packageSwift
  }
}
