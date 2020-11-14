/*
 Workspace.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import WorkspaceConfiguration

let configuration = WorkspaceConfiguration()
configuration._applySDGDefaults()

configuration.documentation.currentVersion = Version(3, 0, 3)

configuration.documentation.projectWebsite = URL(
  string: "https://sdggiesbrecht.github.io/SDGSwift"
)!
configuration.documentation.documentationURL = URL(
  string: "https://sdggiesbrecht.github.io/SDGSwift"
)!
configuration.documentation.api.yearFirstPublished = 2018
configuration.documentation.repositoryURL = URL(
  string: "https://github.com/SDGGiesbrecht/SDGSwift"
)!

// #workaround(SDGCornerstone 6.0.0, Until ExternalProcess is available.)
configuration.supportedPlatforms.remove(.iOS)
configuration.supportedPlatforms.remove(.watchOS)
configuration.supportedPlatforms.remove(.tvOS)

configuration.documentation.localizations = ["🇨🇦EN"]

configuration._applySDGOverrides()
configuration._validateSDGStandards()

configuration.repository.ignoredPaths.insert("Tests/Test Specifications/Source")
configuration.documentation.api.ignoredDependencies = [

  // CommonMark
  "CCommonMark",

  // SDGCornerstone
  "SDGCalendar",
  "SDGCollections",
  "SDGCornerstoneLocalizations",
  "SDGExternalProcess",
  "SDGLocalizationTestUtilities",
  "SDGLogic",
  "SDGLogicTestUtilities",
  "SDGMathematics",
  "SDGPersistence",
  "SDGPersistenceTestUtilities",
  "SDGVersioning",
  "SDGTesting",
  "SDGText",
  "SDGXCTestUtilities",

  // SDGWeb
  "SDGHTML",
  "SDGWebLocalizations",

  // llbuild
  "libllbuild",
  "llbuildBasic",
  "llbuildBuildSystem",
  "llbuildCore",
  "llbuildSwift",
  "llvmDemangle",
  "llvmSupport",

  // Swift
  "Dispatch",
  "Foundation",
  "XCTest",

  // SwiftPM
  "Basic",
  "Build",
  "clibc",
  "PackageGraph",
  "PackageLoading",
  "PackageModel",
  "POSIX",
  "SourceControl",
  "SPMLLBuild",
  "SPMLibc",
  "SPMUtility",
  "Workspace",
  "Xcodeproj",

  // SwiftSyntax
  "_CSwiftSyntax",
  "SwiftSyntax",
]

// #workaround(workspace version 0.35.2, Rule has false positives.)
configuration.proofreading.swiftFormatConfiguration?.rules["UseLetInEveryBoundCaseVariable"] = false
