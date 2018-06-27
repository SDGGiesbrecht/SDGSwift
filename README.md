<!--
 README.md

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 -->

[🇨🇦EN](Documentation/🇨🇦EN%20Read%20Me.md) <!--Skip in Jazzy-->

macOS • Linux

APIs: [SDGSwift](https://sdggiesbrecht.github.io/SDGSwift/SDGSwift) • [SDGSwiftPackageManager](https://sdggiesbrecht.github.io/SDGSwift/SDGSwiftPackageManager) • [SDGXcode](https://sdggiesbrecht.github.io/SDGSwift/SDGXcode) • [SDGSwiftConfiguration](https://sdggiesbrecht.github.io/SDGSwift/SDGSwiftConfiguration) • [SDGSwiftConfigurationLoading](https://sdggiesbrecht.github.io/SDGSwift/SDGSwiftConfigurationLoading) • [SampleConfiguration](https://sdggiesbrecht.github.io/SDGSwift/SampleConfiguration)

# SDGSwift

SDGSwift enables use of the Swift compiler as a package dependency.

> [השֹּׁלֵחַ אִמְרָתוֹ אָרֶץ עַד־מְהֵרָה יָרוּץ דְּבָרוֹ׃<br>He sends His command to the earth; His word runs swiftly.](https://www.biblegateway.com/passage/?search=Psalm+147:15&version=WLC;NIV)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;―a psalmist

## Features

- Compiler operations such as building and testing: `SDGSwift`, `SDGXcode`
- Package Manager operations such as fetching and manifest loading: `SDGSwiftPackageManager`
- Utilities for defining configuration files written in Swift (similar to package manifests): `SDGSwiftConfiguration`, `SDGSwiftConfigurationLoading`

(For a list of related projects, see [here](Documentation/🇨🇦EN%20Related%20Projects.md).) <!--Skip in Jazzy-->

## Importing

SDGSwift provides libraries for use with the [Swift Package Manager](https://swift.org/package-manager/).

Simply add SDGSwift as a dependency in `Package.swift` and specify which of the libraries to use:

```swift
let package = Package(
    name: "MyPackage",
    dependencies: [
        .package(url: "https://github.com/SDGGiesbrecht/SDGSwift", .upToNextMinor(from: Version(0, 2, 0))),
    ],
    targets: [
        .target(name: "MyTarget", dependencies: [
            .productItem(name: "SDGSwift", package: "SDGSwift"),
            .productItem(name: "SDGSwiftPackageManager", package: "SDGSwift"),
            .productItem(name: "SDGXcode", package: "SDGSwift"),
            .productItem(name: "SDGSwiftConfiguration", package: "SDGSwift"),
            .productItem(name: "SDGSwiftConfigurationLoading", package: "SDGSwift"),
            .productItem(name: "SampleConfiguration", package: "SDGSwift"),
        ])
    ]
)
```

The libraries’ modules can then be imported in source files:

```swift
import SDGSwift
import SDGSwiftPackageManager
import SDGXcode
import SDGSwiftConfiguration
import SDGSwiftConfigurationLoading
import SampleConfiguration
```

## Example Usage

```swift
do {
    let package = Package(url: URL(string: "https://github.com/apple/example-package-dealer")!)
    try package.build(.version(Version(2, 0, 0)), to: temporaryDirectory)
} catch {
    XCTFail("\(error)")
}
```

## About

The SDGSwift project is maintained by Jeremy David Giesbrecht.

If SDGSwift saves you money, consider giving some of it as a [donation](https://paypal.me/JeremyGiesbrecht).

If SDGSwift saves you time, consider devoting some of it to [contributing](https://github.com/SDGGiesbrecht/SDGSwift) back to the project.

> [Ἄξιος γὰρ ὁ ἐργάτης τοῦ μισθοῦ αὐτοῦ ἐστι.<br>For the worker is worthy of his wages.](https://www.biblegateway.com/passage/?search=Luke+10&version=SBLGNT;NIV)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;―‎ישוע/Yeshuʼa
