/*
 Workspace.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import WorkspaceConfiguration

let configuration = WorkspaceConfiguration()
configuration.applySDGDefaults()

configuration.documentation.currentVersion = Version(0, 2, 1)

configuration.documentation.projectWebsite = URL(string: "https://sdggiesbrecht.github.io/SDGSwift/SDGSwift")!
configuration.documentation.documentationURL = URL(string: "https://sdggiesbrecht.github.io/SDGSwift")!
configuration.documentation.api.yearFirstPublished = 2018
configuration.documentation.repositoryURL = URL(string: "https://github.com/SDGGiesbrecht/SDGSwift")!

configuration.supportedOperatingSystems.remove(.iOS)
configuration.supportedOperatingSystems.remove(.watchOS)
configuration.supportedOperatingSystems.remove(.tvOS)

configuration.documentation.localizations = ["🇨🇦EN"]

configuration.documentation.readMe.shortProjectDescription["🇨🇦EN"] = "SDGSwift enables use of the Swift compiler as a package dependency."

configuration.documentation.readMe.quotation = Quotation(original: "השֹּׁלֵחַ אִמְרָתוֹ אָרֶץ עַד־מְהֵרָה יָרוּץ דְּבָרוֹ׃")
configuration.documentation.readMe.quotation?.translation["🇨🇦EN"] = "He sends His command to the earth; His word runs swiftly."
configuration.documentation.readMe.quotation?.link["🇨🇦EN"] = URL(string: "https://www.biblegateway.com/passage/?search=Psalm+147:15&version=WLC;NIV")!
configuration.documentation.readMe.quotation?.citation["🇨🇦EN"] = "a psalmist"

configuration.documentation.readMe.featureList["🇨🇦EN"] = [
    "\u{2D} Compiler operations such as building and testing: `SDGSwift`, `SDGXcode`",
    "\u{2D} Package Manager operations such as fetching and manifest loading: `SDGSwiftPackageManager`",
    "\u{2D} Utilities for defining configuration files written in Swift (similar to package manifests): `SDGSwiftConfiguration`, `SDGSwiftConfigurationLoading`"
].joinedAsLines()

configuration.documentation.readMe.exampleUsage["🇨🇦EN"] = "\u{23}example(readMe🇨🇦EN)"

configuration.documentation.api.encryptedTravisCIDeploymentKey = "UnR8vHpiMV+K/hw28327AUTPMi3Hz2l0lB4/kcMRacT3nklN8+PHCISUThkd+W1qy1fjHXjwcYvgIATzfhcZT6+AGT+Qn1O2nOJFs/6Y2XJvrhFOwvkSDh0JqcZYHNbsbpx4xk84nOV9/EHtNFHb9xLFT9cr0K+GaZfAHnDO5VLbUnSBqs0FxPDKv4P75lTmd3LbNfsPl3tfL/xDMCCcqf0zm5bO9JeRQVxTx8RWLe5q+Rw6a15IcFmFjptRdyjJmrDKIDAR/vNn2ytmfDwPlaz0a0Q1j5uH1/x1y6aIHVu+/2eLXEbm0s9hpPg+DOPUoNfrDLVqijpyXxAo6d/XAOb/yV6YYZhMUt5FgZ3936izSOAQ20JYrlf7fTX7IrfEq75fiLleEWs2YAvO/uUd8E0uICjpAW8vR2i90/mHqQHWCpRVET4OZjs8D8zibb4XBstBa6Ddj6ojGyo7N8rgdPztfiaml3FJ9JhNdFcG3JgOB1J1Bte8Ky+eOma5VFJeK8NpgZ+Bdi5QzSkmnBYoTKfZ1Ylq3rkcCUt9EDW0jYPtJ6vXbA6VnB80KI00t3869jsF6BDEzsCgxjcX4dSlWVVrhaU5bbI7a64HqoZx0x+0PKYS3RqHyx9YQfUTkjOoEIYz1Zv4kW4LU0+fO4D0kgWTVT9B2YOSqTgiDOJLLho="

configuration.applySDGOverrides()
configuration.validateSDGStandards()

// #workaround(workspace version 0.10.2, Until source specifications can be exempted by directory.)
configuration.proofreading.rules.remove(.parameterGrouping)
configuration.proofreading.rules.remove(.unicode)

// #workaround(workspace version 0.10.2, Jazzy’s redundant building is way too slow.)
configuration.documentation.api.generate = false
