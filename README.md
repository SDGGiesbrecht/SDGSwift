<!--
 README.md

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 -->

macOS • Windows • Web • Linux • Android

[Documentation](https://sdggiesbrecht.github.io/SDGSwift/%F0%9F%87%A8%F0%9F%87%A6EN)

# SDGSwift

SDGSwift enables use of the Swift compiler as a package dependency.

> [השֹּׁלֵחַ אִמְרָתוֹ אָרֶץ עַד־מְהֵרָה יָרוּץ דְּבָרוֹ׃](https://www.biblegateway.com/passage/?search=Psalm+147:15&version=WLC;NIV)
>
> [He sends His command to the earth; His word runs swiftly.](https://www.biblegateway.com/passage/?search=Psalm+147:15&version=WLC;NIV)
>
> ―a psalmist

### Features

- Compiler operations such as building and testing: `SDGSwift`, `SDGXcode`
- Package Manager operations such as fetching and manifest loading: `SDGSwiftPackageManager`
- Utilities for defining configuration files written in Swift (similar to package manifests): `SDGSwiftConfiguration`, `SDGSwiftConfigurationLoading`

### Example Usage

```swift
let package = Package(
  url: URL(string: "https://github.com/apple/example\u{2D}package\u{2D}dealer")!
)
try package.build(.version(Version(2, 0, 0)), to: temporaryDirectory).get()
```

## Importing

SDGSwift provides libraries for use with the [Swift Package Manager](https://swift.org/package-manager/).

Simply add SDGSwift as a dependency in `Package.swift` and specify which of the libraries to use:

```swift
let package = Package(
    name: "MyPackage",
    dependencies: [
        .package(url: "https://github.com/SDGGiesbrecht/SDGSwift", from: Version(1, 0, 0)),
    ],
    targets: [
        .target(name: "MyTarget", dependencies: [
            .productItem(name: "SDGSwift", package: "SDGSwift"),
            .productItem(name: "SDGSwiftPackageManager", package: "SDGSwift"),
            .productItem(name: "SDGSwiftSource", package: "SDGSwift"),
            .productItem(name: "SDGXcode", package: "SDGSwift"),
            .productItem(name: "SDGSwiftConfiguration", package: "SDGSwift"),
            .productItem(name: "SDGSwiftConfigurationLoading", package: "SDGSwift"),
            .productItem(name: "SampleConfiguration", package: "SDGSwift"),
        ])
    ]
)
```

The modules can then be imported in source files:

```swift
import SDGSwift
import SDGSwiftPackageManager
import SDGSwiftSource
import SDGXcode
import SDGSwiftConfiguration
import SDGSwiftConfigurationLoading
import SampleConfiguration
```

## About

The SDGSwift project is maintained by Jeremy David Giesbrecht.

If SDGSwift saves you money, consider giving some of it as a [donation](https://paypal.me/JeremyGiesbrecht).

If SDGSwift saves you time, consider devoting some of it to [contributing](https://github.com/SDGGiesbrecht/SDGSwift) back to the project.

> [Ἄξιος γὰρ ὁ ἐργάτης τοῦ μισθοῦ αὐτοῦ ἐστι.](https://www.biblegateway.com/passage/?search=Luke+10&version=SBLGNT;NIV)
>
> [For the worker is worthy of his wages.](https://www.biblegateway.com/passage/?search=Luke+10&version=SBLGNT;NIV)
>
> ―‎ישוע/Yeshuʼa
