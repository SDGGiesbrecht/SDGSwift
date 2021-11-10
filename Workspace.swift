/*
 Workspace.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import WorkspaceConfiguration

let configuration = WorkspaceConfiguration()
configuration._applySDGDefaults()

configuration.documentation.currentVersion = Version(8, 0, 3)

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

configuration.documentation.localizations = ["🇨🇦EN"]

configuration._applySDGOverrides()
configuration._validateSDGStandards()

configuration.repository.ignoredPaths.insert("Tests/Test Specifications/Source")
configuration.testing.exemptPaths.insert("Sources/SampleConfiguration")
configuration.documentation.api.ignoredDependencies = [

  // cmark
  "cmark",

  // llbuild
  "libllbuild",
  "llbuildBasic",
  "llbuildBuildSystem",
  "llbuildCore",
  "llbuildSwift",
  "llvmDemangle",
  "llvmSupport",

  // SDGCornerstone
  "SDGCalendar",
  "SDGCollections",
  "SDGCornerstoneLocalizations",
  "SDGExternalProcess",
  "SDGLocalizationTestUtilities",
  "SDGLogic",
  "SDGLogicTestUtilities",
  "SDGPersistence",
  "SDGPersistenceTestUtilities",
  "SDGVersioning",
  "SDGTesting",
  "SDGText",
  "SDGXCTestUtilities",

  // SDGWeb
  "SDGHTML",
  "SDGWebLocalizations",

  // Swift
  "Dispatch",
  "Foundation",
  "XCTest",

  // swift‐numerics
  "_NumericsShims",
  "RealModule",

  // swift‐tools‐support‐core
  "TSCBasic",
  "TSCclibc",
  "TSCLibc",
  "TSCUtility",

  // SwiftPM
  "Basic",
  "Build",
  "clibc",
  "LLBuildManifest",
  "PackageGraph",
  "PackageLoading",
  "PackageModel",
  "POSIX",
  "SourceControl",
  "SPMBuildCore",
  "SPMLLBuild",
  "SPMLibc",
  "SPMUtility",
  "Workspace",
  "Xcodeproj",

  // SwiftSyntax
  "_CSwiftSyntax",
  "SwiftSyntax",
]
