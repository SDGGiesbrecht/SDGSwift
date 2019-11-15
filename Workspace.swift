/*
 Workspace.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import WorkspaceConfiguration

let configuration = WorkspaceConfiguration()
configuration._applySDGDefaults()

configuration.documentation.currentVersion = Version(0, 17, 0)

configuration.documentation.projectWebsite = URL(string: "https://sdggiesbrecht.github.io/SDGSwift")!
configuration.documentation.documentationURL = URL(string: "https://sdggiesbrecht.github.io/SDGSwift")!
configuration.documentation.api.yearFirstPublished = 2018
configuration.documentation.repositoryURL = URL(string: "https://github.com/SDGGiesbrecht/SDGSwift")!

configuration.supportedPlatforms.remove(.iOS)
configuration.supportedPlatforms.remove(.watchOS)
configuration.supportedPlatforms.remove(.tvOS)

configuration.documentation.localizations = ["🇨🇦EN"]

configuration.documentation.api.encryptedTravisCIDeploymentKey = "UnR8vHpiMV+K/hw28327AUTPMi3Hz2l0lB4/kcMRacT3nklN8+PHCISUThkd+W1qy1fjHXjwcYvgIATzfhcZT6+AGT+Qn1O2nOJFs/6Y2XJvrhFOwvkSDh0JqcZYHNbsbpx4xk84nOV9/EHtNFHb9xLFT9cr0K+GaZfAHnDO5VLbUnSBqs0FxPDKv4P75lTmd3LbNfsPl3tfL/xDMCCcqf0zm5bO9JeRQVxTx8RWLe5q+Rw6a15IcFmFjptRdyjJmrDKIDAR/vNn2ytmfDwPlaz0a0Q1j5uH1/x1y6aIHVu+/2eLXEbm0s9hpPg+DOPUoNfrDLVqijpyXxAo6d/XAOb/yV6YYZhMUt5FgZ3936izSOAQ20JYrlf7fTX7IrfEq75fiLleEWs2YAvO/uUd8E0uICjpAW8vR2i90/mHqQHWCpRVET4OZjs8D8zibb4XBstBa6Ddj6ojGyo7N8rgdPztfiaml3FJ9JhNdFcG3JgOB1J1Bte8Ky+eOma5VFJeK8NpgZ+Bdi5QzSkmnBYoTKfZ1Ylq3rkcCUt9EDW0jYPtJ6vXbA6VnB80KI00t3869jsF6BDEzsCgxjcX4dSlWVVrhaU5bbI7a64HqoZx0x+0PKYS3RqHyx9YQfUTkjOoEIYz1Zv4kW4LU0+fO4D0kgWTVT9B2YOSqTgiDOJLLho="

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
    "SwiftSyntax"
]
